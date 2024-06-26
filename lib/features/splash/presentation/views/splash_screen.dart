import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marvel_comics_app/core/res/app_colors.dart';
import 'package:marvel_comics_app/core/res/media_res.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/navigation_shell.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, NavigationShell.routeName);
    });
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.splashGradientColorA,
              AppColors.splashGradientColorB,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              MediaRes.splashShieldImage,
              width: size.width * .8,
            ),
            const SizedBox(
              height: 50,
            ),
            Image.asset(
              MediaRes.splashMarvelLogoImage,
            )
          ],
        ),
      ),
    );
  }
}
