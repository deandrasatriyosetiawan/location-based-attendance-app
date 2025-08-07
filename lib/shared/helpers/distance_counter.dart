import 'package:geolocator/geolocator.dart';

class DistanceCounter {
  const DistanceCounter._();

  static const double _officeLatitude = -6.2631219;
  static const double _officeLongitude = 106.7962649;

  static double countDistance({required double deviceLatitude, required double deviceLongitude}) {
    return Geolocator.distanceBetween(deviceLatitude, deviceLongitude, _officeLatitude, _officeLongitude);
  }
}
