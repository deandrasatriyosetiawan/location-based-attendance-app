part of 'create_user_bloc.dart';

sealed class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

final class CreateUserRequested extends CreateUserEvent {
  const CreateUserRequested(this.request);

  final CreateUserRequest request;

  @override
  List<Object> get props => [request];
}
