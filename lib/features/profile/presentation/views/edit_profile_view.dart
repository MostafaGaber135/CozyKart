import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/core/widgets/custom_input_field.dart';
import 'package:cozykart/core/utils/toast_helper.dart';
import 'package:cozykart/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cozykart/features/profile/presentation/cubit/profile_state.dart';
import 'package:cozykart/generated/l10n.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});
  static const String routeName = '/EditProfile';

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final nameEnController = TextEditingController();
  final nameArController = TextEditingController();
  final passwordController = TextEditingController();

  XFile? _image;
  final picker = ImagePicker();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = pickedFile);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadUser();
  }

  void _save() async {
    if (nameEnController.text.isEmpty || nameArController.text.isEmpty) {
      showToast(S.of(context).pleaseFillNameFields, isError: true);
      return;
    }

    context.read<ProfileCubit>().updateProfile(
      nameEn: nameEnController.text.trim(),
      nameAr: nameArController.text.trim(),
      password:
          passwordController.text.trim().isEmpty
              ? null
              : passwordController.text.trim(),
      imageFile: _image != null ? File(_image!.path) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).editProfile)),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            showToast(S.of(context).profileUpdated);
            Navigator.pop(context, true);
          } else if (state is ProfileError) {
            showToast(state.message, isError: true);
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileUpdating) {
            return const Center(child: CircularProgressIndicator());
          }

          final user =
              (state is ProfileLoaded)
                  ? state.user
                  : (state is ProfileUpdated)
                  ? state.updatedUser
                  : null;

          if (user == null) return const SizedBox();

          if (nameEnController.text.isEmpty) {
            nameEnController.text = user.userName.en;
          }
          if (nameArController.text.isEmpty) {
            nameArController.text = user.userName.ar;
          }

          final avatar =
              _image != null
                  ? FileImage(File(_image!.path))
                  : (user.image != null && user.image!.isNotEmpty
                      ? NetworkImage(user.image!)
                      : null);

          return Padding(
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 40.r,
                          backgroundColor: AppColors.primaryAccent,
                          backgroundImage: avatar as ImageProvider?,
                          child:
                              avatar == null
                                  ? const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CircleAvatar(
                          radius: 14.r,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.edit,
                            size: 20.r,
                            color: AppColors.primaryAccent,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),
                  CustomInputField(
                    controller: nameEnController,
                    hintText: S.of(context).nameEn,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    controller: nameArController,
                    hintText: S.of(context).nameAr,
                    textInputType: TextInputType.name,
                  ),
                  SizedBox(height: 10.h),
                  CustomInputField(
                    controller: passwordController,
                    hintText: S.of(context).newPasswordOptional,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                    textInputType: TextInputType.visiblePassword,
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: (double.infinity).w,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryAccent,
                      ),
                      child: Text(
                        S.of(context).save,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
