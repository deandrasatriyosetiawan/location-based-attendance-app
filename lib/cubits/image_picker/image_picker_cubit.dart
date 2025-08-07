import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_based_attendance_app/services/image_picker_service.dart';
import 'package:location_based_attendance_app/shared/extensions/string_validation_extension.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit({required ImagePickerService imagePickerService})
    : _imagePickerService = imagePickerService,
      super(ImagePickerState());

  final ImagePickerService _imagePickerService;

  void clear() => emit(ImagePickerState());

  Future<void> pickImage({required ImageSource source}) async {
    try {
      final File? pickedImage = await _imagePickerService.pickImage(source: source);

      if (pickedImage == null) {
        emit(state.copyWith(isLoading: false));

        return;
      }

      emit(ImagePickerState(isLoading: true));

      if (pickedImage.path.isNotImage) {
        emit(state.copyWith(isLoading: false, errorMessage: 'File harus berupa PNG atau JPG.'));

        return;
      }

      final Directory appDir = await getApplicationDocumentsDirectory();
      final String fileName = basename(pickedImage.path);
      final String localPath = join(appDir.path, fileName);

      final File imageFile = File(pickedImage.path);
      await imageFile.copy(localPath);

      emit(ImagePickerState(image: pickedImage, localPath: localPath));
    } catch (error) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Gagal mengambil gambar.'));
    }
  }
}
