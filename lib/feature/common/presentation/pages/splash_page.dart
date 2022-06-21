import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_tracker/feature/feature.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      // if(FirebaseAuth.instance.currentUser != null){
      //   Navigator.of(context).pushReplacementNamed(PagePath.signUp);
      // }else{
      //   Navigator.of(context).pushReplacementNamed(PagePath.signIn);
      // }
      Navigator.of(context).pushReplacementNamed(PagePath.signIn);
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
