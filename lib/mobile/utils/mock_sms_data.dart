import 'package:flutter/material.dart';

class Message {
  final String sender;
  final String text;
  final IconData icon;
  Message({required this.sender, required this.text, required this.icon});
}

class MockSmsData {
  static List<Message> load() {
    return [
      Message(sender: 'Flipkart', text: 'Flat 30% off on home appliances. Offer valid till 22 Oct.', icon: Icons.local_offer),
      Message(sender: 'Airtel', text: 'Recharge ₹149 and get 1.5GB/day for 28 days. Offer valid 3 days.', icon: Icons.sim_card),
      Message(sender: 'BankX', text: 'Your credit card bill of ₹2500 is due tomorrow.', icon: Icons.account_balance),
      Message(sender: 'Netflix', text: 'Your subscription will expire on 25 Oct. Renew now to avoid interruption.', icon: Icons.movie),
      Message(sender: 'Foodie', text: 'Buy 1 Get 1 free on orders above ₹399. Limited time.', icon: Icons.local_pizza),
      Message(sender: 'PayX', text: 'INR 1200 credited to your account. Txn ID: 12345.', icon: Icons.account_balance_wallet),
      Message(sender: 'Govt', text: 'Important: Your PAN needs verification. Visit link.', icon: Icons.gavel),
      Message(sender: 'Airtel', text: 'Get 2GB free for 7 days with this code.', icon: Icons.sim_card)
    ];
  }
}

String getMessageType(String text) {
  text = text.toLowerCase();
  if (text.contains('offer') || text.contains('discount') || text.contains('off')) {
    return 'Offer';
  } else if (text.contains('credited') || text.contains('debited') || text.contains('txn')) {
    return 'Transaction';
  } else if (text.contains('recharge') || text.contains('data')) {
    return 'Service';
  } else if (text.contains('due') || text.contains('bill')) {
    return 'Reminder';
  } else if (text.contains('verify') || text.contains('important')) {
    return 'Government Notice';
  } else {
    return 'General';
  }
}

