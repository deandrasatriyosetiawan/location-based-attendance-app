part of 'create_attendance_bloc.dart';

sealed class CreateAttendanceEvent extends Equatable {
  const CreateAttendanceEvent();

  @override
  List<Object> get props => [];
}

final class CreateAttendanceRequested extends CreateAttendanceEvent {
  const CreateAttendanceRequested(this.request);

  final CreateAttendanceRequest request;

  @override
  List<Object> get props => [request];
}
