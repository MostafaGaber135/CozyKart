import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/widgets/main_scaffold.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});
  static const String routeName = '/SettingsViewBody';
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    return MainScaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dark Theme',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color:
                        settingsProvider.isDark
                            ? AppColors.darkText
                            : AppColors.primaryAccent,
                  ),
                ),
                Switch.adaptive(
                  value: settingsProvider.themeMode == ThemeMode.dark,
                  onChanged:
                      (isDark) => settingsProvider.changeTheme(
                        isDark ? ThemeMode.dark : ThemeMode.light,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
      title: 'Settings',
    );
  }
}
