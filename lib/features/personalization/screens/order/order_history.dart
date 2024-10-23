import 'dart:math';

import 'package:chulesi/core/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chulesi/core/network/connectivity_checker.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/hooks/fetch_order.dart';
import 'package:chulesi/data/models/order_model.dart';
import 'package:chulesi/features/personalization/screens/order/widgets/order_list.dart';


class OrderHistory extends HookWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResult = useFetchOrder();
    List<OrderModel> orderList = hookResult.data ?? [];
    // OrderModel? orderList = hookResult.data;
    final isLoading = hookResult.isLoading;
    // final apiError = hookResult.error;
    final refetch = hookResult.refetch;
    List<String> emptyOrderMessages = [
      "Your order list is empty! Hungry? Start ordering now!",
      "Looks like you haven’t ordered anything yet. Explore our menu!",
      "Nothing in your order history yet. Let’s change that!",
      "Feeling hungry? Let’s get your first order started."
    ];

// Randomly select a message from the list
    final randomOrderMessage =
        emptyOrderMessages[Random().nextInt(emptyOrderMessages.length)];
    return ConnectivityChecker(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
            child: Material(
              elevation: 1,
              child: AppBar(
                title: const Text("Your Purchase History"),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await refetch();
            },
            child: Padding(
              padding: const EdgeInsets.all(KSizes.md),
              child: isLoading
                  ? Center(
                      child: KIndicator.circularIndicator(),
                    )
                  //  const FoodsListShimmer()
                  : (orderList.isEmpty)
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 150.h,
                                  width: 150.w,
                                  child: SvgPicture.asset(
                                    KImages.trackIllustration,
                                  )),
                              SizedBox(height: KSizes.spaceBtwSections),
                              Text(
                                "No Orders Found",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              SizedBox(height: KSizes.sm),
                              Text(
                                randomOrderMessage,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (_, __) {
                            return const SizedBox(
                              height: KSizes.md,
                            );
                          },
                          itemCount: orderList.length,
                          itemBuilder: (_, index) {
                            var order = orderList[index];
                            return OrderList(
                              order: order,
                            );
                          },
                        ),
            ),
          )),
    );
  }
}
