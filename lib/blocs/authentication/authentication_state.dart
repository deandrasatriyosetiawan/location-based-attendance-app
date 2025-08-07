part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => <Object>[];
}

abstract class AuthenticationOperationSuccess extends AuthenticationState {
  const AuthenticationOperationSuccess(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}

abstract class AuthenticationOperationFailure extends AuthenticationState {
  AuthenticationOperationFailure(this.message) : timestamp = DateTime.now();

  final String message;
  final DateTime timestamp;

  @override
  List<Object> get props => <Object>[message, timestamp];
}

final class AuthenticationValidateInitial extends AuthenticationState {}

final class AuthenticationValidateSuccess extends AuthenticationOperationSuccess {
  const AuthenticationValidateSuccess(super.message, {required this.userId});

  final String userId;

  @override
  List<Object> get props => super.props + [userId];
}

final class AuthenticationValidateFailure extends AuthenticationOperationFailure {
  AuthenticationValidateFailure(super.message);
}

final class RegisterInProgress extends AuthenticationState {}

final class RegisterSuccess extends AuthenticationOperationSuccess {
  const RegisterSuccess(super.message);
}

final class RegisterFailure extends AuthenticationOperationFailure {
  RegisterFailure(super.message);
}

final class LoginInProgress extends AuthenticationState {}

final class LoginSuccess extends AuthenticationOperationSuccess {
  const LoginSuccess(super.message);
}

final class LoginFailure extends AuthenticationOperationFailure {
  LoginFailure(super.message);
}

final class LogoutInProgress extends AuthenticationState {}

final class LogoutSuccess extends AuthenticationOperationSuccess {
  const LogoutSuccess(super.message);
}

final class LogoutFailure extends AuthenticationOperationFailure {
  LogoutFailure(super.message);
}
