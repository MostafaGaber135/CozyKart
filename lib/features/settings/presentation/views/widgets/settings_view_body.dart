import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/core/widgets/main_scaffold.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:furni_iti/generated/l10n.dart';
import 'package:provider/provider.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});
  static const String routeName = '/SettingsViewBody';
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final local = S.of(context);
    return MainScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).darkTheme,
                  style: AppTextStyles.bold16.copyWith(
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
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).darkTheme,
                  style: AppTextStyles.bold16.copyWith(
                    color:
                        settingsProvider.isDark
                            ? AppColors.darkText
                            : AppColors.primaryAccent,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DropdownButton<String>(
                    value: settingsProvider.currentLanguage?.languageCode,
                    borderRadius: BorderRadius.circular(16.r),
                    items: [
                      DropdownMenuItem(
                        value: 'en',
                        child: Text(
                          'English',
                          style: AppTextStyles.bold16.copyWith(
                            color:
                                settingsProvider.isDark
                                    ? AppColors.darkText
                                    : AppColors.primaryAccent,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Text(
                          'Arabic',
                          style: AppTextStyles.bold16.copyWith(
                            color:
                                settingsProvider.isDark
                                    ? AppColors.darkText
                                    : AppColors.primaryAccent,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (String? newLanguage) {
                      if (newLanguage != null) {
                        Locale newLocale = Locale(newLanguage);
                        settingsProvider.setLanguage(newLocale);
                      }
                    },
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
      title: local.settings,
    );
  }
}
