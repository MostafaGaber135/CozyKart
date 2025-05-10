import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furni_iti/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  void login(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepository.login(email, password);
    result.fold(
      (error) => emit(AuthFailure(error)),
      (user) => emit(AuthSuccess(user)),
    );
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

    result.fold(
      (error) => emit(AuthFailure(error)),
      (user) => emit(RegisterSuccessState(user)),
    );
  }
}
