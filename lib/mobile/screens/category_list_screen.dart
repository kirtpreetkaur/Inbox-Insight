import 'package:flutter/material.dart';
import '../utils/mock_sms_data.dart';
import 'message_detail_screen.dart';

class CategoryListScreen extends StatelessWidget {
  final String category;
  final List<Message> messages;

  const CategoryListScreen({
    Key? key,
    required this.category,
    required this.messages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter messages for this category
    final categoryMessages = MockSmsData.messages
        .where((msg) => msg.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurple,
        title: Text(
          category,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categoryMessages.length,
        itemBuilder: (context, index) {
          final msg = categoryMessages[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Icon(msg.icon, color: Colors.deepPurple),
              title: Text(
                msg.sender,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                msg.text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SmartMessageScreen(message: msg),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
