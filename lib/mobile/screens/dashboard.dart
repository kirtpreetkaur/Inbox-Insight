import 'package:flutter/material.dart';
import '../ai/ai_classifier.dart';
import 'category_screen.dart';
import '../widgets/glass_card.dart';

class DashboardScreen extends StatelessWidget {
  final AIResult result;
  DashboardScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Smart Digest - InboxInsight'), backgroundColor: Colors.transparent, elevation: 0),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFe3f2fd), Color(0xFFf3e5f5)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              Text("Today's Summary", style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
              SizedBox(height:12),
              Expanded(
                child: ListView(
                  children: result.summary.keys.map((k) {
                    var info = result.summary[k];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical:8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryScreen(categoryName: k, messages: result.categories[k]!)));
                        },
                        child: GlassCard(child: ListTile(
                          leading: Icon(info['icon'], color: Colors.blueAccent),
                          title: Text(k, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(info['summary']),
                          trailing: Text('${info['count']}'),
                        )),
                      ),
                    );
                  }).toList(),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
