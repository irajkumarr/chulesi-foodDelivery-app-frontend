import 'package:chulesi/data/models/address_response.dart';
import 'package:chulesi/data/models/api_error.dart';

class FetchAddress {
  final List<AddressResponse>? data;
  final bool isLoading;
  final ApiError? error;
  // final VoidCallback refetch;
   final Future<void> Function() refetch;

  FetchAddress({
    required this.data,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
