
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/hooks/fetch_address.dart';
import 'package:chulesi/data/models/address_response.dart';
import 'package:chulesi/features/personalization/screens/address/add_new_address.dart';
import 'package:chulesi/features/personalization/screens/address/widgets/address_list.dart';

import 'package:iconsax/iconsax.dart';

class AddressScreen extends HookWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchAddress();
    List<AddressResponse> addresses = hookResult.data ?? [];
    final isLoading = hookResult.isLoading;
    final refetch = hookResult.refetch;

    return ConnectivityChecker(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddressModal(context, refetch);
          },
          backgroundColor: KColors.primary,
          child: const Icon(Iconsax.add, color: KColors.white),
        ),
        appBar: AppBar(title: const Text("Delivery Address")),
        body: RefreshIndicator(
          onRefresh: () async {
            await refetch();
          },
          child: isLoading
              ? Center(
                  child: KIndicator.circularIndicator(),
                )
              // const Padding(
              //     padding: EdgeInsets.all(KSizes.md),
              //     child: FoodsListShimmer(),
              //   )
              : (addresses.isEmpty)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: KSizes.defaultSpace),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 120.h,
                                width: 120.w,
                                child: SvgPicture.asset(KImages.address)),
                            SizedBox(height: KSizes.spaceBtwSections),
                            Text("No Delivery Address",
                                style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      ),
                    )
                  : AddressList(addresses: addresses, refetch: refetch),
        ),
      ),
    );
  }
}
