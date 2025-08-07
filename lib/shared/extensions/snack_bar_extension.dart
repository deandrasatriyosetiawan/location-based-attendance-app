import 'package:flutter/material.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/widgets/custom_snack_bar.dart';

extension SnackBarExtension on BuildContext {
  void showFloatingErrorSnackBar({required String message}) {
    final SnackBar customSnackBar = CustomSnackBar.show(
      message: message,
      maxLines: 3,
      backgroundColor: AppColors.statusError,
      textOverflow: TextOverflow.ellipsis,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
    );

    ScaffoldMessenger.of(this).showSnackBar(customSnackBar);
  }

  void showFloatingSuccessSnackBar({required String message}) {
    final SnackBar customSnackBar = CustomSnackBar.show(
      message: message,
      maxLines: 3,
      backgroundColor: AppColors.statusSuccess,
      textOverflow: TextOverflow.ellipsis,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.endToStart,
    );

    ScaffoldMessenger.of(this).showSnackBar(customSnackBar);
  }
}
