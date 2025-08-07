extension StringValidationExtension on String {
  bool get isImage => isJpg || isJpeg || isPng;

  bool get isNotImage => !isImage;

  bool get isJpg => endsWith('.jpg');

  bool get isJpeg => endsWith('.jpeg');

  bool get isPng => endsWith('.png');
}
