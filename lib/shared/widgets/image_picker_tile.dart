import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_based_attendance_app/cubits/image_picker/image_picker_cubit.dart';
import 'package:location_based_attendance_app/shared/styles/app_colors.dart';
import 'package:location_based_attendance_app/shared/widgets/loading_indicator.dart';

class ImagePickerTile extends StatelessWidget {
  const ImagePickerTile({super.key});

  void _pickImage(BuildContext context, {required ImageSource source}) {
    context.read<ImagePickerCubit>().pickImage(source: source);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _pickImage(context, source: ImageSource.camera),
        child: BlocBuilder<ImagePickerCubit, ImagePickerState>(
          builder: (BuildContext context, ImagePickerState state) {
            if (state.isSuccess) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: RepaintBoundary(child: Image.file(state.image!, width: 240, height: 240, fit: BoxFit.cover)),
              );
            } else {
              return Container(
                width: 280,
                height: 168,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.tertiary),
                ),
                child: state.isLoading ? const LoadingIndicator() : Icon(Icons.image, color: AppColors.secondary),
              );
            }
          },
        ),
      ),
    );
  }
}
