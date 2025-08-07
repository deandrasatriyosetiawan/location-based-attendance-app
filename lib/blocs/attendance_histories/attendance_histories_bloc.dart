import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location_based_attendance_app/models/attendance_model.dart';
import 'package:location_based_attendance_app/services/attendance_service.dart';

part 'attendance_histories_event.dart';
part 'attendance_histories_state.dart';

class AttendanceHistoriesBloc extends Bloc<AttendanceHistoriesEvent, AttendanceHistoriesState> {
  AttendanceHistoriesBloc({required AttendanceService attendanceService})
    : _attendanceService = attendanceService,
      super(AttendanceHistoriesInitial()) {
    on<AllAttendanceHistoriesRequested>(_onAllHistoriesRequested);
  }

  final AttendanceService _attendanceService;

  Future<void> _onAllHistoriesRequested(
    AllAttendanceHistoriesRequested event,
    Emitter<AttendanceHistoriesState> emit,
  ) async {
    try {
      emit(AttendanceHistoriesLoadInProgress());

      final List<Map<String, Object?>> attendanceMaps = await _attendanceService.fetchAllByUserId(userId: event.userId);

      final List<AttendanceModel> attendances = attendanceMaps
          .map((Map<String, Object?> map) => AttendanceModel.fromSqliteDatabase(map))
          .toList();

      emit(AttendanceHistoriesLoadSuccess(attendances));
    } catch (error) {
      emit(AttendanceHistoriesLoadFailure(error.toString()));
    }
  }
}
