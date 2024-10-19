import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/core/utils/popups/toast.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/success_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SignupProvider with ChangeNotifier {
  final box = GetStorage();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signup(BuildContext context, String data) async {
    setLoading = true;
    Uri url = Uri.parse("$kAppBaseUrl/register");
    Map<String, String> headers = {"Content-Type": "application/json"};

    try {
      var response = await http.post(url, headers: headers, body: data);
      // print(response.statusCode);
      if (response.statusCode == 201) {
        var data = successModelFromJson(response.body);

        setLoading = false;

        showToast(" ${data.message}");

        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        setLoading = false;
        var error = apiErrorFromJson(response.body);

        showToast(error.message);
      }
    } catch (e) {
      // debugPrint(e.toString());
      showToast(e.toString());
    }
  }
}
