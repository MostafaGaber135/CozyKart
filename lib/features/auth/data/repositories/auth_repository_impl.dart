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
    final refreshToken = response.data['refreshToken'];

    if (response.statusCode == 200 && token != null) {
      final decodedToken = JwtDecoder.decode(token);
      log('🔥 Decoded Token: ${decodedToken["data"]}');

      final userId = decodedToken["data"]["id"];
      final userName = decodedToken["data"]["userName"]?["en"] ?? "";
      final emailFromToken = decodedToken["data"]["email"] ?? "";
      final image = decodedToken["data"]["image"] ?? "";
      final role = decodedToken["data"]["role"] ?? "";

      final user = UserModel(
        id: userId,
        email: emailFromToken,
        password: "",
        role: role,
        isVerified: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      userName: Name(en: userName, ar: ""),

        image: image,
        token: token,
        refreshToken: refreshToken,
        wishlist: [],
        ispurchased: [],
      );

      await SharedPrefsHelper.setToken(token);
      await SharedPrefsHelper.saveUserId(userId);
      await SharedPrefsHelper.setUser(user); // ✅ بعد الإنشاء

      log("✅ TOKEN SAVED: $token");
      log("✅ User SAVED: ${user.toJson()}");

      return Right(user);
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
          await SharedPrefsHelper.setUser(user);
        return Right(user);
      } else {
        return Left(response.data['message'] ?? "Registration failed");
      }
    } catch (e) {
      return Left("Register failed: ${e.toString()}");
    }
  }
}
