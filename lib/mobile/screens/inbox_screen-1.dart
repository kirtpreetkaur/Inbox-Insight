// lib/mobile/screens/inbox_screen.dart
import 'package:flutter/material.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';
import 'message_detail.dart';
import 'package:inboxinsight/mobile/widgets/glass_card.dart';

class InboxScreen extends StatelessWidget {
  final List<Message> messages = MockSmsData.loadAll();

  InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counts = MockSmsData.categoryCounts(messages);

    return Scaffold(
      appBar: AppBar(
        title: const Text('InboxInsight'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        titleTextStyle: const TextStyle(color: Colors.deepPurple, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      backgroundColor: const Color(0xFFF7F7F9),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Smart Digest row (category counts)
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: counts.entries.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        // navigate to category list
                        final list = MockSmsData.byCategory(messages, e.key);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CategoryScreen(category: e.key, messages: list)),
                        );
                      },
                      child: GlassCard(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(e.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Text('${e.value}'),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // Inbox list preview (latest messages)
            Expanded(
              child: ListView.separated(
                itemCount: messages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, idx) {
                  final msg = messages[idx];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MessageDetail(message: msg, category: msg.category)));
                    },
                    child: GlassCard(
                      child: Row(
                        children: [
                          CircleAvatar(backgroundColor: Colors.deepPurple[50], child: Icon(msg.icon, color: Colors.deepPurple)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(msg.sender, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text(msg.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                            ]),
                          ),
                          const SizedBox(width: 8),
                          Text(msg.category, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Category screen to list messages of a category
class CategoryScreen extends StatelessWidget {
  final String category;
  final List<Message> messages;
  const CategoryScreen({required this.category, required this.messages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        titleTextStyle: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: messages.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, idx) {
            final m = messages[idx];
            return GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MessageDetail(message: m, category: m.category))),
              child: GlassCard(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(m.icon, color: Colors.white), backgroundColor: Colors.deepPurple),
                  title: Text(m.sender),
                  subtitle: Text(m.text, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Text(m.time.hour.toString()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
