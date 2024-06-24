import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('SplashScreen'),
    );
  }
}
