import 'package:chulesi/data/models/foods_with_offers_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/api_constants.dart';
import '../../../data/models/api_error.dart';

class OffersFoodListProvider extends ChangeNotifier {
  OffersFoodListProvider() {
    fetchOfferFoods();
  }
  List<FoodsWithOffersModel>? _offersFoodsList;
  bool _isLoading = false;
  ApiError? _error;

  // Getters
  List<FoodsWithOffersModel>? get offersFoodsList => _offersFoodsList;
  bool get isLoading => _isLoading;
  String? get error => _error?.message;

  Future<void> fetchOfferFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/foods/offers"));

      if (response.statusCode == 200) {
        _offersFoodsList = foodsWithOffersModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ApiError(status: false, message: "Failed to load categories.");
        _offersFoodsList = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _offersFoodsList = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh categories if needed
  Future<void> refetchOfferFoodList() async {
    await fetchOfferFoods();
  }
}
