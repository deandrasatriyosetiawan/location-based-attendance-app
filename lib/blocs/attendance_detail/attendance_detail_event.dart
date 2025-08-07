part of 'attendance_detail_bloc.dart';

sealed class AttendanceDetailEvent extends Equatable {
  const AttendanceDetailEvent();

  @override
  List<Object> get props => [];
}

final class LatestAttendanceRequested extends AttendanceDetailEvent {
  const LatestAttendanceRequested({required this.userId});

  final String userId;

  @override
  List<Object> get props => [userId];
}
