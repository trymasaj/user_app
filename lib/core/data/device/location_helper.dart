import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:masaj/core/domain/exceptions/location_permission_not_granted_exception.dart';

abstract class LocationHelper {
  Future<Position?> getMyLocation();

  Future<bool> isLocationServiceEnabled();

  double getDistanceBetweenTwoPoints(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  );

  Future<double> getDistanceFromMyLocation(double lat, double lon);

  Stream<Position?> getMyLocationStream([LocationSettings? locationSettings]);

  Stream<double> getDistanceFromMyLocationStream(
    double lat,
    double lon, {
    LocationSettings? locationSettings,
  });
}

class LocationHelperImpl extends LocationHelper {
  @override
  Future<Position?> getMyLocation() async {
    LocationPermission? permission;
    Position? location;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      location = await Geolocator.getCurrentPosition();
    }

    return location;
  }

  @override
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  @override
  double getDistanceBetweenTwoPoints(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) =>
      Geolocator.distanceBetween(lat1, lon1, lat2, lon2);

  @override
  Future<double> getDistanceFromMyLocation(double lat, double lon) async {
    final myLocation = await getMyLocation();
    if (myLocation == null) return 0;
    return getDistanceBetweenTwoPoints(
      myLocation.latitude,
      myLocation.longitude,
      lat,
      lon,
    );
  }

  @override
  Stream<Position?> getMyLocationStream(
      [LocationSettings? locationSettings]) async* {
    var permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission != LocationPermission.whileInUse &&
        permission != LocationPermission.always) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      yield* Geolocator.getPositionStream(
        locationSettings: locationSettings ??
            const LocationSettings(
              accuracy: LocationAccuracy.bestForNavigation,
            ),
      );
    } else {
      throw LocationPermissionNotGrantedException();
    }
  }

  @override
  Stream<double> getDistanceFromMyLocationStream(
    double lat,
    double lon, {
    LocationSettings? locationSettings,
  }) {
    return getMyLocationStream(locationSettings)
        .where((position) => position != null)
        .map(
          (myLocation) => getDistanceBetweenTwoPoints(
            myLocation!.latitude,
            myLocation.longitude,
            lat,
            lon,
          ),
        );
  }
}
