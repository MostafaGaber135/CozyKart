import 'package:flutter/material.dart';
import 'package:furni_iti/core/services/paypal_service.dart';
import 'package:furni_iti/core/widgets/custom_text_button.dart';
import 'paypal_webview.dart';

class PaymentViewBody extends StatefulWidget {
  const PaymentViewBody({super.key});

  @override
  State<PaymentViewBody> createState() => _PaymentViewBodyState();
}

class _PaymentViewBodyState extends State<PaymentViewBody> {
  Future<void> _startPayment() async {
    final token = await PayPalService.getAccessToken();
    if (token == null || !mounted) return;

    final orderId = await PayPalService.createOrder(token, "50.00");
    if (orderId == null || !mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => PaypalWebView(
              checkoutUrl:
                  "https://www.sandbox.paypal.com/checkoutnow?token=$orderId",
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PayPal Payment")),
      body: Center(
        child: CustomTextButton(
          onPressed: _startPayment,
          text: "Pay with PayPal",
        ),
      ),
    );
  }
}
