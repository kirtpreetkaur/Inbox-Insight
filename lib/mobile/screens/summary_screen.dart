import 'package:flutter/material.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';
import 'package:inboxinsight/mobile/screens/category_list_screen.dart';

class SummaryScreen extends StatelessWidget {
  final List<Message> messages;
  final Map<String, int> categoryCounts;

  const SummaryScreen({
    Key? key,
    required this.messages,
    required this.categoryCounts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Summary',
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.purple),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categoryCounts.length,
        itemBuilder: (context, index) {
          final entry = categoryCounts.entries.elementAt(index);
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.folder, color: Colors.purple),
              title: Text(
                entry.key,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: Text(
                '${entry.value} messages',
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CategoryListScreen(
                      category: entry.key,
                      messages:
                          MockSmsData.byCategory(messages, entry.key) ?? [],
                    ),
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
