import 'package:flutter/material.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/styles/font_sizes.dart';
import 'package:location_based_attendance_app/shared/styles/font_weights.dart';

final class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    required this.controller,
    this.labelText,
    this.hintText,
    this.suffixText,
    this.helperText,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String? labelText, hintText, suffixText, helperText;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final int maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enabled, readOnly, obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      cursorColor: AppColors.primary,
      cursorErrorColor: AppColors.statusError,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      textAlign: textAlign,
      maxLines: maxLines,
      maxLength: maxLength,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(color: AppColors.darkGray, fontSize: FontSizes.standard, fontWeight: FontWeights.regular),
      decoration: InputDecoration(
        suffixText: suffixText,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.all(10),
        helperMaxLines: 3,
        errorMaxLines: 3,
        labelStyle: TextStyle(color: AppColors.darkGray, fontSize: FontSizes.standard, fontWeight: FontWeights.regular),
        floatingLabelStyle: TextStyle(
          color: AppColors.darkGray,
          fontSize: FontSizes.standard,
          fontWeight: FontWeights.regular,
        ),
        hintStyle: TextStyle(color: AppColors.darkGray, fontSize: FontSizes.standard, fontWeight: FontWeights.regular),
        suffixStyle: TextStyle(
          color: AppColors.darkGray,
          fontSize: FontSizes.standard,
          fontWeight: FontWeights.regular,
        ),
        prefixStyle: TextStyle(
          color: AppColors.darkGray,
          fontSize: FontSizes.standard,
          fontWeight: FontWeights.regular,
        ),
        helperStyle: TextStyle(color: AppColors.darkGray, fontSize: FontSizes.small, fontWeight: FontWeights.regular),
        errorStyle: TextStyle(color: AppColors.statusError, fontSize: FontSizes.small, fontWeight: FontWeights.regular),
        counterStyle: TextStyle(color: AppColors.darkGray, fontSize: FontSizes.small, fontWeight: FontWeights.regular),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.statusError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.statusError),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.tertiary),
        ),
      ),
    );
  }
}
