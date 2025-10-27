import 'package:flutter/material.dart';
import '../utils/mock_sms_data.dart';

class AIResult {
  final Map<String, List<Message>> categories;
  final Map<String, dynamic> summary;
  AIResult({required this.categories, required this.summary});
}

class AiClassifier {
  // simple rule-based classifier + summarizer
  static AIResult process(List<Message> messages) {
    Map<String, List<Message>> cats = {
      'High-Value Offers': [],
      'Bills Due': [],
      'Expiring Subscriptions': [],
      'Promotions': [],
      'Transactions': [],
      'Others': []
    };
    for (var m in messages) {
      String t = m.text.toLowerCase();
      if (t.contains('recharge') || t.contains('data') || t.contains('gb') || t.contains('offer')) {
        if (t.contains('recharge')|| t.contains('data') || t.contains('gb')) {
          cats['High-Value Offers']!.add(m);
        } else {
          cats['Promotions']!.add(m);
        }
      } else if (t.contains('bill') || t.contains('due') || t.contains('payment')) {
        cats['Bills Due']!.add(m);
      } else if (t.contains('expire') || t.contains('subscription') || t.contains('renew')) {
        cats['Expiring Subscriptions']!.add(m);
      } else if (t.contains('credited') || t.contains('debited') || t.contains('txn') || t.contains('transaction')) {
        cats['Transactions']!.add(m);
      } else {
        cats['Others']!.add(m);
      }
    }
    Map<String,dynamic> sums = {};
    cats.forEach((k,v){
      sums[k] = {
        'count': v.length,
        'summary': _makeSummary(k, v),
        'icon': _iconFor(k)
      };
    });
    return AIResult(categories: cats, summary: sums);
  }

  static String _makeSummary(String k, List<Message> msgs) {
    if (msgs.isEmpty) return 'None';
    if (k == 'High-Value Offers') return '${msgs.length} high-value offer(s) — check expiry';
    if (k == 'Bills Due') return '${msgs.length} bill(s) due — action recommended';
    if (k == 'Expiring Subscriptions') return '${msgs.length} subscriptions expiring';
    if (k == 'Promotions') return '${msgs.length} promotional messages';
    if (k == 'Transactions') return '${msgs.length} transaction alerts';
    return '${msgs.length} messages';
  }

  static IconData _iconFor(String k) {
    if (k == 'High-Value Offers') return Icons.star;
    if (k == 'Bills Due') return Icons.access_time;
    if (k == 'Expiring Subscriptions') return Icons.warning;
    if (k == 'Promotions') return Icons.local_offer;
    if (k == 'Transactions') return Icons.account_balance_wallet;
    return Icons.message;
  }
}
