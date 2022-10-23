import 'package:flutter/material.dart';
import 'package:riverpod_demo/domain/model/Article.dart';
import 'package:riverpod_demo/presentation/features/home/homeScreen.dart';
import 'package:riverpod_demo/presentation/features/home/newsDetailsScreen.dart';

class AppRouter {
  static const String initialScreen = "/", home = "/homeScreen", newsDetailsScreen = "/newsDetailsScreen";

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case initialScreen:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case newsDetailsScreen:
        var args = routeSettings.arguments as Article;
        return MaterialPageRoute(
          builder: (BuildContext context) => NewsDetailsScreen(
            article: args,
          ),
        );
      default:
        return null;
    }
  }
}
