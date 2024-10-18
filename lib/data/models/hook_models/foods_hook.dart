import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/foods_model.dart';

class FetchFood {
  final List<FoodsModel>? data;
  final bool isLoading;
  final ApiError? error;
  // final Exception? error;
  // final VoidCallback refetch;
  final Future<void> Function() refetch;
  final Future<void> Function()? loadMore;
   

  FetchFood({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
     this.loadMore,
  });
}
