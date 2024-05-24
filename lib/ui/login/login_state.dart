import 'package:equatable/equatable.dart';

import '../../model/login_model.dart';



class LoginState extends Equatable {
  final bool isPasswordVisible;
  final bool? isLoading;
  final LoginModel? isSuccess;
  final String isError;

  const LoginState({
    this.isPasswordVisible = true,
    this.isLoading,
    this.isSuccess,
    this.isError='',
  });

  LoginState copyWith({
    bool? isPasswordVisible,
     bool? isLoading,
    LoginModel? isSuccess,
     String? isError,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object?> get props => [
    isPasswordVisible,
    isLoading,
    isSuccess,
    isError,
      ];
}
