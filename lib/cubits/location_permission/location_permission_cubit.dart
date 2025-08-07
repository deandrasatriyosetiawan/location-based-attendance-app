import 'package:bloc/bloc.dart';
import 'package:location_based_attendance_app/services/location_permission_service.dart';

enum LocationPermissionState { loading, enabled, disabled }

class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  LocationPermissionCubit({required LocationPermissionService permissionService})
    : _permissionService = permissionService,
      super(LocationPermissionState.loading);

  final LocationPermissionService _permissionService;

  void checkPermission() async {
    if (await _permissionService.isEnabled) {
      emit(LocationPermissionState.enabled);
    } else {
      emit(LocationPermissionState.disabled);
    }
  }

  void requestPermission() async => await _permissionService.requestPermission();

  void goToAppSettings() async => await _permissionService.openAppSettings();
}
