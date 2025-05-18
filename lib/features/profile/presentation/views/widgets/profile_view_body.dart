import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/profile/presentation/views/edit_profile_view.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/help_page.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/privacy_page.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/profile_action_card.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});
  static const String routeName = '/ProfileViewBody';

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  String username = '';
  String email = '';
  String image = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    username = await SharedPrefsHelper.getString('username');
    email = await SharedPrefsHelper.getString('email');
    image = await SharedPrefsHelper.getString('image');
    log('📌 Username: $username');
    log('📌 Email: $email');
    log('📌 Image: $image');

    setState(() {
      log('📌 SET STATE TRIGGERED');
    });
  }

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
                  backgroundImage:
                      image.isNotEmpty
                          ? NetworkImage(image)
                          : const AssetImage('assets/images/person.png')
                              as ImageProvider,
                ),
              ),
              SizedBox(height: 8),
              Text(
                username.isNotEmpty ? username : 'Guest',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                email,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
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
