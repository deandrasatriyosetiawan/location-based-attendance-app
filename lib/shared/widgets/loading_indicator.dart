import 'package:flutter/material.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }
}
