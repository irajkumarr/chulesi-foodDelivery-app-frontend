// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:chulesi/core/utils/constants/api_constants.dart';
// import 'package:chulesi/core/utils/popups/toast.dart';
// import 'package:chulesi/data/models/api_error.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;

// class CartProvider with ChangeNotifier {
//   final box = GetStorage();
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   set setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   final Map<String, int> _itemQuantities = {};
//   final Map<String, double> _itemPrices = {};

//   Future<void> addToCart(BuildContext context, String cart) async {
//     setLoading = true;

//     String? token = box.read("token");
//     // if (token == null) {
//     //   setLoading = false;
//     //   showToast("You must be logged in to add products to the cart.");
//     //   return;
//     // }

//     Uri url = Uri.parse("$kAppBaseUrl/api/carts/");
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       if (token != null) "Authorization": "Bearer $token"
//     };

//     try {
//       var response = await http.post(url, headers: headers, body: cart);
//       if (response.statusCode == 201) {
//         showToast("Product added to Cart");
//         String userId = box.read("userId") ?? '';
//         await fetchCartCount(userId);
//         setLoading = false;
//       } else {
//         var error = apiErrorFromJson(response.body);
//         showToast(error.message);
//         setLoading = false;
//       }
//     } catch (e) {
//       showToast(e.toString());
//       setLoading = false;
//     } finally {
//       setLoading = false;
//     }
//   }

//   void removeFromCart(String productId, Function refetch) async {
//     setLoading = true;

//     String? token = box.read("token");
//     Uri url = Uri.parse("$kAppBaseUrl/api/carts/delete/$productId");

//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token"
//     };

//     try {
//       var response = await http.delete(url, headers: headers);
//       if (response.statusCode == 200) {
//         refetch();
//         showToast("Product Removed from Cart");
//         String userId = box.read("userId") ?? '';
//         await fetchCartCount(userId);
//         await fetchTotalCartPrice(userId);
//         notifyListeners();
//       } else {
//         var error = apiErrorFromJson(response.body);
//         showToast(error.message);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     } finally {
//       setLoading = false;
//     }
//   }

//   int _cartCount = 0;
//   int get cartCount => _cartCount;

//   Future<void> fetchCartCount(String userId) async {
//     setLoading = true;
//     String? token = box.read("token");
//     if (token == null) {
//       setLoading = false;
//       return;
//     }
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token"
//     };
//     final url = Uri.parse('$kAppBaseUrl/api/carts/count');

//     try {
//       final response = await http.get(
//         url,
//         headers: headers,
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         _cartCount = data['cartCount'] != null ? data['cartCount'] as int : 0;
//         notifyListeners();
//       } else {
//         throw Exception('Failed to load cart count');
//       }
//     } catch (error) {
//       print('Error fetching cart count: $error');
//     } finally {
//       setLoading = false;
//     }
//   }

//   // Future<void> clearCart(String userId, Function? refetch) async {
//   //   String token = box.read("token");
//   //   final url = Uri.parse('$kAppBaseUrl/api/cart/clear');
//   //   setLoading = true;

//   //   try {
//   //     final response = await http.delete(
//   //       url,
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //     );

//   //     if (response.statusCode == 200) {
//   //       await fetchCartCount(userId);

//   //       refetch!();
//   //       // showToast("Cart cleared Successfully");
//   //     } else {
//   //       showToast("No items found in cart");
//   //     }
//   //   } catch (error) {
//   //     print('Error clearing cart: $error');
//   //     rethrow;
//   //   } finally {
//   //     setLoading = false;
//   //   }
//   // }
//   Future<void> clearCart(String userId, Function? refetch) async {
//     String token = box.read("token");
//     final url = Uri.parse('$kAppBaseUrl/api/carts/clear');
//     setLoading = true;

//     try {
//       final response = await http.delete(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         // Clear local item quantities
//         _itemQuantities.clear(); // Reset the local item quantities map

//         await fetchCartCount(userId); // Update the cart count from the server
//         await refetch?.call();
//         // refetch!(); // Trigger a refetch if the function is provided
//         // if (refetch != null) {

//         // }
//         notifyListeners();

//         // showToast("Cart cleared Successfully");
//       } else {
//         showToast("No items found in cart");
//       }
//     } catch (error) {
//       print('Error clearing cart: $error');
//       rethrow;
//     } finally {
//       setLoading = false; // Reset the loading state
//     }
//   }

//   double _totalPrice = 0;
//   double get totalPrice => _totalPrice;

//   Future<void> fetchTotalCartPrice(String userId) async {
//     String? token = box.read("token");
//     if (token == null) {
//       setLoading = false;
//       return;
//     }

//     Uri url = Uri.parse("$kAppBaseUrl/api/carts/total");
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };

//     try {
//       var response = await http.get(url, headers: headers);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         _totalPrice = data['totalPrice']?.toDouble() ?? 0;
//         notifyListeners();
//       } else {
//         var error = apiErrorFromJson(response.body);
//         showToast(error.message);
//       }
//     } catch (e) {
//       showToast(e.toString());
//     }
//   }

//   // Future<void> increment(String foodId) async {
//   //   // setLoading = true;
//   //   String? token = box.read("token");
//   //   if (token == null) {
//   //     // setLoading = false;
//   //     showToast("You must be logged in to update the cart.");
//   //     return;
//   //   }

//   //   Uri url = Uri.parse("$kAppBaseUrl/api/cart/increment");
//   //   Map<String, String> headers = {
//   //     "Content-Type": "application/json",
//   //     "Authorization": "Bearer $token",
//   //   };
//   //   Map<String, dynamic> body = {
//   //     "productId": foodId,
//   //   };

//   //   try {
//   //     var response =
//   //         await http.post(url, headers: headers, body: json.encode(body));
//   //     if (response.statusCode == 200) {
//   //       String userId = box.read("userId") ?? '';
//   //       _updateItemQuantity(foodId, 1); // Adjust quantity locally
//   //       // notifyListeners();
//   //       await fetchCartCount(userId);
//   //       await fetchTotalCartPrice(userId);
//   //       notifyListeners();
//   //     } else {
//   //       var error = json.decode(response.body);
//   //       showToast(error['message']);
//   //     }
//   //   } catch (e) {
//   //     showToast(e.toString());
//   //   } finally {
//   //     // setLoading = false;
//   //   }
//   // }

//   // Future<void> decrement(String foodId) async {
//   //   setLoading = true;
//   //   String? token = box.read("token");
//   //   if (token == null) {
//   //     setLoading = false;
//   //     showToast("You must be logged in to update the cart.");
//   //     return;
//   //   }

//   //   Uri url = Uri.parse("$kAppBaseUrl/api/cart/decrement");
//   //   Map<String, String> headers = {
//   //     "Content-Type": "application/json",
//   //     "Authorization": "Bearer $token",
//   //   };
//   //   Map<String, dynamic> body = {
//   //     "productId": foodId,
//   //   };

//   //   try {
//   //     var response =
//   //         await http.post(url, headers: headers, body: json.encode(body));
//   //     if (response.statusCode == 200) {
//   //       String userId = box.read("userId") ?? '';
//   //       _updateItemQuantity(foodId, -1); // Adjust quantity locally
//   //       // notifyListeners();
//   //       await fetchCartCount(userId);
//   //       await fetchTotalCartPrice(userId);
//   //       notifyListeners();
//   //     } else {
//   //       var error = json.decode(response.body);
//   //       showToast(error['message']);
//   //     }
//   //   } catch (e) {
//   //     showToast(e.toString());
//   //   } finally {
//   //     setLoading = false;
//   //   }
//   // }

//   void _updateItemQuantity(String foodId, int change) {
//     if (_itemQuantities.containsKey(foodId)) {
//       final newQuantity = (_itemQuantities[foodId] ?? 1) + change;

//       // Ensure the quantity does not go below 1
//       _itemQuantities[foodId] = newQuantity > 1 ? newQuantity : 1;
//     } else {
//       // If item is being added for the first time
//       _itemQuantities[foodId] =
//           change > 0 ? 1 : 1; // Set to 1 only if change is positive
//     }

//     notifyListeners();
//   }

//   int getItemQuantity(String foodId) {
//     // Return the current quantity, defaulting to 1 if not found
//     return _itemQuantities[foodId] ?? 1;
//   }

//   // Future<void> increment(String foodId) async {
//   //   // Immediately update the UI
//   //   _updateItemQuantity(foodId, 1);

//   //   String? token = box.read("token") ?? '';
//   //   // if (token == null) {
//   //   //   showToast("You must be logged in to update the cart.");
//   //   //   return;
//   //   // }

//   //   Uri url = Uri.parse("$kAppBaseUrl/api/carts/increment");
//   //   Map<String, String> headers = {
//   //     "Content-Type": "application/json",
//   //     "Authorization": "Bearer $token",
//   //   };
//   //   Map<String, dynamic> body = {
//   //     "productId": foodId,
//   //   };

//   //   try {
//   //     var response =
//   //         await http.post(url, headers: headers, body: json.encode(body));
//   //     if (response.statusCode == 200) {
//   //       String userId = box.read("userId") ?? '';
//   //       await fetchCartCount(userId);
//   //       await fetchTotalCartPrice(userId);
//   //       notifyListeners();
//   //     } else {
//   //       var error = json.decode(response.body);
//   //       print(error);
//   //       // showToast(error['message']);
//   //     }
//   //   } catch (e) {
//   //     showToast(e.toString());
//   //   }
//   // }

//   Future<void> increment(String foodId) async {
//     // Get current quantity before increment
//     int currentQuantity = _itemQuantities[foodId] ?? 1;

//     // Only proceed if we're not already loading
//     // if (_isLoading) return;
//     // setLoading = true;

//     String? token = box.read("token") ?? '';
//     Uri url = Uri.parse("$kAppBaseUrl/api/carts/increment");
//     Map<String, String> headers = {
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };
//     Map<String, dynamic> body = {
//       "productId": foodId,
//     };

//     try {
//       // Update local state first with the new quantity
//       _itemQuantities[foodId] = currentQuantity + 1;
//       notifyListeners();

//       var response =
//           await http.post(url, headers: headers, body: json.encode(body));

//       if (response.statusCode == 200) {
//         String userId = box.read("userId") ?? '';
//         await fetchCartCount(userId);
//         await fetchTotalCartPrice(userId);
//       } else {
//         // Revert the local state if the server request fails
//         // _itemQuantities[foodId] = currentQuantity;
//         var error = json.decode(response.body);
//         print(error);
//       }
//     } catch (e) {
//       // Revert the local state if there's an error
//       _itemQuantities[foodId] = currentQuantity;
//       showToast(e.toString());
//     }
//   }

//   Future<void> decrement(String foodId) async {
//     _updateItemQuantity(foodId, -1); // Immediately update the UI

//     String? token = box.read("token") ?? '';
//     // if (token == null) {
//     //   showToast("You must be logged in to update the cart.");
//     //   return;
//     // }

//     Uri url = Uri.parse("$kAppBaseUrl/api/carts/decrement");
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
//         String userId = box.read("userId") ?? '';
//         await fetchCartCount(userId);
//         await fetchTotalCartPrice(userId);
//         notifyListeners();
//       } else {
//         var error = json.decode(response.body);
//         print(error);
//         // showToast(error['message']);
//       }
//     } catch (e) {
//       showToast(e.toString());
//     }
//   }

//   double getItemPrice(String foodId) {
//     return _itemPrices[foodId] ?? 0.0;
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartProvider with ChangeNotifier {
  final box = GetStorage();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final Map<String, int> _itemQuantities = {};
  final Map<String, double> _itemPrices = {};

  int _cartCount = 0;
  int get cartCount => _cartCount;

  double _totalPrice = 0;
  double get totalPrice => _totalPrice;
  // CartProvider() {
  //   initializeCart();
  // }
  // Initialize cart state when app starts
  Future<void> initializeCart() async {
    String userId = box.read("userId") ?? '';
    await syncCartState();
    await fetchCartCount(userId);
    await fetchTotalCartPrice(userId);
  }

  // Sync local state with server state
  Future<void> syncCartState() async {
    String? token = box.read("token");
    if (token == null) return;

    Uri url = Uri.parse("$kAppBaseUrl/api/carts/items");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _itemQuantities.clear();
        _itemPrices.clear(); // Clear previous prices to avoid stale data

        if (data['items'] != null && data['items'] is List) {
          for (var item in data['items']) {
            final productId = item['productId'];
            final quantity = item['quantity'];
            final price = item['price'];

            if (productId != null && quantity != null) {
              _itemQuantities[productId] = quantity;
              if (price != null) {
                _itemPrices[productId] = price.toDouble();
              }
            }
          }
        }
        notifyListeners();
      } else {
        // print(
        //     'Failed to sync cart state: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error syncing cart state: $e');
    }
  }

  Future<void> addToCart(BuildContext context, String cart) async {
    setLoading = true;

    String? token = box.read("token");
    Uri url = Uri.parse("$kAppBaseUrl/api/carts/");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token"
    };

    try {
      var response = await http.post(url, headers: headers, body: cart);
      if (response.statusCode == 201) {
        showToast("Product added to Cart");
        String userId = box.read("userId") ?? '';
        await syncCartState();
        await fetchCartCount(userId);
        await fetchTotalCartPrice(userId);
      } else {
        var error = apiErrorFromJson(response.body);
        showToast(error.message);
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      setLoading = false;
    }
  }

  Future<void> removeFromCart(String productId, Function refetch) async {
    if (_isLoading) return;
    setLoading = true;

    String? token = box.read("token");
    Uri url = Uri.parse("$kAppBaseUrl/api/carts/delete/$productId");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        _itemQuantities.remove(productId);
        _itemPrices.remove(productId);

        refetch();
        showToast("Product Removed from Cart");
        String userId = box.read("userId") ?? '';
        await fetchCartCount(userId);
        await fetchTotalCartPrice(userId);
        await syncCartState();
      } else {
        var error = apiErrorFromJson(response.body);
        showToast(error.message);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearCart(String userId, Function? refetch) async {
    if (_isLoading) return;
    setLoading = true;

    String? token = box.read("token");
    if (token == null) {
      setLoading = false;
      return;
    }

    final url = Uri.parse('$kAppBaseUrl/api/carts/clear');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _itemQuantities.clear();
        _itemPrices.clear();
        // _cartCount = 0;
        // _totalPrice = 0;

        await refetch?.call();
        await fetchCartCount(userId);
        await fetchTotalCartPrice(userId);
        // showToast("Cart cleared successfully");
      } else {
        showToast("No items found in cart");
      }
    } catch (error) {
      print('Error clearing cart: $error');
      showToast(error.toString());
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCartCount(String userId) async {
    String? token = box.read("token");
    if (token == null) return;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };
    final url = Uri.parse('$kAppBaseUrl/api/carts/count');

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _cartCount = data['cartCount'] != null ? data['cartCount'] as int : 0;
        notifyListeners();
      } else {
        throw Exception('Failed to load cart count');
      }
    } catch (error) {
      print('Error fetching cart count: $error');
    }
  }

  Future<void> fetchTotalCartPrice(String userId) async {
    String? token = box.read("token");
    if (token == null) return;

    Uri url = Uri.parse("$kAppBaseUrl/api/carts/total");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _totalPrice = data['totalPrice']?.toDouble() ?? 0;
        notifyListeners();
      } else {
        var error = apiErrorFromJson(response.body);
        showToast(error.message);
      }
    } catch (e) {
      showToast(e.toString());
    }
  }

  Future<void> increment(String foodId) async {
    // if (_isLoading) return;
    // setLoading = true;

    int currentQuantity = _itemQuantities[foodId] ?? 1;

    String? token = box.read("token") ?? '';
    Uri url = Uri.parse("$kAppBaseUrl/api/carts/increment");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> body = {
      "productId": foodId,
    };

    try {
      // Update local state immediately
      _itemQuantities[foodId] = currentQuantity + 1;
      notifyListeners();

      var response =
          await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        String userId = box.read("userId") ?? '';
        await fetchCartCount(userId);
        await fetchTotalCartPrice(userId);
        await syncCartState();
      } else {
        // Revert on failure
        // _itemQuantities[foodId] = currentQuantity;
        var error = json.decode(response.body);
        // print(error);
      }
    } catch (e) {
      // Revert on error
      _itemQuantities[foodId] = currentQuantity;
      showToast(e.toString());
    }
  }

  // Future<void> decrement(String foodId) async {
  //   // if (_isLoading) return;
  //   // setLoading = true;

  //   int currentQuantity = _itemQuantities[foodId] ?? 1;
  //   if (currentQuantity <= 1) {
  //     setLoading = false;
  //     return;
  //   }

  //   String? token = box.read("token") ?? '';
  //   Uri url = Uri.parse("$kAppBaseUrl/api/carts/decrement");
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $token",
  //   };
  //   Map<String, dynamic> body = {
  //     "productId": foodId,
  //   };

  //   try {
  //     // Update local state immediately
  //     _itemQuantities[foodId] = currentQuantity - 1;
  //     notifyListeners();

  //     var response =
  //         await http.post(url, headers: headers, body: json.encode(body));

  //     if (response.statusCode == 200) {
  //       String userId = box.read("userId") ?? '';
  //       await fetchCartCount(userId);
  //       await fetchTotalCartPrice(userId);
  //       await syncCartState();
  //     } else {
  //       // Revert on failure
  //       _itemQuantities[foodId] = currentQuantity;
  //       var error = json.decode(response.body);
  //       print(error);
  //     }
  //   } catch (e) {
  //     // Revert on error
  //     _itemQuantities[foodId] = currentQuantity;
  //     showToast(e.toString());
  //   }
  // }

  Future<void> decrement(String foodId) async {
    int currentQuantity = _itemQuantities[foodId] ?? 1;
    // Don't proceed if quantity is already at minimum
    if (currentQuantity <= 1) {
      return;
    }

    String? token = box.read("token") ?? '';
    Uri url = Uri.parse("$kAppBaseUrl/api/carts/decrement");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
    Map<String, dynamic> body = {
      "productId": foodId,
    };

    try {
      // Update local state immediately for better UX
      _itemQuantities[foodId] = currentQuantity - 1;
      notifyListeners();

      var response =
          await http.post(url, headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        String userId = box.read("userId") ?? '';
        await fetchCartCount(userId);
        await fetchTotalCartPrice(userId);
        await syncCartState();
      } else {
        // Revert on failure
        // _itemQuantities[foodId] = currentQuantity;
        // notifyListeners();
        var error = json.decode(response.body);
        // print(error);
        // showToast(error['message'] ?? 'Failed to update quantity');
      }
    } catch (e) {
      // Revert on error
      _itemQuantities[foodId] = currentQuantity;
      notifyListeners();
      showToast(e.toString());
    }
  }

  int getItemQuantity(String foodId) {
    return _itemQuantities[foodId] ?? 1;
  }

  double getItemPrice(String foodId) {
    return _itemPrices[foodId] ?? 0.0;
  }
}
