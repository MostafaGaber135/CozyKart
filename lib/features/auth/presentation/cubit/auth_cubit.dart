import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_state.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepository.login(email, password);
    result.fold((error) => emit(AuthFailure(error)), (user) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", user.token ?? '');
      await SharedPrefsHelper.saveUserId(user.id); 
      emit(AuthSuccess(user));
    });
  }

  void register({
    required String email,
    required String password,
    required Map<String, String> userName,
  }) async {
    emit(AuthLoading());
    final result = await authRepository.register(
      email: email,
      password: password,
      userName: userName,
    );

    result.fold((error) => emit(AuthFailure(error)), (user) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", user.token ?? '');
      await SharedPrefsHelper.saveUserId(user.id); 
      emit(RegisterSuccessState(user));
    });
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null && !JwtDecoder.isExpired(token)) {
      emit(AuthLoggedIn());
    } else {
      await prefs.remove("token");
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    emit(AuthInitial());
  }
}
