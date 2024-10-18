
import 'package:flutter/material.dart';

class PasswordProvider with ChangeNotifier {
  bool _oldPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _confirmPasswordVisible = true;
  bool _signupPasswordVisible = true;
  bool _signupConfirmPasswordVisible = true;
  bool _loginPasswordVisible = true;

  bool get oldPasswordVisible => _oldPasswordVisible;
  bool get newPasswordVisible => _newPasswordVisible;
  bool get confirmPasswordVisible => _confirmPasswordVisible;
  bool get signupPasswordVisible => _signupPasswordVisible;
  bool get signupConfirmPasswordVisible => _signupConfirmPasswordVisible;
  bool get loginPasswordVisible => _loginPasswordVisible;

  void toggleSignupPasswordVisibility() {
    _signupPasswordVisible = !_signupPasswordVisible;
    notifyListeners();
  }
  void toggleSignupConfirmPasswordVisibility() {
    _signupConfirmPasswordVisible = !_signupConfirmPasswordVisible;
    notifyListeners();
  }
  void toggleLoginPasswordVisibility() {
    _loginPasswordVisible = !_loginPasswordVisible;
    notifyListeners();
  }
  void toggleOldPasswordVisibility() {
    _oldPasswordVisible = !_oldPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    _newPasswordVisible = !_newPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    _confirmPasswordVisible = !_confirmPasswordVisible;
    notifyListeners();
  }
}
