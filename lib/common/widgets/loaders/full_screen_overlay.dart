import 'package:flutter/material.dart';


import '../../../core/utils/constants/colors.dart';

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
              child: const Center(
                child: CircularProgressIndicator(
                  color: KColors.primary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
