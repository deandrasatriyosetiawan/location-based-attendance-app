part of 'create_user_bloc.dart';

sealed class CreateUserState extends Equatable {
  const CreateUserState();

  @override
  List<Object> get props => [];
}

final class CreateUserInitial extends CreateUserState {}

final class CreateUserInProgress extends CreateUserState {}

final class CreateUserSuccess extends CreateUserState {}

final class CreateUserFailure extends CreateUserState {
  const CreateUserFailure(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
