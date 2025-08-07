part of 'user_detail_bloc.dart';

sealed class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object> get props => [];
}

final class UserDetailInitial extends UserDetailState {}

final class UserDetailLoadInProgress extends UserDetailState {}

final class UserDetailLoadSuccess extends UserDetailState {
  const UserDetailLoadSuccess(this.user);

  final UserModel user;

  @override
  List<Object> get props => <Object>[user];
}

final class UserDetailLoadFailure extends UserDetailState {
  const UserDetailLoadFailure(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
