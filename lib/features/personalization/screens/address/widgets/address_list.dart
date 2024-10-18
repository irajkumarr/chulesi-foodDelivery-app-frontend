import 'package:flutter/material.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';

import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/address_response.dart';
import 'package:chulesi/features/personalization/providers/address_provider.dart';
import 'package:chulesi/features/personalization/screens/address/add_new_address.dart';
import 'package:chulesi/features/personalization/screens/address/widgets/address_tile.dart';
import 'package:provider/provider.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    super.key,
    required this.addresses,
    required this.refetch,
  });
  final List<AddressResponse> addresses;
  final Function refetch;
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Container(
      child: addressProvider.isLoading
          ? KIndicator.circularIndicator()
          : Consumer<AddressProvider>(
              builder: (context, provider, _) {
                final defaultAddressId = provider.defaultAddressId;

                return ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: KSizes.md),
                      child: Container(
                        margin: const EdgeInsets.only(top: KSizes.md),
                        decoration: BoxDecoration(
                          color: KColors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: AddressTile(
                            address: address,
                            isSelected: address.id == defaultAddressId,
                            onSelect: () async {
                              if (address.id != defaultAddressId) {
                                await addressProvider.setDefaultAddress(
                                  context,
                                  address.id,
                                );
                              }
                            },
                            onEdit: () {
                              showAddressModal(
                                context,
                                () async {
                                  refetch();
                                },
                                address: address,
                              );
                            }),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
