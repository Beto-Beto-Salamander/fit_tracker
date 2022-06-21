import 'package:flutter/cupertino.dart';
import 'package:form_validator/form_validator.dart';

enum TextFieldStatus {
  initial,
  failed,
  success,
}

class TextFieldEntity {
  TextEditingController textController;
  String hint;
  String label;
  bool isEnabled;
  bool isPassword;
  TextInputType keyboardType;
  bool? isAutofocus;
  TextInputAction? textInputAction;
  FocusNode? focusNode;
  String? Function(String?)? validator;

  TextFieldEntity({
    required this.textController,
    required this.hint,
    this.label = "",
    this.isPassword = false,
    this.isEnabled = true,
    this.isAutofocus = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.validator,
  });

  static final List<TextFieldEntity> authSignIn = [
    TextFieldEntity(
      textController: TextEditingController(text: ''),
      hint: "Email",
      label: "Email",
      keyboardType: TextInputType.emailAddress,
      focusNode: FocusNode(),
      validator: (value) {
        return ValidationBuilder().email().build().call(value);
      },
    ),
    TextFieldEntity(
      textController: TextEditingController(text: ''),
      hint: "Password",
      label: "Password",
      isPassword: true,
      textInputAction: TextInputAction.done,
      focusNode: FocusNode(),
      validator: (value) {
        return ValidationBuilder().minLength(8).build().call(value);
      },
    ),
  ];

  static final List<TextFieldEntity> authSignUp = [
    TextFieldEntity(
      textController: TextEditingController(text: ''),
      hint: "Email",
      label: "Email",
      keyboardType: TextInputType.emailAddress,
      focusNode: FocusNode(),
      validator: (value) {
        return ValidationBuilder().email().build().call(value);
      },
    ),
    TextFieldEntity(
      textController: TextEditingController(text: ''),
      hint: "Password",
      label: "Password",
      isPassword: true,
      textInputAction: TextInputAction.done,
      focusNode: FocusNode(),
      validator: (value) {
        return ValidationBuilder().minLength(8).build().call(value);
      },
    ),
  ];
}
