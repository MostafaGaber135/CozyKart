import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/core/widgets/primary_button.dart';
import 'package:cozykart/features/auth/presentation/views/login_view.dart';
import 'package:cozykart/features/profile/presentation/views/edit_profile_view.dart';
import 'package:cozykart/features/profile/presentation/views/widgets/help_page.dart';
import 'package:cozykart/features/profile/presentation/views/widgets/privacy_page.dart';
import 'package:cozykart/features/profile/presentation/views/widgets/profile_action_card.dart';
import 'package:cozykart/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cozykart/features/profile/presentation/cubit/profile_state.dart';
import 'package:cozykart/generated/l10n.dart';

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
    context.read<ProfileCubit>().loadUser();
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
              return Center(child: Text(S.of(context).userNotFound));
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 38.r,
                    backgroundColor: AppColors.primaryAccent,
                    backgroundImage: NetworkImage(user.image ?? ''),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    Localizations.localeOf(context).languageCode == 'ar'
                        ? user.nameAr
                        : user.nameEn,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 4.h),
                  Text(
                    user.email,
                    style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                  ),
                  SizedBox(height: 32.h),
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
                          title: S.of(context).editProfile,
                        ),
                        SizedBox(height: 16.h),
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
                          title: S.of(context).privacy,
                        ),
                        SizedBox(height: 16.h),
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
                          title: S.of(context).help,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      title: S.of(context).logout,
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
