import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_based_attendance_app/blocs/authentication/authentication_bloc.dart';
import 'package:location_based_attendance_app/core/routes/routes.dart';
import 'package:location_based_attendance_app/shared/extensions/navigator_extension.dart';
import 'package:location_based_attendance_app/shared/extensions/widget_gap_extension.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';
import 'package:location_based_attendance_app/shared/widgets/custom_elevated_button.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  void _handleBackNavigation(BuildContext context, AuthenticationState state) {
    if (context.canPop()) {
      context.pop();
      return;
    }
    if (state is AuthenticationValidateSuccess) {
      context.pushNamedAndRemoveUntil(pageRoute: Routes.attendance, arguments: state.userId);
      return;
    }
    context.pushNamedAndRemoveUntil(pageRoute: Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight, maxHeight: double.infinity),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    70.gapHeight,
                    Text(
                      'Halaman Tidak Ditemukan',
                      style: TextStyle(
                        color: AppColors.darkGray,
                        fontSize: FontSizes.semiLarge,
                        fontWeight: FontWeights.semiBold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (BuildContext context, AuthenticationState state) {
                        return CustomElevatedButton.primary(
                          onPressed: () => _handleBackNavigation(context, state),
                          title: 'Kembali',
                          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 80),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
