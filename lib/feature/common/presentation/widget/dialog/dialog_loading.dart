import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class DialogLoading extends StatelessWidget {
  const DialogLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return BaseDialogCard(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              MessageConstant.loading,
              textAlign: TextAlign.center,
              style: AppTextStyle.bold.copyWith(
                fontSize: responsive.getResponsiveSize(
                  AppFontSize.large,
                ),
              ),
            ),
            const Gap(
              height: AppGap.normal * 2,
            ),
            const LoadingIndicator(),
          ],
        ),
      ],
    );
  }
}
