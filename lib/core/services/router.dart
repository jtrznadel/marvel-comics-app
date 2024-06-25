import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_comics_app/core/services/injection_container.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/home_screen.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/navigation_shell.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/search_screen.dart';
import 'package:marvel_comics_app/features/splash/presentation/views/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case NavigationShell.routeName:
      return MaterialPageRoute(builder: (_) => const NavigationShell());
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Not found')),
              ));
  }
}
