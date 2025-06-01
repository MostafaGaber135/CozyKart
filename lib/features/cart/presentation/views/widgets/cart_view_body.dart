import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/services/cart_service.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/toast_helper.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/shop/data/models/product_model.dart';
import 'package:furni_iti/generated/l10n.dart';
import 'cart_item_widget.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  List<dynamic> cartItems = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    try {
      final items = await CartService().getCart();
      setState(() {
        cartItems = items;
        calculateTotal();
      });
    } catch (e) {
      log('Error loading cart: $e');
    }
  }

  void calculateTotal() {
    total = 0;
    for (var item in cartItems) {
      final product = item['product'];
      final price = item['priceAtAddition'] ?? product?['price'] ?? 0;
      final quantity = item['quantity'] ?? 1;
      total += price * quantity;
    }
  }

  Future<void> deleteItem(String cartItemId) async {
    try {
      await CartService().removeFromCart(cartItemId);
      setState(() {
        cartItems.removeWhere((item) => item['_id'] == cartItemId);
        showToast('Item removed from cart', isError: true);
        calculateTotal();
      });
    } catch (e) {
      log("Error deleting item: $e");
    }
  }

  Future<void> updateItemQuantity(String cartItemId, int quantity) async {
    await CartService().updateQuantity(cartItemId, quantity);
    await loadCart();
  }

  void _startPaypalCheckout() {
    final items =
        cartItems.map((item) {
          final product = item['product'];
          final quantity = item['quantity'];
          final priceusd = item['priceAtAddition'];

          return {
            "name": product['name']?['en'] ?? "Unnamed Product",
            "quantity": quantity.toString(),
            "price": priceusd.toStringAsFixed(2), 
            "currency": "USD", 
          };
        }).toList();

    double subtotal = 0;
    for (var item in items) {
      subtotal += double.parse(item['price']) * int.parse(item['quantity']);
    }

    final totalFormatted = subtotal.toStringAsFixed(2);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (BuildContext context) => PaypalCheckoutView(
              sandboxMode: true,
              clientId:
                  "AYSDaD8ZjfGIQ2w04v3OtLXP6VtsH2CklFd6zJGhY2zc0OdeG--3H78jGCBn_9zhyvXvS54mkurQIzmi",
              secretKey:
                  "ECnQhOKy4U5jVJM3rB9HrXfGO-Nr8kqSTq8F6P-LcxobtY7BxYEJBIzDOraYKn7e78wkNukORBJPz8Oe",
              transactions: [
                {
                  "amount": {
                    "total": totalFormatted,
                    "currency": "USD",
                    "details": {
                      "subtotal": totalFormatted,
                      "shipping": '0',
                      "shipping_discount": 0,
                    },
                  },
                  "description": "Furniture order via CozyKart.",
                  "item_list": {"items": items},
                },
              ],
              note: "Thanks for your order!",
              onSuccess: (Map params) async {
                final shippingAddress = {
                  "fullName": "Flutter User",
                  "street": "123 Main St",
                  "city": "Cairo",
                  "state": "Cairo",
                  "postalCode": "12345",
                  "phone": "+201000000000",
                  "country": "Egypt",
                };

                final order = {
                  "shippingAddress": shippingAddress,
                  "paymentMethod": "paypal",
                  "paypalOrderId": params['data']['id'],
                  "products":
                      cartItems.map((item) {
                        return {
                          "productId": item["product"]["_id"],
                          "quantity": item["quantity"],
                          "priceAtPurchase": item["priceAtAddition"],
                        };
                      }).toList(),
                };

                try {
                  final token = await SharedPrefsHelper.getToken();
                  final response = await Dio().post(
                    "https://furniture-nodejs-production-665a.up.railway.app/orders",
                    data: order,
                    options: Options(
                      headers: {"Authorization": "Bearer $token"},
                    ),
                  );

                  if (response.statusCode == 201) {
                    log("Order saved");
                    showToast('Order saved successfully');
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  } else {
                    log("Failed to save order: ${response.statusCode}");
                  }
                } catch (e) {
                  log("Exception: $e");
                }
              },
              onError: (error) {
                log("PayPal Error: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                log("Payment cancelled");
                Navigator.pop(context);
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isEmpty) {
      return Center(
        child: Text(
          S.of(context).yourCartIsEmpty,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              final cartItemId = item['_id'];
              final productJson = item['product'];
              final quantity = item['quantity'] ?? 1;
              final product = Product.fromJson(productJson);
              product.quantity = quantity;

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                child: CartItemWidget(
                  product: product,
                  onRemove: () => deleteItem(cartItemId),
                  onQuantityChange:
                      (newQty) => updateItemQuantity(cartItemId, newQty),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            "${S.of(context).total}: $total ${S.of(context).usd}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            title: S.of(context).checkoutButton,
            onPressed: _startPaypalCheckout,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
