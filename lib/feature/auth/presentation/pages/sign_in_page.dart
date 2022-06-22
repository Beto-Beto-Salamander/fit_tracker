import 'package:fit_tracker/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(),
      child: const SignInPageWrapper(),
    );
  }
}

class SignInPageWrapper extends StatefulWidget {
  const SignInPageWrapper({Key? key}) : super(key: key);

  @override
  State<SignInPageWrapper> createState() => _SignInPageWrapperState();
}

class _SignInPageWrapperState extends State<SignInPageWrapper> {
  //Form
  final List<TextFieldEntity> _textFieldlist = TextFieldEntity.authSignIn;
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // for (final i in _textFieldlist) {
    //   i.textController = TextEditingController(text: "");
    // }
    // setState(() {});
  }

  // @override
  // void dispose() {
  //   for (final i in _textFieldlist) {
  //     i.textController.clear();
  //   }
  //   super.dispose();
  // }

  void _handleSignIn() {
    context.read<SignInCubit>().signIn(
          AuthParams(
            email: _textFieldlist[0].textController.text,
            password: _textFieldlist[1].textController.text,
          ),
        );
    // Navigator.pushReplacementNamed(
    //   context,
    //   PagePath.home,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: BlocListener<SignInCubit, SignInState>(
          listener: (context, state) {
            // if (state is SignInLoading) {
            //   BasePopup(context).dialog(
            //     child: const DialogLoading(),
            //   );
            // } else {
            //   Navigator.popUntil(
            //     context,
            //     ModalRoute.withName(PagePath.signIn),
            //   );
            // }
            if (state is SignInLoaded) {
              BasePopup(context).dialog(
                child: DialogSuccess(
                  message:
                      "You're all set! Please use your credentials to log in.",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PagePath.home,
                      (route) => false,
                    );
                  },
                ),
              );
            } else if (state is SignInError) {
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
                  title: 'Sign In',
                  subtitle: "Welcome back!",
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
                      "Sign In",
                      width: double.infinity,
                      onPressed: _handleSignIn,
                    ),
                    const Gap(),
                    Center(
                      child: LongHyperlink(
                        onTap: () {
                          Navigator.pushNamed(context, PagePath.signUp);
                        },
                        label: "New to Fit Tracker ?",
                        link: "Sign Up",
                      ),
                    ),
                  ],
                ),
                const FloatingLottie(AppLottie.signIn),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
