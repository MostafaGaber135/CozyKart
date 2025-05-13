import 'package:flutter/material.dart';
import 'package:furni_iti/features/blog/presentation/views/widgets/blog_view_body.dart';

class BlogView extends StatelessWidget {
  const BlogView({super.key});
  static const String routeName = '/BlogView';

  @override
  Widget build(BuildContext context) {
    return BlogViewBody();
  }
}
