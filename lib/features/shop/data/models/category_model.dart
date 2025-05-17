class CategoryModel {
  final String id;
  final Name name;
  final Name description;
  final List<String> subcategoriesId;
  final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.subcategoriesId,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['_id'] ?? '',
      name: Name.fromJson(json['name'] ?? {}),
      description: Name.fromJson(json['description'] ?? {}),
      subcategoriesId: List<String>.from(json['subcategoriesId'] ?? []),
      image: json['image'],
    );
  }
}

class Name {
  final String en;
  final String ar;

  Name({
    required this.en,
    required this.ar,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      en: json['en'] ?? '',
      ar: json['ar'] ?? '',
    );
  }
}
