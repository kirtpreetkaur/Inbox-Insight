import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';

class MessageDetail extends StatelessWidget {
  final Message message;
  final String category;

  const MessageDetail({required this.message, required this.category, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Choose background & primary colors based on category
    Color bgColor;
    IconData icon;
    String actionText;

    switch (category) {
      case 'Bills Due':
        bgColor = Colors.red[100]!;
        icon = Icons.payment;
        actionText = 'Pay Now';
        break;
      case 'Subscriptions':
        bgColor = Colors.purple[100]!;
        icon = Icons.autorenew;
        actionText = 'Renew Now';
        break;
      case 'High-Value Offers':
      case 'Offers':
        bgColor = Colors.orange[100]!;
        icon = Icons.local_offer;
        actionText = 'Redeem Now';
        break;
      default:
        bgColor = Colors.blue[100]!;
        icon = Icons.message;
        actionText = 'Accept';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        title: const Text(
          'Message Detail',
          style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: GlassCard(
          child: Container(
            width: 380,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 60, color: Colors.black87),
                const SizedBox(height: 12),
                Text(
                  category,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  message.text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple[400],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(actionText),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(actionText),
                            content: Text('Simulated action: "$actionText" executed.'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                        side: const BorderSide(color: Colors.deepPurple),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('Ignore'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
