import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class DialogSuccess extends StatelessWidget {
  const DialogSuccess({
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
          Icons.check_circle_rounded,
          color: StateColors.success,
        ),
        const Gap(
          height: AppGap.normal,
        ),
        const BaseDialogTitle(
          "Good to go!",
        ),
        BaseDialogMessage(
          _message,
        ),
        const Gap(
          height: AppGap.large,
        ),
        SizedBox(
          width: double.infinity,
          child: ButtonPrimary(
            "Got It!",
            buttonColor: StateColors.success,
            onPressed: () {
              _onTap?.call();
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
