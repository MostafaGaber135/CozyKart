import 'package:furni_iti/features/blog/domain/entities/post.dart';

abstract class BlogRepository {
  Future<List<Post>> getPosts(int page, int limit);
}
