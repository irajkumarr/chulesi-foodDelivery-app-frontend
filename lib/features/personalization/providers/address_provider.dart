import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/popups/toast.dart';

import 'package:chulesi/data/models/api_error.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AddressProvider with ChangeNotifier {
  final box = GetStorage();
  bool _isLoading = false;
  String? _defaultAddressId;

  bool get isLoading => _isLoading;
  String? get defaultAddressId => _defaultAddressId;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AddressProvider() {
    _defaultAddressId = box.read('defaultAddressId');
  }

  Future<void> addAddress(BuildContext context, String data) async {
    setLoading = true;

    String? token = box.read("token");
    if (token == null) {
      setLoading = false;
      showToast("You must be logged in to add delivery address");
      return;
    }

    Uri url = Uri.parse("$kAppBaseUrl/api/addresses/");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 201) {
        final addressId = jsonDecode(response.body)["data"]['_id'];

        showToast("Address added successfully");
        await setDefaultAddress(context, addressId);
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

  Future<void> setDefaultAddress(BuildContext context, String addressId) async {
    setLoading = true;

    String? token = box.read("token");
    if (token == null) {
      setLoading = false;
      showToast("You must be logged in to set the default address");
      return;
    }

    Uri url = Uri.parse("$kAppBaseUrl/api/addresses/default/$addressId");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        _defaultAddressId = addressId;
        box.write('defaultAddressId', addressId);
        notifyListeners();
        showToast("Default address set successfully");
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

  Future<void> updateAddress(
      BuildContext context, String id, String data) async {
    setLoading = true;

    String? token = box.read("token");
    if (token == null) {
      setLoading = false;
      showToast("You must be logged in to update delivery address");
      return;
    }

    Uri url = Uri.parse("$kAppBaseUrl/api/addresses/$id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    try {
      var response = await http.put(url, headers: headers, body: data);

      // Debugging: Print the raw response
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        showToast("Address updated successfully");
        // refetch!();
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

  // Method to clear default address ID when needed
  void clearDefaultAddressId() {
    _defaultAddressId = null;
    box.remove('defaultAddressId');
    notifyListeners();
  }

  // List<AddressResponse>? _allAddresses;
  // ApiError? _error;
  // String? get error => _error?.message;

  // List<AddressResponse>? get allAddresses => _allAddresses;

  // Future<void> fetchallAddresses() async {
  //   _isLoading = true;
  //   _error = null;
  //   notifyListeners();
  //   String? token = box.read("token");
  //   if (token == null) {
  //     _error = ApiError(status: false, message: "No token found");
  //     return;
  //   }
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "Authorization": "Bearer $token"
  //   };
  //   try {
  //     final response = await http.get(Uri.parse("$kAppBaseUrl/api/addresses/"),
  //         headers: headers);

  //     if (response.statusCode == 200) {
  //       _allAddresses = addressResponseFromJson(response.body);
  //       _error = null; // No error
  //     } else {
  //       _error = ApiError(status: false, message: "Failed to load addresses.");
  //       _allAddresses = [];
  //     }
  //   } catch (e) {
  //     _error = ApiError(status: false, message: e.toString());
  //     _allAddresses = [];
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners(); // Notify UI of state change
  //   }
  // }

  // // Method to refresh categories if needed
  // Future<void> refetchAllAddresses() async {
  //   await fetchallAddresses();
  // }
}
