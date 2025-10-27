import 'package:flutter/material.dart';
import 'package:inboxinsight/mobile/mobile_main.dart';

void main() {
  runApp(InboxInsightApp());
}

class InboxInsightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InboxInsight',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      home: MobileMain(),
      debugShowCheckedModeBanner: false,
    );
  }
}
