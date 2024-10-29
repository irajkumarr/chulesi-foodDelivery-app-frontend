import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/promo_code_model.dart';
import 'package:chulesi/features/shop/providers/cart_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class OrderProvider with ChangeNotifier {
  final box = GetStorage();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> addOrder(BuildContext context, String data) async {
    setLoading = true;

    String? token = box.read("token");
    if (token == null) {
      setLoading = false;
      showToast("You must be logged in to place an order.");
      return false;
    }

    Uri url = Uri.parse("$kAppBaseUrl/api/orders/");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 201) {
        String userId = box.read("userId") ?? '';
        showToast("Order placed successfully");
        await Provider.of<CartProvider>(context, listen: false)
            .clearCart(userId, () {
          // Optionally, you can refetch the cart data after clearing
        });
        return true;
      } else if (response.statusCode == 400) {
        var error = apiErrorFromJson(response.body);
        showToast("Error: ${error.message}");
        print(error.message);
        return false;
      } else {
        showToast("An unexpected error occurred. Please try again.");
        print("error");
        return false;
      }
    } catch (e) {
      showToast("Error: $e");
      print(e.toString());
      return false;
    } finally {
      setLoading = false;
    }
  }

  // getting all promo available
  List<PromoCodeModel> _promoCodes = [];

  List<PromoCodeModel> get promoCodes => _promoCodes;

  Future<void> getPromoCodes() async {
    String? token = box.read("token");
    setLoading = true;

    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/promoCodes'),
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        // List<dynamic> jsonResponse = json.decode(response.body);
        // _promoCodes =
        //     jsonResponse.map((data) => PromoCodeModel.fromJson(data)).toList();
        _promoCodes = promoCodeModelFromJson(response.body);
      } else {
        _promoCodes = [];
        print("error");
      }
    } catch (e) {
      _promoCodes = [];
      print(e.toString());
    } finally {
      setLoading = false;
      notifyListeners();
    }
  }
}
