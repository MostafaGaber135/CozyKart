import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/features/blog/domain/entities/post.dart';

class PostDetailsViewBody extends StatelessWidget {
  final Post post;
  const PostDetailsViewBody({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: post.image,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            progressIndicatorBuilder:
                (context, url, downloadProgress) => Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: AppColors.primaryAccent,
                  ),
                ),
            errorWidget:
                (context, url, error) => const Icon(Icons.error, size: 80),
          ),
          const SizedBox(height: 16),
          Text(
            post.title['en'] ?? '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            post.title['ar'] ?? '',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "by ${post.author}",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          Divider(color: AppColors.hintGrey, thickness: 1),
          const SizedBox(height: 16),

          Text(
            post.description['en'] ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          Text(
            post.description['ar'] ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.red),
              const SizedBox(width: 4),
              Text(post.likes.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
