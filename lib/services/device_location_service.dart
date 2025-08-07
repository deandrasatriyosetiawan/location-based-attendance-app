import 'package:geolocator/geolocator.dart';

class DeviceLocationService {
  const DeviceLocationService();

  Future<bool> get isEnabled async => await Geolocator.isLocationServiceEnabled();

  Future<void> openLocationSettings() async => await Geolocator.openLocationSettings();
}
