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
    final variants = json['variants'] as List?;
    final variant =
        (variants != null && variants.isNotEmpty) ? variants.first : null;

    return Product(
      id: json['_id'] ?? json['id'] ?? '',
      nameMap: Map<String, dynamic>.from(
        variant?['name'] ?? json['name'] ?? {'en': 'Unnamed', 'ar': 'بدون اسم'},
      ),
      descriptionMap: Map<String, dynamic>.from(
        json['description'] ?? {'en': '', 'ar': ''},
      ),
      price:
          (variant?['price'] as num?)?.toDouble() ??
          (json['price'] as num?)?.toDouble() ??
          0.0,
      image: variant?['image'] ?? json['image'] ?? '',
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
