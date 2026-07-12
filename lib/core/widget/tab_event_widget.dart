import 'package:events/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TabEventWidget extends StatelessWidget {
  TabEventWidget({
    super.key,
    required this.eventName,
    required this.isSelected,
    this.color,
    this.selectedTextColor,
  });
  String eventName;
  bool isSelected;
  Color? color;
  Color? selectedTextColor;

  @override
  Widget build(BuildContext context) {
    final baseColor = color ?? AppColors.whiteColor;
    final selectedColor = selectedTextColor ?? AppColors.primaryLight;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? baseColor : AppColors.transparentColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: baseColor, width: 2),
      ),
      child: Text(
        eventName,
        style: TextStyle(color: isSelected ? selectedColor : baseColor),
      ),
    );
  }
}
