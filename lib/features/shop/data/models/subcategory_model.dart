class SubcategoryModel {
  final String id;
  final String name;
  final String? categoryId;

  SubcategoryModel({required this.id, required this.name, this.categoryId});

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    return SubcategoryModel(
      id: json['_id'] ?? '',
      name: json['name']['en'] ?? '',
      categoryId:
          json['categoryId']?.toString() ??
          (json['categoriesId'] != null
              ? json['categoriesId']['_id']?.toString()
              : ''),
    );
  }
}
