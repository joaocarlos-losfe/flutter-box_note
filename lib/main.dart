import 'package:box_note/pages/home/add_note_page.dart';
import 'package:box_note/pages/home/home_page.dart';
import 'package:box_note/styles/themes/dark.dart';
import 'package:box_note/styles/themes/light.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/add-note': (context) => const AddNotePage()
      },
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
