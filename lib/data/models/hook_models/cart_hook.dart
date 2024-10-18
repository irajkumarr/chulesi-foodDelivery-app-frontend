import 'package:chulesi/data/models/api_error.dart';
import 'package:chulesi/data/models/cart_response.dart';

class FetchCart {
  final List<CartResponse>? data;
  final bool isLoading;
  final ApiError? error;
  // final VoidCallback refetch;
  final Future<void> Function() refetch;

  FetchCart({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
