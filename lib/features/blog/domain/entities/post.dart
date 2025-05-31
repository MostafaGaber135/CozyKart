class Post {
  final String id;
  final String image;
  final Map<String, String> title;
  final Map<String, String> description;
  final String author;
  final List<Map<String, dynamic>> likes;
  final List<Map<String, dynamic>> comments;

  Post({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.author,
    required this.likes,
    required this.comments,
  });
}
