part of 'attendance_histories_bloc.dart';

sealed class AttendanceHistoriesState extends Equatable {
  const AttendanceHistoriesState();

  @override
  List<Object> get props => [];
}

final class AttendanceHistoriesInitial extends AttendanceHistoriesState {}

final class AttendanceHistoriesLoadInProgress extends AttendanceHistoriesState {}

final class AttendanceHistoriesLoadSuccess extends AttendanceHistoriesState {
  const AttendanceHistoriesLoadSuccess(this.attendances);

  final List<AttendanceModel> attendances;

  @override
  List<Object> get props => <Object>[attendances];
}

final class AttendanceHistoriesLoadFailure extends AttendanceHistoriesState {
  const AttendanceHistoriesLoadFailure(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}
