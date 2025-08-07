part of 'attendance_detail_bloc.dart';

sealed class AttendanceDetailState extends Equatable {
  const AttendanceDetailState();

  @override
  List<Object> get props => [];
}

final class AttendanceDetailInitial extends AttendanceDetailState {}

final class AttendanceDetailLoadInProgress extends AttendanceDetailState {}

final class AttendanceDetailLoadSuccess extends AttendanceDetailState {
  const AttendanceDetailLoadSuccess(this.attendance);

  final AttendanceModel attendance;

  @override
  List<Object> get props => <Object>[attendance];
}

final class AttendanceDetailLoadFailure extends AttendanceDetailState {
  const AttendanceDetailLoadFailure(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
