import 'package:flutter/material.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';

final class CustomSnackBar {
  const CustomSnackBar._();

  static SnackBar show({
    required String message,
    Duration duration = const Duration(seconds: 3),
    int? maxLines,
    Color? backgroundColor,
    TextOverflow? textOverflow,
    SnackBarBehavior? behavior,
    DismissDirection? dismissDirection,
  }) => SnackBar(
    content: Text(
      message,
      style: TextStyle(color: AppColors.white, fontSize: FontSizes.regular, fontWeight: FontWeights.regular),
      maxLines: maxLines,
      overflow: textOverflow,
    ),
    elevation: 0,
    backgroundColor: backgroundColor ?? AppColors.darkGray,
    duration: duration,
    showCloseIcon: true,
    behavior: behavior,
    dismissDirection: dismissDirection,
  );
}
