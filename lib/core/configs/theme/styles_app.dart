import 'dart:ui';

import 'package:flutter/material.dart';

class StylesApp {
  static const Color defaultColor = Color(0xFF24A19C);

  /// Structure Styles
  static const defaultPaddingHorizontal = EdgeInsets.symmetric(horizontal: 16);

  /// Primary Colors
  static const Color disabled = Color(0xFFCBF1F0);
  static const Color disableButton = Colors.grey;

  /// Background Colors
  static const Color greyBackground = Color(0xFFE0E5ED);
  static Color greySelectedBackground = Colors.grey.shade100;

  /// Colors Text
  static const Color greyText = Color(0xFF767E8C);
  static const Color colorDefaultText = Color(0xFF1B1C1F);

  /// FontWeight Buttons
  static const FontWeight textButtonFontWeight = FontWeight.w500;

  /// Text Buttons
  static TextStyle textButtonDefault(BuildContext context) {
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontWeight: Theme.of(context).textTheme.labelLarge!.fontWeight,
    );
  }

  // Input Border
  static const Color colorInputBorder = Color(0xFFE0E5ED);

  static TextStyle textButtonBold(BuildContext context) {
    return Theme.of(
      context,
    ).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold);
  }

  /// Colors Icons
  static const Color greyIcon = Color(0xFF767E8C);
}
