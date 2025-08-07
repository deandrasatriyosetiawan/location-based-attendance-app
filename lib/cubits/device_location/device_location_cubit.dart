import 'package:bloc/bloc.dart';
import 'package:location_based_attendance_app/services/device_location_service.dart';

enum DeviceLocationState { loading, enabled, disabled }

class DeviceLocationCubit extends Cubit<DeviceLocationState> {
  DeviceLocationCubit({required DeviceLocationService deviceLocationService})
    : _deviceLocationService = deviceLocationService,
      super(DeviceLocationState.loading);

  final DeviceLocationService _deviceLocationService;

  Future<void> checkSettings() async {
    if (await _deviceLocationService.isEnabled) {
      emit(DeviceLocationState.enabled);
    } else {
      emit(DeviceLocationState.disabled);
    }
  }

  Future<void> goToSettings() async => await _deviceLocationService.openLocationSettings();
}
