import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location_based_attendance_app/config/limits.dart';
import 'package:location_based_attendance_app/requests/create_attendance_request.dart';
import 'package:location_based_attendance_app/services/attendance_service.dart';
import 'package:location_based_attendance_app/shared/constants/error_messages.dart';

part 'create_attendance_event.dart';
part 'create_attendance_state.dart';

class CreateAttendanceBloc extends Bloc<CreateAttendanceEvent, CreateAttendanceState> {
  CreateAttendanceBloc({required AttendanceService attendanceService})
    : _attendanceService = attendanceService,
      super(CreateAttendanceInitial()) {
    on<CreateAttendanceRequested>(_onCreateRequested);
  }

  final AttendanceService _attendanceService;

  Future<void> _onCreateRequested(CreateAttendanceRequested event, Emitter<CreateAttendanceState> emit) async {
    try {
      emit(CreateAttendanceInProgress());

      if (event.request.imagePath.isEmpty) {
        emit(CreateAttendanceFailure(ErrorMessages.attendanceImageRequired));

        return;
      }

      if (event.request.distanceFromOfficeInMeters > Limits.maximumDistanceInMeters) {
        emit(CreateAttendanceFailure(ErrorMessages.distanceInvalid));

        return;
      }

      await _attendanceService.insert(event.request);

      emit(CreateAttendanceSuccess('Anda berhasil presensi.'));
    } catch (error) {
      emit(CreateAttendanceFailure(error.toString()));
    }
  }
}
