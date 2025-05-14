import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furni_iti/core/widgets/custom_elevated_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/widgets/custom_text_form_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});
  static const String routeName = '/EditProfile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  bool _obscurePassword = true;
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (!mounted) return;
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
        });
      }
    } catch (e) {
      debugPrint("Image pick error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primaryAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child:
                          _image == null
                              ? Image.asset(
                                'assets/images/person.png',
                                fit: BoxFit.cover,
                              )
                              : Image.file(
                                File(_image!.path),
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: userNameController,
              hintText: 'Full Name',
              textInputType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: passwordController,
              hintText: 'Password',
              textInputType: TextInputType.visiblePassword,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.primaryAccent,
                ),
                onPressed: _togglePasswordVisibility,
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: phoneController,
              hintText: 'Phone',
              textInputType: TextInputType.phone,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                title: 'Save Changes',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
