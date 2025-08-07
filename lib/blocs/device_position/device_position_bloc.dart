import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_based_attendance_app/services/device_position_service.dart';
import 'package:location_based_attendance_app/shared/constants/error_messages.dart';

part 'device_position_event.dart';
part 'device_position_state.dart';

class DevicePositionBloc extends Bloc<DevicePositionEvent, DevicePositionState> {
  DevicePositionBloc({required DevicePositionService devicePositionService})
    : _devicePositionService = devicePositionService,
      super(DevicePositionInitial()) {
    on<GetCurrentPositionStarted>(_onGetCurrentPositionStarted);
    on<ClearCurrentPositionStarted>(_onClearCurrentPositionStarted);
  }

  final DevicePositionService _devicePositionService;

  Future<void> _onGetCurrentPositionStarted(GetCurrentPositionStarted event, Emitter<DevicePositionState> emit) async {
    try {
      emit(DevicePositionLoading());

      final Position position = await _devicePositionService.currentPosition;

      emit(DevicePositionLoadSuccess(position));
    } catch (error) {
      emit(DevicePositionLoadFailure(ErrorMessages.devicePositionError));
    }
  }

  Future<void> _onClearCurrentPositionStarted(
    ClearCurrentPositionStarted event,
    Emitter<DevicePositionState> emit,
  ) async {
    try {
      emit(DevicePositionInitial());
    } catch (error) {
      emit(DevicePositionLoadFailure(ErrorMessages.devicePositionError));
    }
  }
}
