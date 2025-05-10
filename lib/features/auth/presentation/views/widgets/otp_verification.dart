import 'package:flutter/material.dart';
import 'package:furni_iti/core/widgets/custom_elevated_button.dart';

class OtpVerification extends StatelessWidget {
  const OtpVerification({super.key});
  static const String routeName = '/OtpVerification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_user_outlined,
                size: 80,
                color: Color(0xFF2E4A4A),
              ),
              const SizedBox(height: 42),
              const Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E4A4A),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Enter the code sent to\nyour email address',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 42),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFF2E4A4A),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 42),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(title: 'VERIFY', onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
