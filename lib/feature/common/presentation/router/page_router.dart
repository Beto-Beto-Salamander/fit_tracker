import 'dart:io';

import 'package:fit_tracker/feature/feature.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageRouter {
  Route<dynamic>? getRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      /* Splash */
      //------------------------------------------------------

      case PagePath.splash:
        {
          return _buildRouter(
              settings: settings, builder: (args) => const SplashPage());
        }

      //------------------------------------------------------

      /* Sign in */
      //------------------------------------------------------

      case PagePath.signIn:
        {
          return _buildRouter(
              settings: settings, builder: (args) => const SignInPage());
        }

      //------------------------------------------------------

      /* Sign Up */
      //------------------------------------------------------

      case PagePath.signUp:
        {
          return _buildRouter(
              settings: settings, builder: (args) => const SignUpPage());
        }

      //------------------------------------------------------

      /* Home */
      //------------------------------------------------------

      case PagePath.home:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) =>  const HomePage(),
          );
        }

      //------------------------------------------------------

      /* Profile */
      //------------------------------------------------------

      case PagePath.profile:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const ProfilePage()
          );
        }

      //------------------------------------------------------

      /* Weight Display */
      //------------------------------------------------------

      case PagePath.weightDisplay:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const WeightDisplayPage()
          );
        }

      //------------------------------------------------------

      default:
        return null;
    }
  }

  Route<dynamic> _buildRouter({
    required RouteSettings settings,
    required Widget Function(Object? arguments) builder,
  }) {
    if (Platform.isIOS) {
      return CupertinoPageRoute(
        settings: settings,
        builder: (_) => builder(settings.arguments),
      );
    } else {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => builder(settings.arguments),
      );
    }
  }
}
