import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/data/models/login_response.dart';
import 'package:chulesi/data/models/user_profile_model.dart';

import 'package:chulesi/features/authentication/providers/login_provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProfileProvider extends ChangeNotifier {
  final box = GetStorage();
  bool isLoading = true;
  LoginResponse? user;

  final LoginProvider loginProvider;

  ProfileProvider({required this.loginProvider}) {
    _init();
  }

  Future<void> _init() async {
    String? token = box.read("token");

    if (token == null) {
      isLoading = false;
      user = null;
      notifyListeners();
      return; // Return early if token is not found
    }

    try {
      user = loginProvider.getUserInfo();
      notifyListeners();
    } catch (e) {
      user = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearUserData() {
    user = null;
    notifyListeners();
  }

  Future<void> changePassword(
      BuildContext context, String oldPassword, String newPassword) async {
    isLoading = true;
    notifyListeners();
    final url = Uri.parse('$kAppBaseUrl/api/users/change-password');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user!.userToken}',
        },
        body: json.encode({
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        // await Future.delayed(Duration(seconds: 2));
        isLoading = false;
        notifyListeners();
        // Handle success
        final data = json.decode(response.body);
        showToast(data['message']);
        // showToast('Password changed successfully');
        // print('Password changed successfully');
        Navigator.pop(context);
      } else {
        // Handle error
        isLoading = false;
        notifyListeners();
        final errorResponse = json.decode(response.body);
        showToast(errorResponse['message']);
        // showToast('Failed to change password');
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      // showToast(error.toString());
      showToast('An error occurred while changing the password');
    }
  }

  Future<void> updateProfile(
      BuildContext context, UserProfileModel updatedUser) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse('$kAppBaseUrl/api/users');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${user?.userToken}',
        },
        body: json.encode(updatedUser.toJson()),
      );

      if (response.statusCode == 200) {
        user = LoginResponse(
          id: user!.id,
          firstName: updatedUser.firstName,
          lastName: updatedUser.lastName,
          email: updatedUser.email,
          phone: updatedUser.phone,
          userToken: user!.userToken,
          uid: user!.uid,
          fcm: user!.fcm,
          verification: user!.verification,
          userType: user!.userType,
        );
        // Update the cache (GetStorage)
        String updatedUserData = jsonEncode(user);
        box.write(user!.id, updatedUserData); // Update user cache by ID
        box.write("userId", user!.id); // Make sure userId is updated in cache

        showToast('Profile Updated Successfully');
        Navigator.pop(context);
      } else {
        isLoading = false;
        notifyListeners();
        showToast('Failed to update profile');
      }
    } catch (error) {
      isLoading = false;
      notifyListeners();
      showToast('An error occurred while updating the profile');
      // rethrow; // Or handle the error accordingly
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
