import 'package:flutter/material.dart';

class BasePopup {
  final BuildContext context;

  BasePopup(
    this.context,
  );

  void dialog({required Widget child}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return child;
      },
    );
  }
}
