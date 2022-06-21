import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      scaffoldBackgroundColor: WrapperColors.background,
      appBarTheme: theme.appBarTheme.copyWith(color: AppBarColors.background),
      textSelectionTheme: theme.textSelectionTheme.copyWith(
        cursorColor: TextFieldColors.cursor,
        selectionColor: TextFieldColors().highlight,
        selectionHandleColor: TextFieldColors.cursor,
      ),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        filled: true,
        fillColor: TextFieldColors.enable,
        isDense: true,
        hintStyle: AppTextStyle.regular.copyWith(
          fontSize: AppFontSize.small,
          color: TextFieldColors.hint,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppGap.normal,
          horizontal: AppGap.normal,
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.small),
          ),
          borderSide: BorderSide(
            color: TextFieldStateColors.disable,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.small),
          ),
          borderSide: BorderSide(
            color: TextFieldStateColors.enable,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.small),
          ),
          borderSide: BorderSide(
            color: TextFieldStateColors.focused,
            width: 2,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.small),
          ),
          borderSide: BorderSide(
            color: TextFieldStateColors.error,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.small),
          ),
          borderSide: BorderSide(
            color: TextFieldStateColors.error,
          ),
        ),
      ),
    );
  }
}
