// import 'package:chulesi/common/widgets/products/products_text/product_title_text.dart';
import 'package:chulesi/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:chulesi/core/utils/device/device_utility.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:chulesi/core/services/notification_service.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/notification_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationService _notificationService = NotificationService();
  final box = GetStorage();

  NotificationScreen({super.key});

  Future<void> _refreshNotifications() async {
    _notificationService.getStoredNotifications();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final notifications = box.read<List<dynamic>>('notifications') ?? [];
    notifications.sort((a, b) {
      final notificationA = NotificationModel.fromJson(a);
      final notificationB = NotificationModel.fromJson(b);
      return notificationB.date.compareTo(notificationA.date);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Iconsax.trash),
        //     onPressed: () {
        //       _notificationService.clearNotifications();
        //       // Refresh the screen to show no notifications
        //       (context as Element).reassemble();
        //     },
        //   ),
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNotifications,
        child: notifications.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(KSizes.md),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification =
                        NotificationModel.fromJson(notifications[index]);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(KSizes.sm),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: KColors.primary.withOpacity(0.1),
                              ),
                              child: const Icon(
                                Icons.notifications,
                                color: KColors.primary,
                              ),
                            ),
                            const SizedBox(width: KSizes.md),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 100,
                                  child: Text(
                                    notification.title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: KSizes.xs),
                                Text(
                                  DateFormat('dd MMM yyyy, hh:mm a')
                                      .format(notification.date),
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: KSizes.md),
                        if (notification.imageUrl != null) ...[
                          SizedBox(
                            height: 150.h,
                            width: KDeviceUtils.getScreenWidth(context),
                            child: CachedNetworkImage(
                              imageUrl: notification.imageUrl!,
                              // placeholder: (context, url) => SizedBox(
                              //   // height: 120.h,
                              //   width: KDeviceUtils.getScreenWidth(context),
                              //   child: Image.asset(
                              //     KImages.banner_placeholder,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              placeholder: (context, url) => SizedBox(
                                  height: 150.h,
                                  width: KDeviceUtils.getScreenWidth(context),
                                  child: Center(
                                    child: KIndicator.circularIndicator(),
                                  )),
                              errorWidget: (context, url, error) => Image.asset(
                                KImages.banner_placeholder,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: KSizes.sm),
                        ],
                        Text(
                          notification.body,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        // SizedBox(height: KSizes.sm),
                        const Divider(
                          thickness: 0.3,
                          color: KColors.darkGrey,
                        ),
                        // SizedBox(height: KSizes.sm),
                      ],
                    );
                  },
                ),
              )
            : Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: KSizes.spaceBtwSections),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        KImages.noNotification,
                        width: 60.w,
                      ),
                      SizedBox(height: KSizes.spaceBtwSections),
                      Text(
                        "No Notifications",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: KSizes.spaceBtwItems),
                      Text(
                        "You do not have any notifications at this time",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
