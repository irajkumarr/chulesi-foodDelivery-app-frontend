import 'package:chulesi/data/models/foods_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/api_constants.dart';
import '../../../data/models/api_error.dart';

class FoodsListProvider extends ChangeNotifier {
  FoodsListProvider() {
    fetchBestRatedFoods();
    fetchNewFoods();
    fetchPopularFoods();
  }
  List<FoodsModel>? _newFoodsList;
  bool _isLoading = false;
  ApiError? _error;

  // Getters
  List<FoodsModel>? get newFoodsList => _newFoodsList;
  bool get isLoading => _isLoading;
  String? get error => _error?.message;

  Future<void> fetchNewFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/foods/newest"));

      if (response.statusCode == 200) {
        _newFoodsList = foodsModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ApiError(status: false, message: "Failed to load newest foods.");
        _newFoodsList = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _newFoodsList = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh categories if needed
  Future<void> refetchNewFoodsList() async {
    await fetchNewFoods();
  }

  List<FoodsModel>? _popularFoodsList;

  // Getters
  List<FoodsModel>? get popularFoodsList => _popularFoodsList;

  Future<void> fetchPopularFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/foods/popular"));

      if (response.statusCode == 200) {
        _popularFoodsList = foodsModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ApiError(status: false, message: "Failed to load popular foods.");
        _popularFoodsList = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _popularFoodsList = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh categories if needed
  Future<void> refetchPopularFoodsList() async {
    await fetchPopularFoods();
  }

  List<FoodsModel>? _bestRatedFoodsList;

  // Getters
  List<FoodsModel>? get bestRatedFoodsList => _bestRatedFoodsList;

  Future<void> fetchBestRatedFoods() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/foods/rating/best-rated/"));

      if (response.statusCode == 200) {
        _bestRatedFoodsList = foodsModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ApiError(status: false, message: "Failed to load besr rated foods.");
        _bestRatedFoodsList = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _bestRatedFoodsList = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh categories if needed
  Future<void> refetchBestRatedFoods() async {
    await fetchBestRatedFoods();
  }
}
