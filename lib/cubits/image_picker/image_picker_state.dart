part of 'image_picker_cubit.dart';

final class ImagePickerState extends Equatable {
  ImagePickerState({this.image, this.isLoading = false, this.localPath, this.errorMessage})
    : timestamp = DateTime.now();

  final File? image;
  final String? errorMessage, localPath;
  final bool isLoading;
  final DateTime timestamp;

  bool get isFailure => errorMessage != null;

  bool get isSuccess => image != null;

  ImagePickerState copyWith({File? image, bool? isLoading, String? errorMessage}) {
    return ImagePickerState(
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[image, errorMessage, isLoading, timestamp];
}
