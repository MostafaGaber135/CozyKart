import 'package:equatable/equatable.dart';
import 'package:furni_iti/features/blog/domain/entities/post.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<Post> posts;
  const BlogLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class BlogError extends BlogState {
  final String message;
  const BlogError(this.message);

  @override
  List<Object> get props => [message];
}
