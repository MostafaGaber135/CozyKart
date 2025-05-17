import 'package:flutter/material.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/profile/presentation/views/edit_profile_view.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/help_page.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/privacy_page.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/profile_action_card.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});
  static const String routeName = '/ProfileViewBody';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: AppColors.primaryAccent,
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/person.png'),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Mostafa Gaber',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                'mostafagaber1234560@gmail.com',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(height: 32),

              Expanded(
                child: Column(
                  children: [
                    ProfileActionCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const EditProfileView(),
                          ),
                        );
                      },
                      icon: Icons.edit,
                      title: 'Edit Profile',
                    ),
                    SizedBox(height: 16),
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
                    SizedBox(height: 16),
                    ProfileActionCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HelpPage()),
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
        ),
      ),
    );
  }
}
