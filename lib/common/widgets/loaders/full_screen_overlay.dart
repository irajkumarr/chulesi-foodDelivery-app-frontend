import 'package:chulesi/core/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class FullScreenOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const FullScreenOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Lottie.asset(
                  KImages.loadingAnimation,
                  width: 75.w,
                  height: 75.h,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
