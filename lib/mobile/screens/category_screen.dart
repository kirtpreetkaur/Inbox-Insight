import 'package:flutter/material.dart';
import '../ai/ai_classifier.dart';
import '../widgets/glass_card.dart';
import 'message_detail.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';




class CategoryScreen extends StatelessWidget {
  final String categoryName;
  final List<Message> messages;
  CategoryScreen({required this.categoryName, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(categoryName)),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: messages.length,
        itemBuilder: (c,i){
          var m = messages[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical:6.0),
            child: GlassCard(child: ListTile(
              leading: Icon(m.icon, color: Colors.blueAccent),
              title: Text(m.sender),
              subtitle: Text(m.text),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => MessageDetail(message: m, category: categoryName)));
              },
            )),
          );
        },
      ),
    );
  }
}
