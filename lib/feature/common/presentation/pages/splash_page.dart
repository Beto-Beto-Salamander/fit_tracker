import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/di_container.dart';
import 'package:fit_tracker/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final user = sl<UserCubit>().state.user;
    Future.delayed(const Duration(seconds: 3), () {
      if (user != null) {
        Navigator.of(context).pushReplacementNamed(
          PagePath.home,
          arguments: FirebaseAuth.instance.currentUser?.email ?? "",
        );
      } else {
        Navigator.of(context).pushReplacementNamed(PagePath.signIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveUtils(context);
    return Scaffold(
      body: Center(
        child: Text(
          'TRACK FIT',
          style: AppTextStyle.bold.copyWith(
              fontSize: responsive.getResponsiveSize(
                AppFontSize.big,
              ),
              color: TextColors.tertiary),
        ),
      ),
    );
  }
}
