import 'package:flutter/material.dart';

class FoodsProvider with ChangeNotifier {
  final Map<String, int> _foodCounts = {};

  void increment(String foodId) {
    if (_foodCounts.containsKey(foodId)) {
      _foodCounts[foodId] = _foodCounts[foodId]! + 1;
    } else {
      _foodCounts[foodId] = 1;
    }
    notifyListeners();
  }

  void decrement(String foodId) {
    if (_foodCounts.containsKey(foodId) && _foodCounts[foodId]! > 1) {
      _foodCounts[foodId] = _foodCounts[foodId]! - 1;
    }
    notifyListeners();
  }

  int getCount(String foodId) {
    return _foodCounts[foodId] ?? 1;
  }

  void resetCount(String foodId) {
    _foodCounts[foodId] = 1;
    notifyListeners();
  }
}
