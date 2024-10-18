// import 'package:flutter/material.dart';
// import 'package:frontend/data/models/foods_model.dart';

// class FoodsProvider with ChangeNotifier {
//   Map<String, int> _foodCounts = {};

//   int getCount(String foodId) {
//     return _foodCounts[foodId] ?? 1;
//   }

//   void increment(String foodId) {
//     _foodCounts[foodId] = getCount(foodId) + 1;
//     notifyListeners();
//   }

//   void decrement(String foodId) {
//     if (getCount(foodId) > 1) {
//       _foodCounts[foodId] = getCount(foodId) - 1;
//       notifyListeners();
//     }
//   }

//   void resetCount(String foodId) {
//     _foodCounts[foodId] = 1;
//     notifyListeners();
//   }
// }

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

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:frontend/core/utils/constants/api_constants.dart';
// import 'package:frontend/core/utils/popups/toast.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// class FoodsProvider with ChangeNotifier {
//   final box = GetStorage();

//   Future<void> increment(String foodId) async {
//     String? token = box.read("token");
//     if (token == null) {
//       showToast("You must be logged in to update the cart.");
//       return;
//     }

//     Uri url = Uri.parse("$kAppBaseUrl/api/cart/increment");
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };
//     Map<String, dynamic> body = {
//       "productId": foodId,
//     };

//     try {
//       var response =
//           await http.post(url, headers: headers, body: json.encode(body));
//       if (response.statusCode == 200) {
//         // Update local state if necessary
//         notifyListeners();
//       } else {
//         var error = json.decode(response.body);
//         showToast(error['message']);
//       }
//     } catch (e) {
//       showToast(e.toString());
//     }
//   }
  // int getCount(String foodId) {
  //   return _foodCounts[foodId] ?? 1;
  // }

  // void resetCount(String foodId) {
  //   _foodCounts[foodId] = 1;
  //   notifyListeners();
  // }
//   Future<void> decrement(String foodId) async {
//     String? token = box.read("token");
//     if (token == null) {
//       showToast("You must be logged in to update the cart.");
//       return;
//     }

//     Uri url = Uri.parse("$kAppBaseUrl/api/cart/decrement");
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };
//     Map<String, dynamic> body = {
//       "productId": foodId,
//     };

//     try {
//       var response = await http.post(url, headers: headers, body: json.encode(body));
//       if (response.statusCode == 200) {
//         // Update local state if necessary
//         notifyListeners();
//       } else {
//         var error = json.decode(response.body);
//         showToast(error['message']);
//       }
//     } catch (e) {
//       showToast(e.toString());
//     }
//   }
// }
// }
