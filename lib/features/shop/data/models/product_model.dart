import 'dart:developer';

class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('id') &&
        json.containsKey('name') &&
        json.containsKey('price')) {
      return Product(
        id: json['id'] ?? '',
        name: json['name'] ?? 'Unnamed',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        image: json['image'] ?? '',
        quantity: json['quantity'] ?? 1,
      );
    }

    final variants = json['variants'] as List?;
    if (variants == null || variants.isEmpty) {
      return Product(
        id: json['_id'] ?? '',
        name: 'No Variant',
        price: 0.0,
        image: '',
        quantity: json['quantity'] ?? 1,
      );
    }

    final variant = variants.firstWhere(
      (v) =>
          v['name'] is Map &&
          v['name']['en'] != null &&
          v['price'] != null &&
          v['image'] != null,
      orElse: () => variants[0],
    );

    final name =
        variant['name'] is Map ? variant['name']['en'] : variant['name'];

    log('Product loaded: $name');

    return Product(
      id: json['_id'] ?? json['id'] ?? '',
      name: name ?? 'Unnamed',
      price: (variant['price'] as num?)?.toDouble() ?? 0.0,
      image: variant['image'] ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'quantity': quantity,
    };
  }
}
