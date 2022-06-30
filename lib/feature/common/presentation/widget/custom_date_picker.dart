import 'dart:io';

import 'package:fit_tracker/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as context;

extension CustomDatePicker on context.BuildContext {
  Future<void> selectDate({
    required DateTime initialDate,
    required Function(DateTime?) onPicked,
  }) async {
    final responsive = ResponsiveUtils(this);

    if (Platform.isAndroid) {
      final DateTime? picked = await showDatePicker(
        helpText: "Choose your birth date".toUpperCase(),
        context: this,
        // locale: const Locale("id", "ID"),
        initialDate: initialDate,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor: 1,
            ),
            child: Theme(
              data: ThemeData(
                colorScheme: const ColorScheme.dark(
                  primary: AppColors.lemonCurry, // circle
                  onPrimary: Colors.white, // selected date
                  surface: AppColors.white, // header bg
                  onSurface: AppColors.oxfordBlue, // header & unselected date
                ),
                dialogBackgroundColor: AppColors.white,
                textTheme: const TextTheme(
                  bodyText1: TextStyle(fontSize: 10.0),
                  bodyText2: TextStyle(fontSize: 8.0),
                ),
              ),
              child: child!,
            ),
          );
        },
      );

      if (picked != null) {
        onPicked(picked);
      }
    } else {
      DateTime? picked;
      showCupertinoModalPopup<dynamic>(
        context: this,
        builder: (_) => ColoredBox(
          color: AppColors.white,
          child: SafeArea(
            top: false,
            child: Container(
              height: responsive.getResponsiveSize(256),
              color: AppColors.white,
              padding: EdgeInsets.symmetric(
                horizontal: responsive.getResponsiveSize(
                  AppGap.medium,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(
                    height: AppGap.medium,
                  ),
                  Text(
                    "Select date".toUpperCase(),
                    style: AppTextStyle.bold.copyWith(
                      fontSize: responsive.getResponsiveSize(
                        AppFontSize.medium,
                      ),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const Gap(),
                  SizedBox(
                    height: responsive.getResponsiveSize(128),
                    child: CupertinoDatePicker(
                      initialDateTime: initialDate,
                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (val) {
                        picked = val;
                      },
                      // minimumDate: first,
                      maximumDate: DateTime.now(),
                      maximumYear: DateTime.now().year,
                      minimumYear: 1950,
                    ),
                  ),
                  const Gap(
                    height: AppGap.medium,
                  ),
                  ButtonPrimary(
                    "Done",
                    width: responsive.getMediaQueryWidth(),
                    onPressed: () {
                      picked ??= DateTime.now();

                      Navigator.pop(this);
                      onPicked(picked);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
