import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/order_model.dart';

class FetchOrder {
  final List<OrderModel>? data;
  final bool isLoading;
  final ApiError? error;
  // final VoidCallback refetch;
   final Future<void> Function() refetch;

  FetchOrder({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
