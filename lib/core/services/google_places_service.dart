// lib/services/google_places_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GooglePlacesService {
  final String apiKey;
  final uuid = const Uuid();
  String? sessionToken;

  GooglePlacesService(this.apiKey);

  void resetSessionToken() {
    sessionToken = uuid.v4();
  }

  Future<List<dynamic>> fetchSuggestions(String input) async {
    if (sessionToken == null) {
      resetSessionToken();
    }

    final response = await http.get(
      Uri.parse(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$apiKey&sessiontoken=$sessionToken'),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['predictions'];
    } else {
      throw Exception('Failed to load suggestions');
    }
  }
}
