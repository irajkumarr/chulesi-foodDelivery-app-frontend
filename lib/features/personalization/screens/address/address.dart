import 'dart:math';

import 'package:chulesi/core/utils/device/device_utility.dart';
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
    List<String> emptyMessages = [
      "Where are we delivering today? Add your address to begin.",
      "Let's get you set up! Add a delivery address to start.",
      "You haven't added an address yet! Let's fix that.",
      "Ready to explore? Add your delivery address now!"
    ];

    // Randomly select a message from the list
    final randomMessage = emptyMessages[Random().nextInt(emptyMessages.length)];
    return ConnectivityChecker(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddressModal(context, refetch);
          },
          backgroundColor: KColors.primary,
          child: const Icon(Iconsax.add, color: KColors.white),
        ),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
            child: Material(
                elevation: 1,
                child: AppBar(title: const Text("Your Delivery Address")))),
        body: RefreshIndicator(
          onRefresh: () async {
            await refetch();
          },
          child: isLoading
              ? Center(
                  child: KIndicator.circularIndicator(),
                )
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
                                height: 200.h,
                                width: 200.w,
                                child: SvgPicture.asset(
                                    KImages.deliveryIllustration)),
                            // SizedBox(height: KSizes.spaceBtwSections),
                            Text("No Delivery Address Found",
                                style: Theme.of(context).textTheme.titleLarge),
                            SizedBox(height: KSizes.sm),
                            Text(
                              randomMessage,
                              style: Theme.of(context).textTheme.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                            // Text(
                            //   "Delivery options and delivery speeds may vary for different locations.",
                            //   style: Theme.of(context).textTheme.bodySmall,
                            //   textAlign: TextAlign.center,
                            // ),
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
