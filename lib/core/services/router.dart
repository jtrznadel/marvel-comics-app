import 'package:flutter/material.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/details/details_screen.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/navigation_shell.dart';
import 'package:marvel_comics_app/features/splash/presentation/views/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case NavigationShell.routeName:
      return MaterialPageRoute(builder: (_) => const NavigationShell());
    case DetailsScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => DetailsScreen(comics: settings.arguments as Comics),
          settings: settings);
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Not found')),
              ));
  }
}
