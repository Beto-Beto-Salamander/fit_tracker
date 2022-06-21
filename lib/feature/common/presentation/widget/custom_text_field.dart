import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/entities/entities.dart';
import '../../utils/utils.dart';
import 'widget.dart';

/// Custom Widget for Text Form Field
/// This text field has validator to check the user input
/// An error will be shown below the text field if the input doesn't meet the validator
///
/// This text field border will change dynamically according to user interaction & input
///
/// This text field can be used for typing password and has a trigger for visibility
/// An icon will be shown if the type of input is password
/// The icon will be the visibility trigger
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    required TextFieldEntity textFieldEntity,
    int maxLines = 1,
    Color backgroundDisable = TextFieldColors.disable,
    String? Function(String?)? validator,
    List<TextInputFormatter>? formatter,
  })  : _textFieldEntity = textFieldEntity,
        _maxLines = maxLines,
        _backgroundDisable = backgroundDisable,
        _validator = validator,
        _formatter = formatter,
        super(key: key);

  final TextFieldEntity _textFieldEntity;
  final int _maxLines;
  final Color _backgroundDisable;
  final String? Function(String?)? _validator;
  final List<TextInputFormatter>? _formatter;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  String? _error;
  bool _isObscureText = false;

  @override
  void initState() {
    _isObscureText = widget._textFieldEntity.isPassword;

    widget._textFieldEntity.focusNode?.addListener(() {
      if (widget._textFieldEntity.focusNode?.hasFocus ?? false) {
      } else {
        widget._textFieldEntity.focusNode?.unfocus();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget._textFieldEntity.label,
          style: AppTextStyle.semiBold.copyWith(),
        ),
        const Gap(),
        TextFormField(
          autofocus: widget._textFieldEntity.isAutofocus ?? false,
          enabled: widget._textFieldEntity.isEnabled,
          controller: widget._textFieldEntity.textController,
          focusNode: widget._textFieldEntity.focusNode,
          inputFormatters: widget._formatter,
          maxLines: widget._maxLines,
          style: AppTextStyle.regular.copyWith(
            fontSize: responsive.getResponsiveSize(
              AppFontSize.normal,
            ),
            color: TextFieldColors.text,
          ),
          decoration: InputDecoration(
            hintText: widget._textFieldEntity.hint,
            fillColor: widget._textFieldEntity.isEnabled
                ? TextFieldColors.enable
                : widget._backgroundDisable,
            errorText: _error?.toUpperCase(),
            helperText: _error?.toUpperCase(),
            helperStyle: AppTextStyle.regular.copyWith(
              fontSize: AppFontSize.small,
              color: StateColors.error,
            ),
            suffixIcon: Visibility(
              visible: widget._textFieldEntity.isPassword,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscureText = !_isObscureText;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: responsive.getResponsiveSize(
                      AppGap.normal,
                    ),
                  ),
                  child: Icon(
                    _isObscureText
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                    color:
                        (widget._textFieldEntity.focusNode?.hasFocus ?? false)
                            ? TextFieldColors.activeIcon
                            : TextFieldColors.inactiveIcon,
                  ),
                ),
              ),
            ),
          ),
          textInputAction: widget._textFieldEntity.textInputAction,
          obscureText: _isObscureText,
          keyboardType: widget._textFieldEntity.keyboardType,
          validator: (value) {
            // Note : https://pub.dev/packages/form_validator (documentations)
            _error = _error = widget._validator?.call(value) ??
                widget._textFieldEntity.validator?.call(value);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {});
            });

            return _error;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }
}
