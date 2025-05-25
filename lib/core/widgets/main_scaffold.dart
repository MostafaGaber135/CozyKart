import 'package:flutter/material.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key, required this.body, required this.title});
  final Widget body;
  final String title;
  static const String routeName = '/mainScaffold';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)), body: body);
  }
}
