import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import '../utils/mock_sms_data.dart';
import 'dashboard.dart';
import '../ai/ai_classifier.dart';

class AIProcessingScreen extends StatefulWidget {
  final List<Message> messages;
  AIProcessingScreen({required this.messages});
  @override
  _AIProcessingScreenState createState() => _AIProcessingScreenState();
}

class _AIProcessingScreenState extends State<AIProcessingScreen> {
  List<String> steps = [
    'Analyzing messages...',
    'Extracting highlights...',
    'Categorizing offers...',
    'Creating Smart Digest...'
  ];
  int idx = 0;

  @override
  void initState() {
    super.initState();
    _startProcessing();
  }

  void _startProcessing() async {
    for (int i=0;i<steps.length;i++) {
      setState((){ idx = i; });
      await Future.delayed(Duration(milliseconds:800));
    }
    // run AI classifier simulation
    var result = AiClassifier.process(widget.messages);
    // small delay then navigate
    await Future.delayed(Duration(milliseconds:700));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen(result: result)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFe3f2fd), Color(0xFFf3e5f5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(height:20),
              Container(width:160, height:160, child: Lottie.asset('assets/animations/ai_brain.json')),
              SizedBox(height:20),
              Text(steps[idx], style: TextStyle(fontSize:18, fontWeight: FontWeight.w600)),
              SizedBox(height:12),
              CircularProgressIndicator(),
            ]),
          ),
        ),
      ),
    );
  }
}
