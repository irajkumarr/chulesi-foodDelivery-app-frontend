
import 'package:flutter/material.dart';

import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/data/models/api_error.dart';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:chulesi/data/models/login_response.dart';


class LoginProvider with ChangeNotifier {
  final box = GetStorage();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  LoginResponse? user; // Add user variable
  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//login
  Future<void> login(BuildContext context, String data) async {
    setLoading = true;
    Uri url = Uri.parse("$kAppBaseUrl/login");
    Map<String, String> headers = {"Content-Type": "application/json"};

    try {
      var response = await http.post(url, headers: headers, body: data);

      if (response.statusCode == 200) {
        LoginResponse loginResponse = loginResponseFromJson(response.body);
        String userId = loginResponse.id;
        String userData = jsonEncode(loginResponse);

        box.write(userId, userData);
        box.write("token", loginResponse.userToken);
        box.write("userId", loginResponse.id);

        setLoading = false;

        showToast("You are successfully logged in");
        Navigator.pushNamedAndRemoveUntil(
            context, "/navigationMenu", (route) => false);

      } else {
        setLoading = false;
        var error = apiErrorFromJson(response.body);

        // showToast("Invalid email/phone or password");
        showToast(error.message);
      }
    } catch (e) {
      setLoading = false;
      debugPrint(e.toString());
      showToast("An error occurred. Please try again.");
    }
  }

//logout
  Future<void> logout(BuildContext context) async {
    while (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
    setLoading = true;
    // await Future.delayed(Duration(seconds: 2));
    box.erase();

    setLoading = false;
    notifyListeners();
    showToast("Logout Successfully");

    Navigator.pushNamedAndRemoveUntil(context, "/splash", (route) => false);
  }

//getting user data
  LoginResponse? getUserInfo() {
    String? userId = box.read("userId");
    String? data;

    if (userId != null) {
      data = box.read(userId);
    }

    if (data != null) {
      return loginResponseFromJson(data);
    }

    return null;
  }

  //delete
  Future<void> delete(BuildContext context) async {
    while (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
    setLoading = true;
    String? token = box.read("token");

    if (token == null) {
      showToast("Token not found");
      setLoading = false;
      return;
    }

    Uri url = Uri.parse("$kAppBaseUrl/api/users/");

    try {
      var response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        await box.remove("token");

        // Clear user data
        await clearUserData();
        showToast("Account deleted successfully");
        // Navigate to splash screen after token remove
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/splash", (route) => false);
          setLoading = false;
          notifyListeners();
        });
      } else {
        setLoading = false;
        var error = response.body;
        print(error);
        // showToast("Error: $error");
        showToast("Error deleting account");
      }
    } catch (e) {
      setLoading = false;
      debugPrint("Exception caught: $e");
      showToast("An error occurred: $e");
    }
  }

  late String _otp;

  String get otp => _otp;

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  Future<void> forgotPassword(BuildContext context, String email) async {
    setLoading = true;
    notifyListeners();
    final url = Uri.parse('$kAppBaseUrl/api/users/forgot-password');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        setLoading = false;
        notifyListeners();
        // Handle success
        // showToast('OTP sent to email successfully');
        // print('otp sent successfully');
        final data = json.decode(response.body);
        showToast(data['message']);
        Navigator.pushNamedAndRemoveUntil(
            context, "/resetPassword", arguments: email, (route) => false);
      } else {
        // Handle error
        setLoading = false;
        notifyListeners();
        final errorResponse = json.decode(response.body);
        showToast(errorResponse['message']);
      }
    } catch (error) {
      setLoading = false;
      notifyListeners();
      showToast(error.toString());
      print(error.toString());
    }
  }

  Future<void> resendCode(BuildContext context, String email) async {
    setLoading = true;
    notifyListeners();
    final url = Uri.parse('$kAppBaseUrl/api/users/forgot-password');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        setLoading = false;
        notifyListeners();
        // Handle success
        final data = json.decode(response.body);
        showToast(data['message']);
      } else {
        // Handle error
        setLoading = false;
        notifyListeners();
        final errorResponse = json.decode(response.body);
        showToast(errorResponse['message']);
      }
    } catch (error) {
      setLoading = false;
      notifyListeners();
      showToast(error.toString());
    }
  }

  Future<void> resetPassword(BuildContext context, String email, String otp,
      String newPassword) async {
    setLoading = true;
    notifyListeners();
    final url = Uri.parse('$kAppBaseUrl/api/users/reset-password');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'otp': otp,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        setLoading = false;
        notifyListeners();
        // Handle success
        final data = json.decode(response.body);
        showToast(data["message"]);
        // showToast('Password reset successfully');
        // print('Password reset successfully');

        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        // Handle error
        setLoading = false;
        notifyListeners();
        final errorResponse = json.decode(response.body);
        showToast(errorResponse['message']);
      }
    } catch (error) {
      setLoading = false;
      notifyListeners();
      showToast(error.toString());
    }
  }

//clearing data from loginresponse
  Future<void> clearUserData() async {
    user = null;
    notifyListeners();
  }
}
