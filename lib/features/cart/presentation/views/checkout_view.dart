import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:dio/dio.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';

class CheckoutView extends StatefulWidget {
  final List<dynamic> cartItems;
  final double total;

  const CheckoutView({super.key, required this.cartItems, required this.total});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  double egpToUsd(dynamic egp) {
    if (egp is int) return egp.toDouble() / 45;
    if (egp is double) return egp / 45;
    return 0;
  }

  void _startPaypalCheckout() {
    final usdTotal = egpToUsd(widget.total).toStringAsFixed(2);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (BuildContext context) => PaypalCheckoutView(
              sandboxMode: true,
              clientId: "YOUR_SANDBOX_CLIENT_ID",
              secretKey: "YOUR_SANDBOX_SECRET",
              transactions: [
                {
                  "amount": {
                    "total": usdTotal,
                    "currency": "USD",
                    "details": {
                      "subtotal": usdTotal,
                      "shipping": '0',
                      "shipping_discount": 0,
                    },
                  },
                  "description": "Furniture order via CozyKart.",
                  "item_list": {
                    "items":
                        widget.cartItems.map((item) {
                          final product = item['product'];
                          final quantity = item['quantity'];
                          final price = item['priceAtAddition'];
                          return {
                            "name": product['name']?['en'] ?? "Unnamed Product",
                            "quantity": quantity.toString(),
                            "price": egpToUsd(price).toStringAsFixed(2),
                            "currency": "USD",
                          };
                        }).toList(),
                  },
                },
              ],
              note: "Thanks for your order!",
              onSuccess: (Map params) async {
                log("✅ Payment success: $params");

                final shippingAddress = {
                  "fullName": nameController.text,
                  "street": addressController.text,
                  "city": cityController.text,
                  "postalCode": postalCodeController.text,
                  "phone": phoneController.text,
                  "country": "Egypt",
                };

                final order = {
                  "shippingAddress": shippingAddress,
                  "paymentMethod": "paypal",
                  "paypalOrderId": params['data']['id'],
                  "products":
                      widget.cartItems.map((item) {
                        return {
                          "productId": item["product"]['_id'],
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
                    log("✅ Order saved");
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  } else {
                    log("❌ Failed to save order: ${response.statusCode}");
                  }
                } catch (e) {
                  log("❌ Exception: $e");
                }
              },
              onError: (error) {
                log("❌ PayPal Error: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                log("🛑 Payment cancelled");
                Navigator.pop(context);
              },
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
              ),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(labelText: "City"),
              ),
              TextFormField(
                controller: postalCodeController,
                decoration: const InputDecoration(labelText: "Postal Code"),
              ),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _startPaypalCheckout();
                  }
                },
                child: const Text("Pay with PayPal"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
