import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String> labels;

  const CustomTabBar({
    super.key,
    required this.controller,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: Container(
        margin: EdgeInsets.only(bottom: 6),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 12),
        child: TabBar(
          controller: controller,
          isScrollable: true,
          indicator: BoxDecoration(
            color: AppColors.primaryAccent,
            borderRadius: BorderRadius.circular(25),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: AppColors.primaryAccent,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          dividerColor: Colors.transparent,
          tabs:
              labels
                  .map(
                    (label) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Tab(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryAccent),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(label),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
