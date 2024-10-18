import 'dart:convert';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/data/models/address_response.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/hook_models/hook_result.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;




FetchHook useFetchDefaultAddress() {
  final box = GetStorage();
  final address = useState<AddressResponse?>(null);
  final isLoading = useState(false);
  final error = useState<ApiError?>(null);

  Future<void> fetchData() async {
    String? token = box.read("token");
    if (token == null) {
      error.value = ApiError(status: false, message: "No token found");
      return;
    }

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    isLoading.value = true;
    try {
      final response = await http
          .get(Uri.parse("$kAppBaseUrl/api/addresses/default"), headers: headers);
      if (response.statusCode == 200) {
        var data = response.body;
        var decoded = jsonDecode(data);
        address.value = AddressResponse.fromJson(decoded);
      } else {
        throw ApiError(status: false, message: "Failed to load data");
      }
    } catch (e) {
      error.value =
          e is ApiError ? e : ApiError(status: false, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, const []);

  Future<void> refetch() async {
    await fetchData();
  }

  return FetchHook(
    data: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
