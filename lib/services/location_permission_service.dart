import 'package:geolocator/geolocator.dart';

class LocationPermissionService {
  const LocationPermissionService();

  Future<bool> get isEnabled async {
    final LocationPermission locationPermission = await Geolocator.checkPermission();

    return locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always;
  }

  Future<void> requestPermission() async {
    if (await isEnabled) return;

    await Geolocator.requestPermission();
  }

  Future<void> openAppSettings() async => await Geolocator.openAppSettings();
}
