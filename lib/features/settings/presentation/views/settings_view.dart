import 'package:flutter/material.dart';
import 'package:cozykart/features/settings/presentation/views/widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  static const String routeName = '/SettingsView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const SettingsViewBody());
  }
}
