import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/profile/presentation/views/edit_profile_view.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/help_page.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/privacy_page.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/profile_action_card.dart';
import 'package:furni_iti/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:furni_iti/features/profile/presentation/cubit/profile_state.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});
  static const String routeName = '/ProfileViewBody';

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadUser(); // تحميل البيانات عند فتح الصفحة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final user =
                state is ProfileLoaded
                    ? state.user
                    : (state is ProfileUpdated ? state.updatedUser : null);

            if (user == null) {
              return const Center(child: Text("User not found"));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: AppColors.primaryAccent,
                    backgroundImage: NetworkImage(user.image ?? ''),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.nameEn,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Column(
                      children: [
                        ProfileActionCard(
                          onTap: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditProfileView(),
                              ),
                            );
                            if (!context.mounted) return;
                            if (updated == true) {
                              context.read<ProfileCubit>().loadUser();
                            }
                          },
                          icon: Icons.edit,
                          title: 'Edit Profile',
                        ),
                        const SizedBox(height: 16),
                        ProfileActionCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PrivacyPage(),
                              ),
                            );
                          },
                          icon: Icons.security,
                          title: 'Privacy',
                        ),
                        const SizedBox(height: 16),
                        ProfileActionCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HelpPage(),
                              ),
                            );
                          },
                          icon: Icons.help_outline,
                          title: 'Help',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      title: 'Logout',
                      onPressed: () async {
                        await SharedPrefsHelper.clearToken();
                        await SharedPrefsHelper.removeUserId();
                        await SharedPrefsHelper.clearUser();
                        if (!context.mounted) return;
                        Navigator.pushReplacementNamed(
                          context,
                          LoginView.routeName,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
