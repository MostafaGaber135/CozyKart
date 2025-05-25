import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/blog/domain/entities/post.dart';
import 'package:furni_iti/features/blog/domain/repositories/blog_repository.dart';
import 'package:furni_iti/features/blog/presentation/cubit/blog_state.dart';

class BlogCubit extends Cubit<BlogState> {
  final BlogRepository blogRepository;
  int currentPage = 1;
  final int limit = 10;
  bool isLoadingMore = false;
  List<Post> allPosts = [];

  BlogCubit(this.blogRepository) : super(BlogInitial());

  void getPosts() async {
    emit(BlogLoading());
    try {
      final posts = await blogRepository.getPosts(currentPage, limit);
      allPosts = posts;
      emit(BlogLoaded(allPosts));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
  }

  void loadMorePosts() async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    currentPage++;
    try {
      final morePosts = await blogRepository.getPosts(currentPage, limit);
      allPosts.addAll(morePosts);
      emit(BlogLoaded(List.from(allPosts)));
    } catch (e) {
      emit(BlogError(e.toString()));
    }
    isLoadingMore = false;
  }

  void refreshPosts() async {
    currentPage = 1;
    getPosts();
  }
}
