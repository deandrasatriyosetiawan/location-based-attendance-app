part of 'attendance_histories_bloc.dart';

sealed class AttendanceHistoriesEvent extends Equatable {
  const AttendanceHistoriesEvent();

  @override
  List<Object> get props => [];
}

final class AllAttendanceHistoriesRequested extends AttendanceHistoriesEvent {
  const AllAttendanceHistoriesRequested({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}
