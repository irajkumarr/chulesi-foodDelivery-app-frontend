import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:http/http.dart' as http;

class SearchProvider with ChangeNotifier {
  String _searchText = '';
  bool _isLoading = false;
  bool _isTrigger = false;
  List<FoodsModel>? searchResults;

  String get searchText => _searchText;
  bool get isLoading => _isLoading;
  bool get isTrigger => _isTrigger;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setTrigger(bool value) {
    _isTrigger = value;
    notifyListeners();
  }

  void updateSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<void> searchFoods(String text) async {
    setLoading = true;
    Uri url = Uri.parse("$kAppBaseUrl/api/foods/search/$text");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        searchResults = foodsModelFromJson(response.body);
      } else {
        var error = apiErrorFromJson(response.body);
        // showToast(error.message.toString());
        // Handle error
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading = false;
    setTrigger = true; // Set trigger to true after search results come in
  }

  void clearSearch() {
    _searchText = '';
    searchResults = null;
    setTrigger = false;
    notifyListeners();
  }
}
