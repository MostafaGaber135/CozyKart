import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cozykart/features/profile/presentation/cubit/profile_state.dart';
import 'package:cozykart/features/auth/data/models/user_model.dart';
import 'package:cozykart/core/network/dio_helper.dart';
import 'package:cozykart/core/services/shared_prefs_helper.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> loadUser() async {
    emit(ProfileLoading());
    try {
      final userId = await SharedPrefsHelper.getUserId();
      log("Loading user with ID: $userId");
      if (userId == null) {
        emit(ProfileError("User ID not found"));
        return;
      }

      final response = await DioHelper.getData(url: 'users');
      final users = response.data['users'] as List;
      final userJson = users.firstWhere(
        (u) => u['_id'] == userId,
        orElse: () => null,
      );

      if (userJson == null) {
        emit(ProfileError("User not found"));
        return;
      }

      final user = UserModel.fromJson(userJson);
      await SharedPrefsHelper.saveUserId(user.id);
      await SharedPrefsHelper.setUser(user);
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(e.toString()));
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
      final user = await SharedPrefsHelper.getUser();
      if (user == null) {
        emit(ProfileError("User not found"));
        return;
      }
      final userId = user.id;
      final Map<String, dynamic> updatedData = {
        "userName": jsonEncode({"en": nameEn, "ar": nameAr}),
      };
      if (password != null && password.isNotEmpty) {
        updatedData["password"] = password;
      }
      Response response;
      if (imageFile != null) {
        final formData = FormData.fromMap({
          ...updatedData,
          "image": await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        });

        response = await DioHelper.patchData(
          url: 'users/$userId',
          data: formData,
        );
      } else {
        response = await DioHelper.patchData(
          url: 'users/$userId',
          data: updatedData,
        );
      }

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(response.data['user']);
        await SharedPrefsHelper.setUser(updatedUser);
        emit(ProfileUpdated(updatedUser));
      } else {
        emit(ProfileError("Server error: ${response.statusCode}"));
      }
    } catch (e) {
      log("Exception: $e");
      emit(ProfileError("Exception: ${e.toString()}"));
    }
  }
}
