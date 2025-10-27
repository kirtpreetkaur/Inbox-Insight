import 'dart:convert';
import 'package:flutter/material.dart';
import '../ai/ai_classifier.dart';
import 'ai_processing.dart';
import '../utils/mock_sms_data.dart';
import '../widgets/glass_card.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';




class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    messages = MockSmsData.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inbox (Simulated) - InboxInsight'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: messages.length,
                  itemBuilder: (c, i) {
                    var m = messages[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: GlassCard(
                        child: ListTile(
                          leading: Icon(m.icon, color: Colors.blueAccent),
                          title: Text(m.sender, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(m.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.auto_awesome),
                  label: Text('Generate Smart Digest'),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical:14, horizontal:20)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AIProcessingScreen(messages: messages)));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
