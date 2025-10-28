import 'package:flutter/material.dart';

/// Represents a single SMS message
class Message {
  final String id;
  final String sender;
  final String text;
  final DateTime time;
  final String category; // message category (e.g. Offer, Service, etc.)
  final IconData icon;

  Message({
    required this.id,
    required this.sender,
    required this.text,
    required this.time,
    required this.category,
    required this.icon,
  });
}

/// Provides mock SMS data and helper utilities
class MockSmsData {
  // ✅ Load all messages once and reuse
  static final List<Message> messages = loadAll();

  /// ✅ Public version for access from main/inbox_screen
  static List<Message> loadAll() {
    final now = DateTime.now();
    return [
      // Promotional
      Message(
        id: 'promo1',
        sender: 'Flipkart',
        text: 'Flash sale: Up to 70% off on electronics. Today only!',
        time: now.subtract(const Duration(hours: 2)),
        category: 'Promotional',
        icon: Icons.campaign,
      ),
      Message(
        id: 'promo2',
        sender: 'Myntra',
        text: 'Summer styles starting at ₹299 — limited stock.',
        time: now.subtract(const Duration(days: 1)),
        category: 'Promotional',
        icon: Icons.shopping_bag,
      ),

      // Offer
      Message(
        id: 'offer1',
        sender: 'Airtel',
        text: 'Recharge ₹149 and get 1.5GB/day for 28 days. Offer valid 3 days.',
        time: now.subtract(const Duration(hours: 6)),
        category: 'Offer',
        icon: Icons.local_offer,
      ),
      Message(
        id: 'offer2',
        sender: 'Foodie',
        text: 'Buy 1 Get 1 free on orders above ₹399. Limited time.',
        time: now.subtract(const Duration(hours: 10)),
        category: 'Offer',
        icon: Icons.local_pizza,
      ),

      // Service
      Message(
        id: 'service1',
        sender: 'Amazon',
        text: 'Your order #A1234 has been shipped. Track: link',
        time: now.subtract(const Duration(hours: 3)),
        category: 'Service',
        icon: Icons.local_shipping,
      ),
      Message(
        id: 'service2',
        sender: 'Swiggy',
        text: 'Your delivery is nearby. Driver: Rahul, call 9876543210.',
        time: now.subtract(const Duration(minutes: 45)),
        category: 'Service',
        icon: Icons.delivery_dining,
      ),

      // Transactional
      Message(
        id: 'txn1',
        sender: 'BankX',
        text: 'INR 1200 credited to your account. Txn ID: 12345.',
        time: now.subtract(const Duration(hours: 1)),
        category: 'Transactional',
        icon: Icons.account_balance_wallet,
      ),

      // OTP/Security
      Message(
        id: 'txn2',
        sender: 'PayX',
        text: 'Your OTP for login is 482910. Do not share with anyone.',
        time: now.subtract(const Duration(minutes: 10)),
        category: 'Security/OTP',
        icon: Icons.vpn_key,
      ),

      // Government
      Message(
        id: 'gov1',
        sender: 'Govt',
        text: 'Important: Your PAN needs verification. Visit link.',
        time: now.subtract(const Duration(days: 2)),
        category: 'Government',
        icon: Icons.gavel,
      ),
      Message(
        id: 'gov2',
        sender: 'Aadhar',
        text: 'Your Aadhaar update is successful. Ref: #A9B8C7',
        time: now.subtract(const Duration(days: 5)),
        category: 'Government',
        icon: Icons.how_to_reg,
      ),

      // Personal / Friend
      Message(
        id: 'friend1',
        sender: 'Rahul',
        text: 'Hey, are we meeting tonight at 8?',
        time: now.subtract(const Duration(hours: 7)),
        category: 'Personal',
        icon: Icons.person,
      ),

      // Corporate / Workplace
      Message(
        id: 'work1',
        sender: 'HR',
        text: 'Reminder: Team meeting tomorrow 10:00 AM. Join via Teams.',
        time: now.subtract(const Duration(days: 1, hours: 2)),
        category: 'Corporate/Workplace',
        icon: Icons.work,
      ),

      // Health / Wellness
      Message(
        id: 'health1',
        sender: 'Apollo',
        text: 'Appointment confirmed with Dr. Sharma at 9:30 AM tomorrow.',
        time: now.subtract(const Duration(days: 3)),
        category: 'Health/Wellness',
        icon: Icons.health_and_safety,
      ),

      // Education
      Message(
        id: 'edu1',
        sender: 'College',
        text: 'Your assignment deadline extended to 5th Nov. Submit on portal.',
        time: now.subtract(const Duration(days: 4)),
        category: 'Education',
        icon: Icons.school,
      ),

      // Travel
      Message(
        id: 'travel1',
        sender: 'IndiGo',
        text: 'Your flight 6E-123 is confirmed for 05 Nov 06:00 AM. Check-in open.',
        time: now.subtract(const Duration(days: 6)),
        category: 'Travel',
        icon: Icons.flight,
      ),

      // Finance / Insurance
      Message(
        id: 'finance1',
        sender: 'HDFC Bank',
        text: 'Your EMI of ₹2,349 is due on 2nd Nov. Click to pay now.',
        time: now.subtract(const Duration(days: 2, hours: 6)),
        category: 'Finance/Insurance',
        icon: Icons.account_balance,
      ),

      // Utilities
      Message(
        id: 'util1',
        sender: 'ElectricCo',
        text: 'Your electricity bill ₹1,200 is due on 28 Oct. Pay to avoid late fee.',
        time: now.subtract(const Duration(days: 7)),
        category: 'Utilities',
        icon: Icons.electrical_services,
      ),

      // Extra OTP
      Message(
        id: 'otp1',
        sender: 'Auth',
        text: 'Your OTP is 829301 (valid for 10 minutes).',
        time: now.subtract(const Duration(minutes: 4)),
        category: 'Security/OTP',
        icon: Icons.vpn_key,
      ),
    ];
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
    const nonPublic = {'Security/OTP', 'Transactional'};
    return !nonPublic.contains(category);
  }
}
