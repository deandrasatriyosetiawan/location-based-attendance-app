import 'dart:async';

import 'package:geolocator/geolocator.dart';

class DevicePositionService {
  const DevicePositionService();

  final LocationSettings _locationSettings = const LocationSettings(accuracy: LocationAccuracy.high);

  Future<Position> get currentPosition async {
    try {
      return await Geolocator.getCurrentPosition(locationSettings: _locationSettings);
    } catch (error) {
      rethrow;
    }
  }
}
