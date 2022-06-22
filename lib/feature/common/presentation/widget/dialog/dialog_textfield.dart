import 'package:fit_tracker/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogTextField extends StatelessWidget {
  const DialogTextField({
    Key? key,
    required String title,
    required String message,
    required String positiveButtonText,
    required String negativeButtonText,
    required Function() positiveButtonAction,
    required Function() negativeButtonAction,
    required TextFieldEntity textFieldEntity,
  })  : _title = title,
        _message = message,
        _positiveButtonText = positiveButtonText,
        _negativeButtonText = negativeButtonText,
        _positiveButtonAction = positiveButtonAction,
        _negativeButtonAction = negativeButtonAction,
        _textFieldEntity = textFieldEntity,
        super(key: key);

  final String _title;
  final String _message;
  final String _positiveButtonText;
  final String _negativeButtonText;
  final Function() _positiveButtonAction;
  final Function() _negativeButtonAction;
  final TextFieldEntity _textFieldEntity;

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
        CustomTextFormField(
          textFieldEntity: _textFieldEntity,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
        ),
        const Gap(
          height: AppGap.large,
        ),
        ButtonPrimary(
          _positiveButtonText,
          width: double.infinity,
          buttonColor: ButtonColors.primary,
          onPressed: _positiveButtonAction,
        ),
        const Gap(),
        ButtonPrimary(
          _negativeButtonText,
          width: double.infinity,
          buttonColor: ButtonColors.tertiary,
          labelColor: AppColors.red,
          onPressed: _negativeButtonAction,
        ),
      ],
    );
  }
}
