import 'package:geolocator/geolocator.dart';

class location {
  double? latitude;
  double? longitude;

  Future<void> getCarrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
  }
}
