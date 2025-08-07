import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_based_attendance_app/blocs/authentication/authentication_bloc.dart';
import 'package:location_based_attendance_app/blocs/create_user/create_user_bloc.dart';
import 'package:location_based_attendance_app/core/routes/routes.dart';
import 'package:location_based_attendance_app/requests/create_user_request.dart';
import 'package:location_based_attendance_app/shared/constants/error_messages.dart';
import 'package:location_based_attendance_app/shared/extensions/navigator_extension.dart';
import 'package:location_based_attendance_app/shared/extensions/snack_bar_extension.dart';
import 'package:location_based_attendance_app/shared/extensions/widget_gap_extension.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';
import 'package:location_based_attendance_app/shared/widgets/clickable_rich_text.dart';
import 'package:location_based_attendance_app/shared/widgets/custom_elevated_button.dart';
import 'package:location_based_attendance_app/shared/widgets/custom_text_form_field.dart';
import 'package:location_based_attendance_app/shared/widgets/loading_indicator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final AuthenticationBloc _authenticationBloc;
  late final CreateUserBloc _createUserBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = context.read<AuthenticationBloc>();
    _createUserBloc = context.read<CreateUserBloc>();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    _authenticationBloc.add(
      RegisterStarted(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      ),
    );
  }

  void _handleAuthenticationState(BuildContext context, AuthenticationState state) {
    if (state is RegisterSuccess) {
      context.showFloatingSuccessSnackBar(message: state.message);
    } else if (state is AuthenticationValidateSuccess) {
      _createUserBloc.add(
        CreateUserRequested(
          CreateUserRequest(
            userId: state.userId,
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
          ),
        ),
      );

      Timer(
        const Duration(seconds: 1),
        () => context.pushNamedAndRemoveUntil(pageRoute: Routes.attendance, arguments: state.userId),
      );
    } else if (state is RegisterFailure) {
      context.showFloatingErrorSnackBar(message: state.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight, maxHeight: double.infinity),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        32.gapHeight,
                        Text(
                          'Daftar dengan isi data berikut:',
                          style: TextStyle(
                            color: AppColors.darkGray,
                            fontSize: FontSizes.standard,
                            fontWeight: FontWeights.regular,
                          ),
                        ),
                        16.gapHeight,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              spacing: 20,
                              children: <Widget>[
                                CustomTextFormField(
                                  controller: _nameController,
                                  labelText: 'Nama',
                                  textCapitalization: TextCapitalization.words,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ErrorMessages.nameRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  controller: _emailController,
                                  labelText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ErrorMessages.emailRequired;
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormField(
                                  controller: _passwordController,
                                  labelText: 'Kata Sandi',
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ErrorMessages.passwordRequired;
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListBody(
                      children: <Widget>[
                        40.gapHeight,
                        BlocConsumer<AuthenticationBloc, AuthenticationState>(
                          listener: _handleAuthenticationState,
                          builder: (BuildContext context, AuthenticationState state) {
                            if (state is RegisterInProgress) {
                              return const LoadingIndicator();
                            }

                            return CustomElevatedButton.primary(
                              onPressed: () => _register(),
                              title: 'Daftar',
                              margin: const EdgeInsets.symmetric(horizontal: 12),
                            );
                          },
                        ),
                        30.gapHeight,
                        ClickableRichText(
                          textAlign: TextAlign.center,
                          plainText: 'Sudah punya akun? ',
                          clickableTextData: <ClickableTextData>[
                            ClickableTextData(text: 'Masuk', onTap: () => context.pop()),
                          ],
                          plainTextStyle: TextStyle(
                            color: AppColors.darkGray,
                            fontSize: FontSizes.regular,
                            fontWeight: FontWeights.regular,
                          ),
                          clickableTextStyle: TextStyle(
                            color: AppColors.darkGray,
                            fontSize: FontSizes.regular,
                            fontWeight: FontWeights.medium,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        40.gapHeight,
                      ],
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
