// lib/mobile/screens/message_detail.dart
import 'package:flutter/material.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';
import 'package:inboxinsight/mobile/widgets/glass_card.dart';

class MessageDetail extends StatelessWidget {
  final Message message;
  final String category;

  const MessageDetail({required this.message, required this.category, Key? key}) : super(key: key);

  Color _bgForCategory(String category) {
    switch (category) {
      case 'Bills Due':
      case 'Finance/Insurance':
        return Colors.blue.shade50;
      case 'Offer':
      case 'Promotional':
        return Colors.orange.shade50;
      case 'Government':
        return Colors.red.shade50;
      case 'Health/Wellness':
        return Colors.green.shade50;
      case 'Travel':
        return Colors.indigo.shade50;
      case 'Corporate/Workplace':
        return Colors.grey.shade100;
      default:
        return Colors.purple.shade50;
    }
  }

  String _primaryText(String category, String text) {
    final lower = text.toLowerCase();
    if (lower.contains('offer') || category == 'Offer') return 'Redeem Now';
    if (lower.contains('bill') || category == 'Finance/Insurance') return 'Pay Now';
    if (lower.contains('renew') || category == 'Subscriptions') return 'Renew Now';
    if (lower.contains('appointment') || category == 'Health/Wellness') return 'Confirm';
    if (lower.contains('book') || category == 'Travel') return 'Book Now';
    if (category == 'Personal') return 'Reply';
    return 'Acknowledge';
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = _bgForCategory(category);
    final actionText = _primaryText(category, message.text);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        title: Text('Message', style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
      ),
      backgroundColor: const Color(0xFFF7F7F9),
      body: Center(
        child: GlassCard(
          blur: 12,
          opacity: 0.8,
          color: bgColor,
          padding: const EdgeInsets.all(0),
          child: Container(
            width: 560,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(message.icon, size: 56, color: Colors.black87),
              const SizedBox(height: 12),
              Text(category, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(message.text, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, color: Colors.black87)),
              const SizedBox(height: 20),
              Row(mainAxisSize: MainAxisSize.min, children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  icon: const Icon(Icons.check_circle_outline),
                  label: Text(actionText),
                  onPressed: () {
                    showDialog(context: context, builder: (_) => AlertDialog(title: Text(actionText), content: Text('Simulated: $actionText'), actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: const Text('OK'))]));
                  },
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.redAccent, width: 1.2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  ),
                  icon: const Icon(Icons.close, color: Colors.redAccent),
                  label: const Text('Ignore', style: TextStyle(color: Colors.redAccent)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
