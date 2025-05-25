import 'package:flutter/material.dart';
import 'package:furni_iti/features/settings/presentation/views/widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const String routeName = '/SettingsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const SettingsViewBody());
  }
}
