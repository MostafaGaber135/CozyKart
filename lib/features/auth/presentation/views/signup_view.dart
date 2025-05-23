import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cozykart/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cozykart/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:cozykart/features/auth/presentation/views/widgets/signup_view_body.dart';

class SignupView extends StatelessWidget {
  static const String routeName = '/SignupView';

  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthCubit(AuthRepositoryImpl()),
      child: const Scaffold(body: SignupViewBody()),
    );
  }
}
