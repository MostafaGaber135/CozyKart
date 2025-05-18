import 'dart:developer';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/profile/presentation/cubit/profile_state.dart';
import 'package:furni_iti/features/auth/data/models/user_model.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';

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
      if (user == null) throw Exception("User not logged in");

      final body = {
        "userName": {"en": nameEn, "ar": nameAr},
        if (password != null && password.isNotEmpty) "password": password,
        if (imageFile != null) "image": imageFile.path,
      };

      final response = await DioHelper.putData(
        url: "users/${user.id}",
        data: body,
      );

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(response.data['user']);
        await SharedPrefsHelper.setUser(updatedUser);
        emit(ProfileUpdated(updatedUser));
      } else {
        log("Update failed: ${response.statusCode} - ${response.data}");
        throw Exception(
          "Failed to update profile: ${response.statusCode} - ${response.data}",
        );
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
