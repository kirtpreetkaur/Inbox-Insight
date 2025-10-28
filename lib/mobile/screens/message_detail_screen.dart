import 'dart:math';
import 'package:flutter/material.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';

class SmartMessageScreen extends StatelessWidget {
  final Message message;

  const SmartMessageScreen({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isTransactional = message.category == 'Transactional';
    final isOffer =
        message.category == 'Offer' || message.category == 'Promotional';
    final isOther = !isTransactional && !isOffer;

    // 🎨 Gradient color pairs
    final List<List<Color>> gradientPairs = [
      [Colors.purple.shade100, Colors.purple.shade50],
      [Colors.blue.shade100, Colors.blue.shade50],
      [Colors.pink.shade100, Colors.pink.shade50],
      [Colors.orange.shade100, Colors.orange.shade50],
      [Colors.teal.shade100, Colors.teal.shade50],
      [Colors.amber.shade100, Colors.amber.shade50],
      [Colors.green.shade100, Colors.green.shade50],
    ];

    final gradient = gradientPairs[Random().nextInt(gradientPairs.length)];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          message.sender,
          style: const TextStyle(color: Colors.deepPurple),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45, // Dynamic width
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: gradient.first.withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 🧩 Box fits content dynamically
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼️ Category Image inside the colored box
              if (MockSmsData.isPublicVisual(message.category))
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/${message.category.toLowerCase()}.jpeg',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              if (MockSmsData.isPublicVisual(message.category))
                const SizedBox(height: 18),

              // 💬 Message Text
              Text(
                message.text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 22),

              // 🎯 Action Buttons
              if (isOffer) ...[
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Subscribe"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("View Offer"),
                ),
              ] else if (isTransactional) ...[
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Pay Now"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Report"),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Ignore",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ] else if (isOther) ...[
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Mark as Read"),
                ),
              ],

              const SizedBox(height: 10),

              // 🕒 Message Timestamp
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'Received: ${message.time}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
