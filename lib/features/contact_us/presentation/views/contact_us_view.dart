import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/widgets/main_scaffold.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/features/contact_us/presentation/views/widgets/contact_input_field.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:furni_iti/generated/l10n.dart';

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
    final local = S.of(context);
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final message = messageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      Fluttertoast.showToast(
        msg: local.fillAllFields,
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
          ..from = Address(username, 'ℂ𝑜𝓏𝘺𝐾𝓪𝕣𝘵')
          ..recipients.add(username)
          ..subject = 'Contact from $name'
          ..text = 'Name: $name\nEmail: $email\n\nMessage:\n$message';

    try {
      await send(emailMessage, smtpServer);
      Fluttertoast.showToast(
        msg: local.emailSentSuccess,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      nameController.clear();
      emailController.clear();
      messageController.clear();
    } on MailerException catch (e) {
      Fluttertoast.showToast(
        msg: local.emailSendFail,
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
    final local = S.of(context);

    return MainScaffold(
      title: local.contactUs,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            ContactInputField(label: local.name, controller: nameController),
            SizedBox(height: 16.h),
            ContactInputField(label: local.email, controller: emailController),
            SizedBox(height: 16.h),
            ContactInputField(
              label: local.subject,
              controller: messageController,
              maxLines: 5,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(title: local.send, onPressed: sendEmail),
            ),
          ],
        ),
      ),
    );
  }
}
