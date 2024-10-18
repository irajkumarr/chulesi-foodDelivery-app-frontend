import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/cart_response.dart';
import 'package:chulesi/data/models/hook_models/cart_hook.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

FetchCart useFetchCart() {
  final context = useContext();
  final box = GetStorage();
  final cart = useState<List<CartResponse>?>(null);
  final isLoading = useState(false);
  final error = useState<ApiError?>(null);

  Future<void> fetchData() async {
    if (!context.mounted) return;
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
      Uri url = Uri.parse("$kAppBaseUrl/api/carts/");
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        if (context.mounted) {
          cart.value = cartResponseFromJson(response.body);
        }
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

  return FetchCart(
    data: cart.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
