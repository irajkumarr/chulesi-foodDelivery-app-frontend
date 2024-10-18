import 'package:flutter/material.dart';
import 'package:chulesi/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:chulesi/core/utils/constants/colors.dart';
import 'package:chulesi/core/utils/constants/sizes.dart';
import 'package:chulesi/data/models/address_response.dart';

class AddressTile extends StatelessWidget {
  final AddressResponse address;
  final bool isSelected;
  final VoidCallback onSelect;
  final Function? onEdit;

  const AddressTile(
      {super.key,
      required this.address,
      required this.isSelected,
      required this.onSelect,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: double.infinity,
      showBorder: true,
      // color: KColors.light,
      color: KColors.white,
      radius: KSizes.sm,
      borderColor: KColors.grey,
      child: ListTile(
        title: Text(
          address.addressTitle,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: KColors.primary),
        ),
        subtitle: Text(
          address.location,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              TextButton(
                onPressed: () => onEdit!(),
                // child: Icon(Icons.edit),
                child: const Text("Edit"),
              ),
            Checkbox(
              value: isSelected,
              onChanged: (value) => onSelect(),
            ),
          ],
        ),
        onTap: () {
          onSelect();
        },
      ),
    );
  }
}
