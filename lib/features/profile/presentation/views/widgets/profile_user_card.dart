import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';

class ProfileUserCard extends StatelessWidget {
  final String imagePath;
  final String userName;
  final String email;

  const ProfileUserCard({
    super.key,
    required this.imagePath,
    required this.userName,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 26,
            backgroundColor: AppColors.primaryAccent,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
