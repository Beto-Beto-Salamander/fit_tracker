import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FloatingLottie extends StatelessWidget {
  const FloatingLottie(
    String path, {
    Key? key,
  })  : _path = path,
        super(key: key);

  final String _path;

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Lottie.asset(
        _path,
        height: responsive.getResponsiveSize(256),
      ),
    );
  }
}