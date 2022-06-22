import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';

class DialogConfirmation extends StatelessWidget {
  const DialogConfirmation({
    Key? key,
    required String title,
    required String message,
    required String positiveButtonText,
    required String negativeButtonText,
    required Function() positiveButtonAction,
    required Function() negativeButtonAction,
  })  : _title = title,
        _message = message,
        _positiveButtonText = positiveButtonText,
        _negativeButtonText = negativeButtonText,
        _positiveButtonAction = positiveButtonAction,
        _negativeButtonAction = negativeButtonAction,
        super(key: key);

  final String _title;
  final String _message;
  final String _positiveButtonText;
  final String _negativeButtonText;
  final Function() _positiveButtonAction;
  final Function() _negativeButtonAction;

  @override
  Widget build(BuildContext context) {
    return BaseDialogCard(
      children: [
        const Gap(
          height: AppGap.normal,
        ),
        BaseDialogTitle(
          _title,
        ),
        BaseDialogMessage(
          _message,
        ),
        const Gap(
          height: AppGap.large,
        ),
        ButtonPrimary(
          _positiveButtonText,
          width: double.infinity,
          buttonColor: AppColors.red,
          onPressed: _positiveButtonAction,
        ),
        const Gap(),
        ButtonPrimary(
          _negativeButtonText,
          width: double.infinity,
          buttonColor: ButtonColors.tertiary,
          labelColor: ButtonColors.primary,
          onPressed: _negativeButtonAction,
        ),
      ],
    );
  }
}
