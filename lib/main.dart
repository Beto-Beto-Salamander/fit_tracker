import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fit_tracker/feature/feature.dart';
import 'package:fit_tracker/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: Platform.isAndroid
          ? DefaultFirebaseOptions.android
          : DefaultFirebaseOptions.ios);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final route = PageRouter().getRoute;
    return MaterialApp(
      theme: AppTheme().of(context),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: route,
    );
  }
}
