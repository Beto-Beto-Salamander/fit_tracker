import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AppFontWeight {
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

// ignore: avoid_classes_with_only_static_members
class AppTextStyle {
  /// FontWeight.w300
  static final TextStyle light = GoogleFonts.poppins(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.light,
    color: TextColors.primary,
  );

  /// FontWeight.w400
  static final TextStyle regular = GoogleFonts.poppins(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.regular,
    color: TextColors.primary,
  );

  /// FontWeight.w500
  static final TextStyle medium = GoogleFonts.poppins(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.medium,
    color: TextColors.primary,
  );

  /// FontWeight.w600
  static final TextStyle semiBold = GoogleFonts.poppins(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.semiBold,
    color: TextColors.primary,
  );

  /// FontWeight.w700
  static final TextStyle bold = GoogleFonts.poppins(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.bold,
    color: TextColors.primary,
  );

  /// FontWeight.w800
  static final TextStyle extraBold = GoogleFonts.poppins(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.extraBold,
    color: TextColors.primary,
  );

  /// FontWeight.w900
  static final TextStyle black = GoogleFonts.poppins(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.black,
    color: TextColors.primary,
  );
}
