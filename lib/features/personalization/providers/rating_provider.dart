// Order Rating Provider
import 'dart:convert';

import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/data/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class RatingProvider extends ChangeNotifier {
//order rating
  double _currentRating = 0.0;
  String _feedback = '';
  bool _isRatingSubmitted = false;
  bool _isLoading = false;
  String _errorMessage = '';
  final box = GetStorage();
  double get currentRating => _currentRating;
  String get feedback => _feedback;
  bool get isRatingSubmitted => _isRatingSubmitted;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void initializeRating(OrderModel order) {
    _isRatingSubmitted = order.rating != null;
    _currentRating = order.rating?.toDouble() ?? 0.0;
    _feedback = order.feedback ?? '';
    notifyListeners();
  }

  void updateRating(double rating) {
    _currentRating = rating;
    notifyListeners();
  }

  void updateFeedback(String feedback) {
    _feedback = feedback;
    notifyListeners();
  }

  Future<bool> submitRating(String orderId) async {
    if (_isRatingSubmitted) {
      showToast("You have already rated this order.");
      return false;
    }
    if (_currentRating == 0) return false;

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    String? token = box.read("token");
    if (token == null) {
      _isLoading = false;
      showToast("You must be logged in to rate an order.");
      return false;
    }

    Uri url = Uri.parse("$kAppBaseUrl/api/orders/rate/$orderId");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'rating': _currentRating,
          'feedback': _feedback,
        }),
      );

      _isLoading = false;

      if (response.statusCode == 200) {
        _isRatingSubmitted = true;
        notifyListeners();
        showToast("Rating submitted successfully!");
        return true;
      } else {
        // showToast("Failed to submit rating");

        final errorResponse = json.decode(response.body);
        showToast(errorResponse['message']);
        notifyListeners();
        return false;
      }
    } catch (e) {
      _isLoading = false;
      showToast("Error: ${e.toString()}");
      notifyListeners();
      return false;
    }
  }
}
