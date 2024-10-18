import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/foods_with_offers_model.dart';

import 'package:chulesi/data/models/hook_models/hook_result.dart';
import 'package:http/http.dart' as http;

FetchHook useFetchOfferFood() {
  final context = useContext();
  final comboPackItems = useState<List<FoodsWithOffersModel>?>(null);
  final isLoading = useState(false);
  // final error = useState<Exception?>(null);
  final error = useState<ApiError?>(null);

  Future<void> fetchData() async {
    if (!context.mounted) return;
    isLoading.value = true;
    // error.value = null;
    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/foods/offers"));
      if (response.statusCode == 200) {
        if (context.mounted) {
          comboPackItems.value = foodsWithOffersModelFromJson(response.body);
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

  // void refetch() {
  //   isLoading.value = true;
  //   fetchData();
  // }
  Future<void> refetch() async {
    if (!context.mounted) return;
    isLoading.value = true;
    await fetchData();
  }

  return FetchHook(
    data: comboPackItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
