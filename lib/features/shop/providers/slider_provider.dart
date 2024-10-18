import 'package:chulesi/data/models/slider_model.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/constants/api_constants.dart';
import '../../../data/models/api_error.dart';
import 'package:http/http.dart' as http;

class SliderProvider with ChangeNotifier {
  List<SliderModel>? _offerSliders;
  bool _isLoading = false;
  ApiError? _error;

  // Getters
  List<SliderModel>? get offerSliders => _offerSliders;
  bool get isLoading => _isLoading;
  String? get error => _error?.message;
  SliderProvider() {
    fetchofferSliders();
    fetchpromoSliders();
  }

  Future<void> fetchofferSliders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/sliders/offer"));

      if (response.statusCode == 200) {
        _offerSliders = sliderModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error =
            ApiError(status: false, message: "Failed to load offerSliders.");
        _offerSliders = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _offerSliders = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh offerSliders if needed
  Future<void> refetchofferSliders() async {
    await fetchofferSliders();
  }

  List<SliderModel>? _promoSliders;

  // Getters
  List<SliderModel>? get promoSliders => _promoSliders;

  Future<void> fetchpromoSliders() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/sliders/promo"));

      if (response.statusCode == 200) {
        _promoSliders = sliderModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error =
            ApiError(status: false, message: "Failed to load offerSliders.");
        _promoSliders = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _promoSliders = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh offerSliders if needed
  Future<void> refetchpromoSliders() async {
    await fetchpromoSliders();
  }
}
