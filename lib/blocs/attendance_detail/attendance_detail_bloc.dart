import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:location_based_attendance_app/models/attendance_model.dart';
import 'package:location_based_attendance_app/services/attendance_service.dart';

part 'attendance_detail_event.dart';
part 'attendance_detail_state.dart';

class AttendanceDetailBloc extends Bloc<AttendanceDetailEvent, AttendanceDetailState> {
  AttendanceDetailBloc({required AttendanceService attendanceService})
    : _attendanceService = attendanceService,
      super(AttendanceDetailInitial()) {
    on<LatestAttendanceRequested>(_onLatestRequested);
  }

  final AttendanceService _attendanceService;

  Future<void> _onLatestRequested(LatestAttendanceRequested event, Emitter<AttendanceDetailState> emit) async {
    try {
      emit(AttendanceDetailLoadInProgress());

      final Map<String, Object?> attendanceMap = await _attendanceService.fetchLatestByUserId(userId: event.userId);

      final AttendanceModel attendance = AttendanceModel.fromSqliteDatabase(attendanceMap);

      emit(AttendanceDetailLoadSuccess(attendance));
    } catch (error) {
      emit(AttendanceDetailLoadFailure(error.toString()));
    }
  }
}
