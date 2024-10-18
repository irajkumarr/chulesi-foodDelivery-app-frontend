import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  var carouselCurrentIndex = 0;

  void updatePageIndicator(index) {
    carouselCurrentIndex = index;
    notifyListeners();
  }
}
