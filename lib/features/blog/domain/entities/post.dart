class Post {
  final String id;
  final String image;
  final Map<String, String> title;
  final Map<String, String> description;
  final String author;
  final int likes;

  Post({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.author,
    required this.likes,
  });
}
