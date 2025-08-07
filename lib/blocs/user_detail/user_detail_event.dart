part of 'user_detail_bloc.dart';

sealed class UserDetailEvent extends Equatable {
  const UserDetailEvent();

  @override
  List<Object> get props => [];
}

final class UserDetailRequested extends UserDetailEvent {
  const UserDetailRequested({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}
