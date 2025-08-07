import 'package:flutter/material.dart';

extension WidgetGapExtension on num {
  SizedBox get gapWidth => SizedBox(width: toDouble());

  SizedBox get gapHeight => SizedBox(height: toDouble());
}
