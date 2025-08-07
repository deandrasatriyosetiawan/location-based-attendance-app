import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_based_attendance_app/blocs/authentication/authentication_bloc.dart';
import 'package:location_based_attendance_app/core/routes/routes.dart';
import 'package:location_based_attendance_app/shared/extensions/navigator_extension.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void _handleAuthenticationState(BuildContext context, AuthenticationState state) {
    if (state is AuthenticationValidateSuccess) {
      Timer(
        const Duration(seconds: 1),
        () => context.pushNamedAndRemoveUntil(pageRoute: Routes.attendance, arguments: state.userId),
      );
    } else if (state is AuthenticationValidateFailure) {
      Timer(const Duration(seconds: 1), () => context.pushNamedAndRemoveUntil(pageRoute: Routes.login));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: _handleAuthenticationState,
      child: Scaffold(
        backgroundColor: AppColors.tertiary,
        body: SafeArea(
          child: Center(
            child: Text(
              'Presensi',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: FontSizes.extraLarge,
                fontWeight: FontWeights.semiBold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
