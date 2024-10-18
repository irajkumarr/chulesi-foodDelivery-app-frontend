import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/categories_model.dart';

class FetchCategory {
  final List<CategoriesModel>? data;
  final bool isLoading;
  final ApiError? error;
  // final VoidCallback refetch;
   final Future<void> Function() refetch;

  FetchCategory({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
