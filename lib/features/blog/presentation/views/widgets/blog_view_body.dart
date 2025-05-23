import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:cozykart/features/blog/presentation/cubit/blog_state.dart';
import 'package:cozykart/features/blog/presentation/views/widgets/post_card.dart';
import 'package:cozykart/generated/l10n.dart';

class BlogViewBody extends StatelessWidget {
  const BlogViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(S.of(context).blogTitle),
      ),

      body: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primaryAccent),
            );
          } else if (state is BlogLoaded) {
            return RefreshIndicator(
              color: AppColors.primaryAccent,
              onRefresh: () async => context.read<BlogCubit>().refreshPosts(),
              child: NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification.metrics.pixels >=
                      notification.metrics.maxScrollExtent - 200) {
                    context.read<BlogCubit>().loadMorePosts();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostCard(post: post);
                  },
                ),
              ),
            );
          } else if (state is BlogError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
