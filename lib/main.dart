import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_comics_app/core/services/router.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/comics_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Marvel Comics',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: generateRoute,
    );
  }
}
