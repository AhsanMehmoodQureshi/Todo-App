import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:test_project/model/login_model.dart';
import 'package:test_project/utils/api_url.dart';


import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  bool _showPassword = true;

  LoginBloc() : super(const LoginState()) {
    on<PasswordVisibleEvent>(_onPasswordVisibleEvent);
    on<SignInButtonEvent>(_onSignInButtonPressed);

  }

  void _onPasswordVisibleEvent(
      PasswordVisibleEvent event, Emitter<LoginState> emit) {
    _showPassword = !_showPassword;
    emit(
      state.copyWith(
        isPasswordVisible: _showPassword,
      ),
    );
  }

  void _onSignInButtonPressed(SignInButtonEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
      final url = Uri.parse(ApiUrl.loginApi);
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'username': event.username,
        'password': event.password,
        'expiresInMins': 30,
      });

      try {
        final response = await http.post(
          url,
          headers: headers,
          body: body,
        );
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          print(data);
          emit(state.copyWith(isLoading: false,isSuccess: LoginModel.fromJson(data),isError: ''));
          // Handle the JSON data here
        } else {
          emit(state.copyWith(isLoading: false,isSuccess: null,isError: 'Failed to login. Status code: ${response.statusCode}'));
        }
      } catch (error) {
        emit(state.copyWith(isLoading: false,isSuccess: null,isError: 'Failed to login $error'));

      }

  }

  void reset() {
    emit(const LoginState());
  }
}
