import 'package:flutter/material.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';
import 'package:inboxinsight/mobile/screens/message_detail_screen.dart';
import 'package:inboxinsight/mobile/screens/plain_message_screen.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late List<Message> messages;

  @override
  void initState() {
    super.initState();
    messages = MockSmsData.loadAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inbox',
          style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.purple),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(msg.icon, color: Colors.purple),
              title: Text(msg.sender,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                msg.text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                "${msg.time.hour.toString().padLeft(2, '0')}:${msg.time.minute.toString().padLeft(2, '0')}",
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlainMessageScreen(message: msg),
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
