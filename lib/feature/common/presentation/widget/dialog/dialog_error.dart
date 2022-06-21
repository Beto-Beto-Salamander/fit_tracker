import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class DialogError extends StatelessWidget {
  const DialogError({
    Key? key,
    required String message,
    VoidCallback? onTap,
  })  : _message = message,
        _onTap = onTap,
        super(key: key);

  final String _message;
  final VoidCallback? _onTap;

  @override
  Widget build(BuildContext context) {
    return BaseDialogCard(
      children: [
        const BaseDialogIcon(
          Icons.error_rounded,
          color: StateColors.error,
        ),
        const Gap(
          height: AppGap.normal,
        ),
        const BaseDialogTitle(
          "Oh Snap!",
        ),
        BaseDialogMessage(
          _message,
        ),
        const Gap(
          height: AppGap.large,
        ),
        ButtonPrimary(
          "Close",
          buttonColor: StateColors.error,
          width: double.infinity,
          onPressed: () {
            _onTap?.call();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
