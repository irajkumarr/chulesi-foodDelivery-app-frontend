import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/data/models/categories_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/utils/constants/api_constants.dart';
import '../../../data/models/api_error.dart';

class CategoryProvider extends ChangeNotifier {
  String _category = "";
  String get categoryValue => _category;

  set updateCategory(String value) {
    _category = value;
    notifyListeners();
  }

  String _title = "";
  String get titleValue => _title;

  set updateTitle(String value) {
    _title = value;
    notifyListeners();
  }

  List<CategoriesModel>? _categories;
  bool _isLoading = false;
  ApiError? _error;

  // Getters
  List<CategoriesModel>? get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error?.message;
  CategoryProvider() {
    fetchCategories();
    fetchallCategories();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/categories/best"));

      if (response.statusCode == 200) {
        _categories = categoriesModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ApiError(status: false, message: "Failed to load categories.");
        _categories = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _categories = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh categories if needed
  Future<void> refetchCategories() async {
    await fetchCategories();
  }

  List<CategoriesModel>? _allCategories;

  // Getters
  List<CategoriesModel>? get allCategories => _allCategories;

  Future<void> fetchallCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse("$kAppBaseUrl/api/categories"));

      if (response.statusCode == 200) {
        _allCategories = categoriesModelFromJson(response.body);
        _error = null; // No error
      } else {
        _error = ApiError(status: false, message: "Failed to load categories.");
        _allCategories = [];
      }
    } catch (e) {
      _error = ApiError(status: false, message: e.toString());
      _allCategories = [];
    } finally {
      _isLoading = false;
      notifyListeners(); // Notify UI of state change
    }
  }

  // Method to refresh categories if needed
  Future<void> refetchAllCategories() async {
    await fetchallCategories();
  }
}
