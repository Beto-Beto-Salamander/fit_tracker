import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:fit_tracker/di_container.dart' as di;
import 'package:fit_tracker/feature/feature.dart';
import 'package:fit_tracker/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: Platform.isAndroid
          ? DefaultFirebaseOptions.android
          : DefaultFirebaseOptions.ios);
  await di.init();

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final route = PageRouter().getRoute;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.sl<UserCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme().of(context),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: route,
      ),
    );
  }
}
