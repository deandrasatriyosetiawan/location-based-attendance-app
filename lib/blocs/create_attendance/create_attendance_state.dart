part of 'create_attendance_bloc.dart';

sealed class CreateAttendanceState extends Equatable {
  const CreateAttendanceState();

  @override
  List<Object> get props => [];
}

final class CreateAttendanceInitial extends CreateAttendanceState {}

final class CreateAttendanceInProgress extends CreateAttendanceState {}

final class CreateAttendanceSuccess extends CreateAttendanceState {
  const CreateAttendanceSuccess(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}

final class CreateAttendanceFailure extends CreateAttendanceState {
  const CreateAttendanceFailure(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
