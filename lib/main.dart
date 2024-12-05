import 'package:box_note/data/providers/note_provider.dart';
import 'package:box_note/pages/home/note_page.dart';
import 'package:box_note/pages/home/home_page.dart';
import 'package:box_note/styles/themes/dark.dart';
import 'package:box_note/styles/themes/light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NoteProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/home': (context) => const HomePage(),
          '/note-page': (context) => const NotePage()
        },
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
