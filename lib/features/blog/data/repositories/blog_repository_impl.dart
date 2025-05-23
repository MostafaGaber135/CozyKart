import 'package:cozykart/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:cozykart/features/blog/domain/entities/post.dart';
import 'package:cozykart/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;

  BlogRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Post>> getPosts(int page, int limit) async {
    return remoteDataSource.getPosts(page, limit);
  }
}
