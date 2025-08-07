import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  const ImagePickerService({required ImagePicker imagePicker}) : _imagePicker = imagePicker;

  final ImagePicker _imagePicker;

  Future<File?> pickImage({required ImageSource source}) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(source: source);

      if (pickedImage == null) return null;

      return File(pickedImage.path);
    } catch (error) {
      rethrow;
    }
  }
}
