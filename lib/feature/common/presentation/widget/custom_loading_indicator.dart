import 'dart:io';

import 'package:fit_tracker/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        AppGap.normal,
      ),
      child: Center(
        child: Platform.isIOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      ),
    );
  }
}

class ScreenSizeLoadingIndicator extends StatelessWidget {
  const ScreenSizeLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Container(
      height: responsive.getMediaQueryHeight() - kToolbarHeight * 2,
      alignment: Alignment.center,
      child: const LoadingIndicator(),
    );
  }
}
