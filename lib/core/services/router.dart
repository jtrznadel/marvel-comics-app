import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_comics_app/core/services/injection_container.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/comics_screen.dart';
import 'package:marvel_comics_app/features/splash/presentation/views/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case ComicsScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => BlocProvider(
                create: (_) => sl<ComicsCubit>(),
                child: const ComicsScreen(),
              ));
    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Not found')),
              ));
  }
}
