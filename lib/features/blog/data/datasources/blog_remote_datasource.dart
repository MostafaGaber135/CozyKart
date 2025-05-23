import 'package:cozykart/core/network/dio_helper.dart';
import 'package:cozykart/features/blog/data/models/post_model.dart';

class BlogRemoteDataSource {
  Future<List<PostModel>> getPosts(int page, int limit) async {
    try {
      final response = await DioHelper.dio.get(
        'posts',
        queryParameters: {'page': page, 'limit': limit},
      );

      final List<dynamic> postsJson = response.data['posts'] ?? [];
      return postsJson.map((json) => PostModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }
}
