import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/features/blog/domain/entities/post.dart';
import 'package:furni_iti/generated/l10n.dart';

class PostDetailsViewBody extends StatelessWidget {
  final Post post;
  const PostDetailsViewBody({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: post.image,
            height: 200.h,
            width: (double.infinity).w,
            fit: BoxFit.cover,
            progressIndicatorBuilder:
                (context, url, downloadProgress) => Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: AppColors.primaryAccent,
                  ),
                ),
            errorWidget:
                (context, url, error) => Icon(Icons.error, size: 80.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            post.title[lang] ?? post.title['en'] ?? '',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            post.description[lang] ?? post.description['en'] ?? '',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            S.of(context).byAuthor(post.author),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              const Icon(Icons.favorite, color: Colors.red),
              SizedBox(width: 4.w),
              Text(post.likes.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
