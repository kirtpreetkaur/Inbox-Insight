import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';

class SmartCategorizer {
  static List<Message> categorizeMessages(List<Message> messages) {
    return messages.map((message) {
      String category;
      final text = message.text.toLowerCase();
      final sender = message.sender.toLowerCase();

      if (text.contains('otp') || text.contains('txn') || text.contains('debited') || text.contains('credited') || text.contains('balance')) {
        category = 'Transactional';
      } else if (text.contains('offer') || text.contains('discount') || text.contains('deal') || text.contains('sale')) {
        category = 'Offer';
      } else if (text.contains('win') || text.contains('promo') || text.contains('voucher') || text.contains('lottery') || text.contains('prize')) {
        category = 'Promotional';
      } else if (text.contains('govt') || text.contains('uidai') || text.contains('aadhar') || text.contains('pm') || text.contains('tax')) {
        category = 'Government';
      } else if (text.contains('subscription') || text.contains('plan') || text.contains('renew') || text.contains('expired') || text.contains('validity')) {
        category = 'Service';
      } else if (text.contains('hi') || text.contains('hello') || text.contains('how are you') || text.contains('see you') || text.contains('thanks')) {
        category = 'Personal';
      } else if (text.contains('delivered') || text.contains('shipped') || text.contains('order id') || text.contains('courier') || text.contains('arriving')) {
        category = 'Delivery';
      } else if (text.contains('doctor') || text.contains('appointment') || text.contains('hospital') || text.contains('medicine') || text.contains('report')) {
        category = 'Healthcare';
      } else if (text.contains('exam') || text.contains('school') || text.contains('college') || text.contains('admission') || text.contains('result')) {
        category = 'Education';
      } else if (text.contains('flight') || text.contains('train') || text.contains('bus') || text.contains('boarding') || text.contains('ticket')) {
        category = 'Travel';
      } else if (text.contains('meeting') || text.contains('webinar') || text.contains('conference') || text.contains('event') || text.contains('invite')) {
        category = 'Event';
      } else {
        category = 'Others';
      }

      return Message(
        id: message.id,
        sender: message.sender,
        text: message.text,
        time: message.time,
        category: category,
      );
    }).toList();
  }
}
