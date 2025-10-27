import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';

class MessageDetail extends StatelessWidget {
  final Message message;
  final String category;

  const MessageDetail({super.key, required this.message, required this.category});

  @override
  Widget build(BuildContext context) {
    final String messageType = getMessageType(message.text);

    // Pick a themed color based on message type
    Color cardColor;
    IconData icon;
    switch (messageType) {
      case 'Offer':
        cardColor = Colors.orangeAccent.withOpacity(0.3);
        icon = Icons.local_offer;
        break;
      case 'Transaction':
        cardColor = Colors.greenAccent.withOpacity(0.3);
        icon = Icons.account_balance_wallet;
        break;
      case 'Service':
        cardColor = Colors.blueAccent.withOpacity(0.3);
        icon = Icons.sim_card;
        break;
      case 'Reminder':
        cardColor = Colors.redAccent.withOpacity(0.3);
        icon = Icons.notification_important;
        break;
      case 'Government Notice':
        cardColor = Colors.purpleAccent.withOpacity(0.3);
        icon = Icons.gavel;
        break;
      default:
        cardColor = Colors.grey.withOpacity(0.3);
        icon = Icons.sms;
    }

    // Action button depending on message type
    Widget actionButton;
    if (messageType == 'Offer') {
      actionButton = ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Redeem Offer'),
              content: const Text('Fake redeem link opened.'),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
            ),
          );
        },
        icon: const Icon(Icons.card_giftcard),
        label: const Text('Redeem Now'),
      );
    } else if (messageType == 'Transaction') {
      actionButton = ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Payment'),
              content: const Text('Fake payment confirmation.'),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
            ),
          );
        },
        icon: const Icon(Icons.payment),
        label: const Text('View Transaction'),
      );
    } else if (messageType == 'Government Notice') {
      actionButton = ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Notice'),
              content: const Text('Official link opened.'),
              actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))],
            ),
          );
        },
        icon: const Icon(Icons.open_in_browser),
        label: const Text('View Notice'),
      );
    } else {
      actionButton = TextButton(onPressed: () {}, child: const Text('Close'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(message.sender),
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: GlassCard(
          blur: 20,
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 64, color: Colors.black87),
                const SizedBox(height: 12),
                Text(
                  messageType,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  message.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                actionButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
