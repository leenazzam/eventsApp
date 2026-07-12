import 'package:events/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.borderColor,
    this.textStyle,
    this.isExpanded = true,
  });

  final dynamic value;
  final List<DropdownMenuItem> items;
  final ValueChanged onChanged;
  final Color? borderColor;
  final TextStyle? textStyle;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor ?? AppColors.primaryLight,
          width: 2,
        ),
      ),
      child: DropdownButton(
        underline: Container(),
        style:
            textStyle ?? TextStyle(color: AppColors.blackColor, fontSize: 20),
        value: value,
        isExpanded: isExpanded,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
