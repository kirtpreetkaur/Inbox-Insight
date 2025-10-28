import 'package:flutter/material.dart';
import 'smart_categorizer.dart';

/// Represents a single SMS message
class Message {
  final String id;
  final String sender;
  final String text;
  final DateTime time;
  String category; // message category (e.g. Offer, Service, etc.)
  IconData icon;

  Message({
    required this.id,
    required this.sender,
    required this.text,
    required this.time,
    this.category = 'Others',
    this.icon = Icons.sms,
  });
}

/// Provides mock SMS data and helper utilities
class MockSmsData {
  /// ✅ Load all messages once and reuse
  static final List<Message> messages = loadAll();

  /// ✅ Public version for access from main/inbox_screen
  static List<Message> loadAll() {
    final now = DateTime.now();

    // Base messages (no hard-coded categories)
    final List<Message> baseMessages = [
      Message(
        id: '1',
        sender: 'Flipkart',
        text: 'Flash sale: Up to 70% off on electronics. Today only!',
        time: now.subtract(const Duration(hours: 2)),
      ),
      Message(
        id: '2',
        sender: 'Airtel',
        text: 'Recharge ₹149 and get 1.5GB/day for 28 days. Offer valid 3 days.',
        time: now.subtract(const Duration(hours: 6)),
      ),
      Message(
        id: '3',
        sender: 'BankX',
        text: 'INR 1200 credited to your account. Txn ID: 12345.',
        time: now.subtract(const Duration(hours: 1)),
      ),
      Message(
        id: '4',
        sender: 'PayX',
        text: 'Your OTP for login is 482910. Do not share with anyone.',
        time: now.subtract(const Duration(minutes: 10)),
      ),
      Message(
        id: '5',
        sender: 'Govt',
        text: 'Important: Your PAN needs verification. Visit link.',
        time: now.subtract(const Duration(days: 2)),
      ),
      Message(
        id: '6',
        sender: 'Friend',
        text: 'Hey, are we meeting tonight at 8?',
        time: now.subtract(const Duration(hours: 7)),
      ),
      Message(
        id: '7',
        sender: 'Apollo',
        text: 'Appointment confirmed with Dr. Sharma at 9:30 AM tomorrow.',
        time: now.subtract(const Duration(days: 3)),
      ),
      Message(
        id: '8',
        sender: 'College',
        text: 'Your assignment deadline extended to 5th Nov. Submit on portal.',
        time: now.subtract(const Duration(days: 4)),
      ),
      Message(
        id: '9',
        sender: 'IndiGo',
        text: 'Your flight 6E-123 is confirmed for 05 Nov 06:00 AM. Check-in open.',
        time: now.subtract(const Duration(days: 6)),
      ),
      Message(
        id: '10',
        sender: 'ElectricCo',
        text: 'Your electricity bill ₹1,200 is due on 28 Oct. Pay to avoid late fee.',
        time: now.subtract(const Duration(days: 7)),
      ),
      Message(
        id: '11',
        sender: 'UnknownSender',
        text: 'Test message with random content.',
        time: now.subtract(const Duration(days: 1, hours: 3)),
      ),
    ];

    // 🧠 Auto-categorize using SmartCategorizer
    final categorized = SmartCategorizer.categorizeMessages(baseMessages);

    // 🖼️ Assign icons dynamically per category
    for (var msg in categorized) {
      msg.icon = _iconForCategory(msg.category);
    }

    return categorized;
  }

  /// Returns counts per category
  static Map<String, int> categoryCounts(List<Message> msgs) {
    final Map<String, int> counts = {};
    for (var m in msgs) {
      counts[m.category] = (counts[m.category] ?? 0) + 1;
    }
    return counts;
  }

  /// Get all messages in a given category
  static List<Message> byCategory(List<Message> msgs, String category) {
    return msgs.where((m) => m.category == category).toList();
  }

  /// Whether Unsplash/visual API should be fetched for this category
  static bool isPublicVisual(String category) {
    const nonPublic = {'Security/OTP', 'Transactional', 'Others'};
    return !nonPublic.contains(category);
  }

  /// 🔹 Assign icons based on category
  static IconData _iconForCategory(String category) {
    switch (category) {
      case 'Transactional':
        return Icons.account_balance_wallet;
      case 'Offer':
      case 'Promotional':
        return Icons.local_offer;
      case 'Government':
        return Icons.gavel;
      case 'Service':
        return Icons.build_circle;
      case 'Personal':
        return Icons.person;
      case 'Health/Wellness':
        return Icons.health_and_safety;
      case 'Education':
        return Icons.school;
      case 'Travel':
        return Icons.flight;
      case 'Utilities':
        return Icons.electrical_services;
      case 'Security/OTP':
        return Icons.vpn_key;
      case 'Corporate/Workplace':
        return Icons.work;
      default:
        return Icons.sms; // ✅ "Others" or unrecognized
    }
  }
}
