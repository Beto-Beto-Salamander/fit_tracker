import 'package:fit_tracker/feature/feature.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Form
  final List<TextFieldEntity> _textFieldlist = TextFieldEntity.authSignUp;
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    for (final i in _textFieldlist) {
      i.textController = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final i in _textFieldlist) {
      i.textController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BaseAuthCard(
                title: 'Sign Up',
                subtitle: "Let's start our journey!",
                formKey: _formKey,
                children: [
                  const Gap(
                    height: AppGap.medium,
                  ),
                  //Email
                  CustomTextFormField(textFieldEntity: _textFieldlist[0]),
                  const Gap(
                    height: AppGap.medium,
                  ),
                  //Password
                  CustomTextFormField(textFieldEntity: _textFieldlist[1]),
                  const Gap(
                    height: AppGap.big,
                  ),
                  ButtonPrimary(
                    "Sign Up",
                    width: double.infinity,
                    onPressed: () {},
                  ),
                  const Gap(),
                  Center(
                    child: LongHyperlink(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      label: "Already have an account ?",
                      link: "Sign In",
                    ),
                  ),
                ],
              ),
              const FloatingLottie(AppLottie.signUp),
            ],
          ),
        ),
      ),
    );
  }
}
