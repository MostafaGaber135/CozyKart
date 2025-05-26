import 'package:furni_iti/features/shop/data/models/product_model.dart';

class WishlistService {
  static final WishlistService _instance = WishlistService._internal();
  factory WishlistService() => _instance;
  WishlistService._internal();

  final List<Product> _wishlist = [];

  List<Product> get wishlist => _wishlist;

  bool isInWishlist(Product product) {
    return _wishlist.any((item) => item.id == product.id);
  }

  void addToWishlist(Product product) {
    if (!isInWishlist(product)) {
      _wishlist.add(product);
    }
  }

  void removeFromWishlist(Product product) {
    _wishlist.removeWhere((item) => item.id == product.id);
  }

  void toggleWishlist(Product product) {
    if (isInWishlist(product)) {
      removeFromWishlist(product);
    } else {
      addToWishlist(product);
    }
  }
}