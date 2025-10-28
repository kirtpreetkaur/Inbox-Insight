// lib/main.dart
import 'package:flutter/material.dart';
import 'mobile/screens/inbox_screen.dart';

void main() {
  runApp(const InboxInsightApp());
}

class InboxInsightApp extends StatelessWidget {
  const InboxInsightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InboxInsight',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F7F9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.deepPurple,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.deepPurple),
          titleTextStyle: TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.deepPurple),
      ),
      home: InboxScreen(),
    );
  }
}
