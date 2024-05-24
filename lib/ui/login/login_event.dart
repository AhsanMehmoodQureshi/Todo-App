import 'package:equatable/equatable.dart';


abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PasswordVisibleEvent extends LoginEvent {}

class RememberMeEvent extends LoginEvent {}


class SignInButtonEvent extends LoginEvent {
  final String username;
  final String password;
  SignInButtonEvent(this.username, this.password);
}


