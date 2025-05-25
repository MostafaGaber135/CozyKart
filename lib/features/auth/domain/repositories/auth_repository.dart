import 'package:dartz/dartz.dart';
import 'package:furni_iti/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<String, UserModel>> login(String email, String password);

  Future<Either<String, UserModel>> register({
    required String email,
    required String password,
    required Map<String, String> userName,
  });
}
