import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/features/auth/data/models/user_model.dart';
import 'package:furni_iti/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadUser() async {
    emit(ProfileLoading());
    final user = await SharedPrefsHelper.getUser();
    if (user != null) {
      emit(ProfileLoaded(user));
    } else {
      emit(const ProfileError('User not found'));
    }
  }

  Future<void> updateProfile({
    required String nameEn,
    required String nameAr,
    String? password,
    File? imageFile,
  }) async {
    emit(ProfileUpdating());

    try {
      await DioHelper.setTokenHeader();

      final data = {
        "name[en]": nameEn.trim(),
        "name[ar]": nameAr.trim(),
        if (password != null && password.trim().isNotEmpty)
          "password": password.trim(),
        if (imageFile != null)
          "image": await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      };

      final formData = FormData.fromMap(data);

      final response = await DioHelper.putData(
        url: 'user/updateMe',
        data: formData,
        extraHeaders: {'Content-Type': 'multipart/form-data'},
      );

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(response.data['user']);
        await SharedPrefsHelper.setUser(updatedUser);
        emit(ProfileUpdated(updatedUser));
      } else {
        emit(
          ProfileError(response.data['message'] ?? "Failed to update profile"),
        );
      }
    } catch (e) {
      emit(ProfileError("Failed to update profile: $e"));
    }
  }
}
