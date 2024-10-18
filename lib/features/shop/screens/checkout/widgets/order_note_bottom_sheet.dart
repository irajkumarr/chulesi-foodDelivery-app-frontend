import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/core/utils/popups/toast.dart';

class OrderNoteBottomSheet extends StatelessWidget {
  final TextEditingController orderNoteController;
  final Function(String) onSave;

  const OrderNoteBottomSheet({
    super.key,
    required this.orderNoteController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom:
            bottomInset + 16.0.h, // Add extra padding to avoid keyboard overlap
      ),
      child: FocusScope(
        node: FocusScopeNode(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add an Order Note',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: KSizes.spaceBtwItems),
              TextField(
                controller: orderNoteController,
                maxLines: 5,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Order Note',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: KColors.darkGrey),
                  labelText: 'Order Note',
                ),
              ),
              const SizedBox(height: KSizes.md),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
                  ),
                  onPressed: () {
                    final orderNote = orderNoteController.text;
                    if (orderNote.isNotEmpty) {
                      onSave(orderNote);
                      showToast("Order note Saved");
                      Navigator.pop(context);
                    } else {
                      showToast("Please enter an order note.");
                    }
                  },
                  child: const Text('Submit Note'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
