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
    return ConnectivityChecker(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Order History",
              style: Theme.of(context).textTheme.headlineSmall,
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
                                  height: 120.h,
                                  width: 120.w,
                                  child: SvgPicture.asset(KImages.order)),
                              SizedBox(height: KSizes.spaceBtwSections),
                              Text(
                                "No Order History",
                                style: Theme.of(context).textTheme.titleLarge,
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
// Container(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               "No Purchase History",
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),