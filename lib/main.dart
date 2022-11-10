import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ft_companion/utils/utils.dart';
import 'package:ft_companion/pages/pages.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  apiController.instance.initValues(
      dotenv.env['UID']!, dotenv.env['SECRET']!, dotenv.env['URL42']!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        textTheme: GoogleFonts.slabo27pxTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      // theme: ThemeData.dark(),
      home: const SearchPage(),
    );
  }
}
