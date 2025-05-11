import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/widgets/custom_elevated_button.dart';
import 'package:furni_iti/core/widgets/main_scaffold.dart';
import 'package:furni_iti/features/contact_us/presentation/views/widgets/custom_text_field.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class ContactUsView extends StatefulWidget {
  const ContactUsView({super.key});
  static const String routeName = '/ContactUsView';

  @override
  State<ContactUsView> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends State<ContactUsView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  Future<void> sendEmail() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please fill all fields",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
      return;
    }

    String username = 'mostafagaber1234560@gmail.com';
    String password = 'utbt mkxg wbkg hevn';

    final smtpServer = gmail(username, password);

    final emailMessage =
        Message()
          ..from = Address(username, 'FurniITI')
          ..recipients.add('mostafagaber1234560@gmail.com')
          ..subject = 'Contact from $name'
          ..text = 'Name: $name\nEmail: $email\n\nMessage:\n$message';

    try {
      await send(emailMessage, smtpServer);
      Fluttertoast.showToast(
        msg: "Email sent successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } on MailerException catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to send email",
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
      );
      for (var p in e.problems) {
        log('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CustomTextField(label: 'Name', controller: nameController),
            const SizedBox(height: 16),
            CustomTextField(label: 'Email', controller: emailController),
            const SizedBox(height: 16),
            CustomTextField(
              label: 'Subject',
              controller: messageController,
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(title: 'Send', onPressed: sendEmail),
            ),
          ],
        ),
      ),
      title: 'Contact Us',
    );
  }
}
