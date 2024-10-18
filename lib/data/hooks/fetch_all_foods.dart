
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:chulesi/core/utils/constants/api_constants.dart';
import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/foods_model.dart';
import 'package:chulesi/data/models/hook_models/foods_hook.dart';
import 'package:http/http.dart' as http;

// FetchFood useFetchAllFoods() {
//   final context = useContext(); // Get the context
//   final foodItems = useState<List<FoodsModel>?>(null);
//   final isLoading = useState(false);
//   final error = useState<ApiError?>(null);

//   // Future<void> fetchData() async {
//   //   if (!context.mounted) return; // Check if the widget is still mounted
//   //   isLoading.value = true;

//   //   try {
//   //     final response = await http.get(Uri.parse("$kAppBaseUrl/api/food/"));
//   //     if (response.statusCode == 200) {
//   //       if (context.mounted) {
//   //         foodItems.value = foodsModelFromJson(response.body);
//   //       }
//   //     } else {
//   //       throw ApiError(status: false, message: "Failed to load data");
//   //     }
//   //   } catch (e) {
//   //     if (context.mounted) {
//   //       error.value =
//   //           e is ApiError ? e : ApiError(status: false, message: e.toString());
//   //     }
//   //   } finally {
//   //     if (context.mounted) {
//   //       isLoading.value = false;
//   //     }
//   //   }
//   // }

//   useEffect(() {
//     fetchData();
//     return null;
//   }, const []);

//   Future<void> refetch() async {
//     if (!context.mounted) return; // Check if the widget is still mounted
//     isLoading.value = true;
//     await fetchData();
//   }

//   return FetchFood(
//     data: foodItems.value,
//     isLoading: isLoading.value,
//     error: error.value,
//     refetch: refetch,
//   );
// }


FetchFood useFetchAllFoods() {
  final context = useContext();
  final foodItems = useState<List<FoodsModel>?>([]);
  final isLoading = useState(false);
  final error = useState<ApiError?>(null);
  final currentPage = useState(1);
  final hasMoreData = useState(true);

  Future<void> fetchData({int page = 1}) async {
    if (!hasMoreData.value) return; // Stop fetching if no more data

    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse("$kAppBaseUrl/api/foods/?page=$page"),
      );
      if (response.statusCode == 200) {
        // final jsonResponse = json.decode(response.body);
        // final List<FoodsModel> fetchedFoods =
        //     foodsModelFromJson(jsonResponse['foods']);
        final fetchedFoods = foodsModelFromJson(response.body);

        // Check if there are more foods to fetch
        if (fetchedFoods.isEmpty) {
          hasMoreData.value = false;
        } else {
          // If it's the first page, replace the list; otherwise, append to it
          if (page == 1) {
            foodItems.value = fetchedFoods;
          } else {
            foodItems.value = [...?foodItems.value, ...fetchedFoods];
          }
          currentPage.value = page;
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
    fetchData(page: 1);
    return null;
  }, const []);

  Future<void> refetch() async {
    if (!context.mounted) return;
    hasMoreData.value = true; // Reset for refetch
    currentPage.value = 1; // Reset to the first page
    await fetchData(page: 1);
  }

  Future<void> loadMore() async {
    if (isLoading.value || !hasMoreData.value || !context.mounted) return;
    await fetchData(page: currentPage.value + 1);
  }

  return FetchFood(
    data: foodItems.value,
    isLoading: isLoading.value,
    error: error.value,
    refetch: refetch,
    loadMore: loadMore, // Exposing the loadMore function for pagination
  );
}
