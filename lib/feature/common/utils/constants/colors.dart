import 'package:flutter/material.dart';

class AppColors {
  static const black = Colors.black;
  static const white = Colors.white;
  static const red = Colors.red;
  static const green = Colors.green;
  static const oxfordBlue = Color(0xFF032A49);
  static const veryLightBlue = Color(0xFF616E9A);
  static const manatee = Color(0xFF9697B6);
  static const lightPeriwinkle = Color(0xFFC4C5DA);
  static const lemonCurry = Color(0xFFCB9821);
}

class WrapperColors {
  static const background = AppColors.oxfordBlue;
  static const white = AppColors.white;
  static const card = AppColors.oxfordBlue;
}

class AppBarColors {
  static const background = AppColors.oxfordBlue;
}

class TextColors {
  static const primary = AppColors.oxfordBlue;
  static const secondary = AppColors.veryLightBlue;
  static const tertiary = AppColors.white;
  static const quarternary = AppColors.lemonCurry;
}

class ButtonColors {
  static const primary = AppColors.oxfordBlue;
  static const secondary = AppColors.lemonCurry;
  static const tertiary = AppColors.white;
}

class ButtonTextColors {
  static const primary = AppColors.white;
  static const secondary = AppColors.oxfordBlue;
}

class TextFieldColors {
  static const enable = AppColors.white;
  static const disable = AppColors.lightPeriwinkle;
  static const error = AppColors.red;
  static const hint = AppColors.veryLightBlue;
  static const text = AppColors.oxfordBlue;
  static const cursor = AppColors.oxfordBlue;
  static const activeIcon = AppColors.oxfordBlue;
  static const inactiveIcon = AppColors.veryLightBlue;
  final highlight = AppColors.veryLightBlue.withOpacity(0.2);
}

class TextFieldStateColors {
  static const enable = AppColors.oxfordBlue;
  static const focused = AppColors.lemonCurry;
  static const disable = AppColors.oxfordBlue;
  static const error = AppColors.red;
}

class StateColors {
  static const success = AppColors.green;
  static const selected = AppColors.green;
  static const error = AppColors.red;
  static const warning = AppColors.lemonCurry;
}
