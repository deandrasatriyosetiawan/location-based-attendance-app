import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

final class ClickableTextData {
  const ClickableTextData({required this.text, this.onTap});

  final VoidCallback? onTap;
  final String text;
}

final class ClickableRichText extends StatelessWidget {
  const ClickableRichText({
    required this.plainText,
    required this.clickableTextData,
    required this.plainTextStyle,
    required this.clickableTextStyle,
    this.textAlign = TextAlign.start,
    super.key,
  });

  final String plainText;
  final List<ClickableTextData> clickableTextData;
  final TextStyle plainTextStyle, clickableTextStyle;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: plainText,
        style: plainTextStyle,
        children: clickableTextData.map((ClickableTextData data) {
          return TextSpan(
            text: data.text,
            style: data.onTap == null ? plainTextStyle : clickableTextStyle,
            recognizer: TapGestureRecognizer()..onTap = data.onTap,
          );
        }).toList(),
      ),
      textAlign: textAlign,
    );
  }
}
