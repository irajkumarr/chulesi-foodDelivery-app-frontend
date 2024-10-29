import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/data/models/address_response.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/hook_models/address_hook.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

FetchAddress useFetchAddress() {
  final context = useContext();
  final box = GetStorage();
  final address = useState<List<AddressResponse>?>(null);
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
      final response = await http.get(Uri.parse("$kAppBaseUrl/api/addresses"),
          headers: headers);
      if (response.statusCode == 200) {
        if (context.mounted) {
          address.value = addressResponseFromJson(response.body);
        }
        error.value = null;
      } else {
        throw ApiError(status: false, message: "Failed to load data");
      }
    } catch (e) {
      if (context.mounted) {
        error.value =
            e is ApiError ? e : ApiError(status: false, message: e.toString());
      }
    } finally {
      if (context.mounted) {
        isLoading.value = false;
      }
    }
  }

  useEffect(() {
    fetchData();
    return null;
  }, const []);

  Future<void> refetch() async {
    if (!context.mounted) return;
    isLoading.value = true;
    await fetchData();
  }

  return FetchAddress(
    data: address.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
