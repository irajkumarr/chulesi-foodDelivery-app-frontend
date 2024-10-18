// class PlaceProvider with ChangeNotifier {
//   List<Place> _places = [];
//   Place? _selectedPlace;

//   List<Place> get places => _places;
//   Place? get selectedPlace => _selectedPlace;

import 'package:flutter/material.dart';
import 'package:chulesi/core/services/google_places_service.dart';

class PlaceProvider extends ChangeNotifier {
  final GooglePlacesService placesService;
  List<dynamic> suggestions = [];

  PlaceProvider(this.placesService);

  void fetchSuggestions(String input) async {
    if (input.isEmpty) {
      suggestions = [];
    } else {
      suggestions = await placesService.fetchSuggestions(input);
    }
    notifyListeners();
  }
}

//   Future<void> fetchPlaceDetails(String placeId, String apiKey) async {
//     final url = 'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';
//     final response = await http.get(Uri.parse(url));
//     final data = json.decode(response.body);

//     if (data['status'] == 'OK') {
//       _selectedPlace = Place.fromDetailsJson(data['result']);
//       notifyListeners();
//     } else {
//       throw Exception('Failed to load place details');
//     }
//   }
// }