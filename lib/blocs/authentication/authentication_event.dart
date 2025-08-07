part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class ValidateAuthenticationStarted extends AuthenticationEvent {}

final class RegisterStarted extends AuthenticationEvent {
  const RegisterStarted({required this.name, required this.email, required this.password});

  final String name, email, password;

  RegisterRequest get request => RegisterRequest(name: name, email: email, password: password);

  @override
  List<Object> get props => <Object>[name, email, password];
}

final class LoginStarted extends AuthenticationEvent {
  const LoginStarted({required this.email, required this.password});

  final String email, password;

  LoginRequest get request => LoginRequest(email: email, password: password);

  @override
  List<Object> get props => <Object>[email, password];
}

final class LogoutStarted extends AuthenticationEvent {}
