import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/features/auth/data/models/user_model.dart';
import 'package:furni_iti/features/auth/domain/repositories/auth_repository.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<String, UserModel>> login(String email, String password) async {
    try {
      final response = await DioHelper.postData(
        url: 'auth/login',
        data: {"email": email, "password": password},
      );

      log("response.statusCode: ${response.statusCode}");
      log("response.data: ${response.data}");

      final token = response.data['token'];

      if (response.statusCode == 200 && token != null) {
        await SharedPrefsHelper.setToken(token);
        final savedToken = await SharedPrefsHelper.getToken();
        log("TOKEN SAVED ACTUALLY: $savedToken");
        final decodedToken = JwtDecoder.decode(token);
        final userId = decodedToken["data"]["id"];
        await SharedPrefsHelper.saveUserId(userId);
        log("Extracted userId from token: $userId");

        return Right(
          UserModel(
            id: userId,
            email: email,
            password: "",
            role: decodedToken["data"]["role"] ?? "",
            isVerified: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            userName: Name(en: "", ar: ""),
            image: null,
            token: token,
            refreshToken: response.data['refreshToken'],
            wishlist: [],
            ispurchased: [],
          ),
        );
      } else {
        final msg = response.data['message'] ?? "Invalid credentials";
        return Left(msg);
      }
    } catch (e) {
      return Left("Login failed: ${e.toString()}");
    }
  }

  @override
  Future<Either<String, UserModel>> register({
    required String email,
    required String password,
    required Map<String, String> userName,
  }) async {
    try {
      final response = await DioHelper.postData(
        url: 'auth/register',
        data: {"email": email, "password": password, "userName": userName},
      );

      log("Register Response: ${response.data}");

      if (response.statusCode == 201 && response.data['user'] != null) {
        final user = UserModel.fromJson(response.data['user']);
        return Right(user);
      } else {
        return Left(response.data['message'] ?? "Registration failed");
      }
    } catch (e) {
      return Left("Register failed: ${e.toString()}");
    }
  }
}
