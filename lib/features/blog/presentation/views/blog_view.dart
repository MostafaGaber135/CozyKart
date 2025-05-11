import 'package:flutter/material.dart';
import 'package:furni_iti/core/widgets/main_scaffold.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});
  static const String routeName = '/BlogView';

  @override
  Widget build(BuildContext context) {
    return MainScaffold(body: Center(child: Text('Blog View')), title: 'Blog');
  }
}
