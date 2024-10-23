import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  LatLng? _selectedLocation;
  String? _address;

  LatLng? get selectedLocation => _selectedLocation;
  String? get address => _address;

  void setSelectedLocation(LatLng location) {
    _selectedLocation = location;
    _fetchAddress(location);
  }

  Future<void> _fetchAddress(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        _address =
            '${placemark.name}, ${placemark.locality}, ${placemark.country}';
        notifyListeners();
      } else {
        _address = "Hetauda";
      }
    } catch (e) {
      print("Error from map:${e.toString()}");
    }
  }

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // Position? position =
    //     Provider.of<LocationProvider>(context, listen: false).currentPosition;
    LatLng currentLocation = LatLng(position.latitude, position.longitude);
    setSelectedLocation(
        currentLocation); // Update the selected location and fetch address
  }
}
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapProvider with ChangeNotifier {
//   LatLng? _selectedLocation;
//   String? _address;

//   LatLng? get selectedLocation => _selectedLocation;
//   String? get address => _address;

//   void setSelectedLocation(LatLng location) {
//     _selectedLocation = location;
//     _fetchAddress(location);
//   }

//   Future<void> _fetchAddress(LatLng location) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(location.latitude, location.longitude);
//       if (placemarks.isNotEmpty) {
//         final placemark = placemarks.first;
//         _address =
//             '${placemark.name ?? ''}, ${placemark.locality ?? ''}, ${placemark.country ?? ''}';
//       } else {
//         _address = 'Unknown location';
//       }
//     } catch (e) {
//       // Use default address if there's an error or permissions are denied
//       _address = 'Hetauda';
//     }
//     notifyListeners();
//   }

//   Future<void> updateCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Handle location services not enabled
//       _address = 'Hetauda';
//       notifyListeners();
//       return;
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         // Location permission denied
//         _address = 'Hetauda'; // Default location
//         notifyListeners();
//         return;
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Location permissions are permanently denied
//       _address = 'Hetauda'; // Default location
//       notifyListeners();
//       return;
//     }

//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);

//     LatLng userLocation = LatLng(position.latitude, position.longitude);
//     _selectedLocation = userLocation;
//     await _fetchAddress(userLocation);
//   }
// }
