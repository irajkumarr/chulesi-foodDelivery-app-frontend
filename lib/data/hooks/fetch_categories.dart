import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/hook_models/category_hook.dart';
import 'package:http/http.dart' as http;
import 'package:chulesi/data/models/categories_model.dart';

FetchCategory useFetchCategories() {
  final context = useContext();
  final categoryItems = useState<List<CategoriesModel>?>(null);
  final isLoading = useState(false);
  final error = useState<ApiError?>(null);

  Future<void> fetchData() async {
    if (!context.mounted) return;
    isLoading.value = true;
    try {
      final response =
          await http.get(Uri.parse("$kAppBaseUrl/api/categories/best"));
      if (response.statusCode == 200) {
        if (context.mounted) {
          categoryItems.value = categoriesModelFromJson(response.body);
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

  return FetchCategory(
    data: categoryItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
  );
}
