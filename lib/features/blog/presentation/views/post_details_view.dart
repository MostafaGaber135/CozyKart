import 'package:flutter/material.dart';
import 'package:cozykart/features/blog/domain/entities/post.dart';
import 'package:cozykart/features/blog/presentation/views/widgets/post_details_view_body.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;
  const PostDetailsView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title[lang] ?? post.title['en'] ?? 'Post Details'),
      ),
      body: PostDetailsViewBody(post: post),
    );
  }
}
