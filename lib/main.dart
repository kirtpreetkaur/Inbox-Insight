import 'package:flutter/material.dart';
import 'mobile/screens/inbox_screen.dart';
import 'mobile/screens/summary_screen.dart';
import 'mobile/utils/mock_sms_data.dart';

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
          titleTextStyle: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.deepPurple),
      ),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _selectedIndex = 0;

  late final List<Message> _messages;
  late final Map<String, int> _categoryCounts;

  @override
  void initState() {
    super.initState();
    _messages = MockSmsData.loadAll();
    _categoryCounts = MockSmsData.categoryCounts(_messages);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const InboxScreen(),
      SummaryScreen(messages: _messages, categoryCounts: _categoryCounts),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.inbox), label: 'Inbox'),
          BottomNavigationBarItem(icon: Icon(Icons.summarize), label: 'Summary'),
        ],
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}
