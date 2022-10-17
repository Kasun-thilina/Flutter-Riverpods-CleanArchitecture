import 'package:flutter/material.dart';
import 'package:riverpod_demo/presentation/features/home/HomeScreen.dart';

class AppRouter {
  static const String initialScreen = "/", home = "/HomeScreen";

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case initialScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
