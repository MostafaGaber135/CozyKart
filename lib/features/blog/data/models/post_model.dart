import 'package:furni_iti/features/blog/domain/entities/post.dart';
class PostModel extends Post {
  PostModel({
    required super.id,
    required super.image,
    required super.title,
    required super.description,
    required super.author,
    required super.likes,
    required super.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] ?? '',
      image: json['image'] ?? '',
      title: Map<String, String>.from(json['title'] ?? {}),
      description: Map<String, String>.from(json['description'] ?? {}),
      author: json['author'] ?? '',
      likes: List<Map<String, dynamic>>.from(json['likes'] ?? []),
      comments: List<Map<String, dynamic>>.from(json['comments'] ?? []),
    );
  }
}
