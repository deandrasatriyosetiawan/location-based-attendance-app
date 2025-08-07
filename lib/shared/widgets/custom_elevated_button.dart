import 'package:flutter/material.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';

final class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton.primary({
    required this.onPressed,
    required this.title,
    this.height = 50,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.borderRadius = 30,
    this.borderSide = BorderSide.none,
    super.key,
  }) : backgroundColor = AppColors.primary,
       titleStyle = TextStyle(color: AppColors.white, fontSize: FontSizes.medium, fontWeight: FontWeights.bold);

  CustomElevatedButton.secondary({
    required this.onPressed,
    required this.title,
    this.height = 30,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.borderRadius = 10,
    this.backgroundColor = AppColors.secondary,
    this.borderSide = BorderSide.none,
    super.key,
  }) : titleStyle = TextStyle(color: AppColors.white, fontSize: FontSizes.standard, fontWeight: FontWeights.semiBold);

  final VoidCallback? onPressed;
  final String title;
  final double width, height, borderRadius;
  final Color backgroundColor;
  final TextStyle titleStyle;
  final EdgeInsets margin;
  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          shadowColor: backgroundColor,
          shape: RoundedRectangleBorder(side: borderSide, borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: Text(title, style: titleStyle),
      ),
    );
  }
}
