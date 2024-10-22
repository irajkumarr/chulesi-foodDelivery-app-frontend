import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  var carouselPromoCurrentIndex = 0;

  void updatePromoPageIndicator(index) {
    carouselPromoCurrentIndex = index;
    notifyListeners();
  }
  
  var carouselOfferCurrentIndex = 0;

  void updateOfferPageIndicator(index) {
    carouselOfferCurrentIndex = index;
    notifyListeners();
  }
}
