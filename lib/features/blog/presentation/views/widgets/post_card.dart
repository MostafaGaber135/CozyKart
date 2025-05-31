import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/lang_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/blog/domain/entities/post.dart';
import 'package:furni_iti/features/blog/presentation/views/post_details_view.dart';
import 'package:furni_iti/generated/l10n.dart';

class PostCard extends StatelessWidget {
  final Post post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.r),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: post.image,
                height: 150.h,
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
            ),
            SizedBox(height: 12.h),

            Text(
              getLocalizedValue(post.title, context),
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),

            SizedBox(height: 6.h),
            Text(
              S.of(context).byAuthor(post.author),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    getLocalizedValue(post.description, context),
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.favorite_border, size: 18.sp),
                    SizedBox(width: 4.w),
                    Text(post.likes.length.toString()),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15.h),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  title: S.of(context).readMore,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailsView(post: post),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
