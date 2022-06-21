import 'package:fit_tracker/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const SignUpPageWrapper(),
    );
  }
}

class SignUpPageWrapper extends StatefulWidget {
  const SignUpPageWrapper({Key? key}) : super(key: key);

  @override
  State<SignUpPageWrapper> createState() => _SignUpPageWrapperState();
}

class _SignUpPageWrapperState extends State<SignUpPageWrapper> {
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

  void _handleSignUp() {
    context.read<SignUpCubit>().signUp(
          AuthParams(
            email: _textFieldlist[0].textController.text,
            password: _textFieldlist[1].textController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: BlocListener<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              BasePopup(context).dialog(
                child: const DialogLoading(),
              );
            } else {
              Navigator.popUntil(
                context,
                ModalRoute.withName(PagePath.signUp),
              );
            }
            if (state is SignUpLoaded) {
              BasePopup(context).dialog(
                child: DialogSuccess(
                  message:
                      "You're all set! Please use your credentials to log in.",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PagePath.signIn,
                      (route) => false,
                    );
                  },
                ),
              );
            } else if (state is SignUpError) {
              BasePopup(context).dialog(
                child: DialogError(
                  message: state.message,
                ),
              );
            }
          },
          child: SingleChildScrollView(
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
                      onPressed: _handleSignUp,
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
      ),
    );
  }
}
