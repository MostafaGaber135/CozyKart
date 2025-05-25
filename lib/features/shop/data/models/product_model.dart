import 'package:flutter/material.dart';

class Product {
  final String id;
  final String image;
  final Map<String, dynamic> nameMap;
  final Map<String, dynamic> descriptionMap;
  final double price;
  int quantity;

  Product({
    required this.id,
    required this.image,
    required this.nameMap,
    required this.descriptionMap,
    required this.price,
    this.quantity = 1,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    // ✅ تعديل يدوي يدعم الاثنين: المباشر أو المضمن في productId
    final productJson =
        json.containsKey('variants') ? json : json['productId'] ?? {};

    final variants = productJson['variants'] as List?;
    final variant =
        (variants != null && variants.isNotEmpty) ? variants.first : null;

    return Product(
      id: productJson['_id'] ?? '',
      image: variant?['image'] ?? productJson['image'] ?? '',
      nameMap: Map<String, dynamic>.from(
        variant?['name'] ??
            productJson['name'] ??
            {'en': 'Unnamed', 'ar': 'بدون اسم'},
      ),
      descriptionMap: Map<String, dynamic>.from(
        productJson['description'] ?? {'en': '', 'ar': ''},
      ),
      price: (variant?['price'] ?? productJson['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
    );
  }

  String localizedName(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return nameMap[lang] ?? nameMap['en'] ?? 'Unknown';
  }

  String localizedDescription(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;
    return descriptionMap[lang] ?? descriptionMap['en'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': nameMap,
      'description': descriptionMap,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
