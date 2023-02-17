import 'package:geolocator/geolocator.dart';

class AppLatLon {
  final double lat;
  final double lon;

  const AppLatLon({required this.lat, required this.lon});
}

class MoscowLocation extends AppLatLon {
  const MoscowLocation({
    super.lat = 55.7522200,
    super.lon = 37.6155600,
  });
}

abstract class AppLocation {
  Future<AppLatLon> getCurrentLocation();

  Future<bool> requestPermission();

  Future<bool> checkPermission();
}

class LocationService implements AppLocation {
  final defLocation = const MoscowLocation();

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<AppLatLon> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLon(lat: value.latitude, lon: value.longitude);
    }).catchError(
      (_) => defLocation,
    );
  }

  @override
  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}
