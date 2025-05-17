import 'package:flutter/material.dart';
import 'package:furni_iti/core/widgets/custom_elevated_button.dart';

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key, required this.total});
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '${total.toStringAsFixed(2)} EGP',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,

          child: CustomElevatedButton(title: 'Checkout', onPressed: () {}),
        ),
      ],
    );
  }
}
