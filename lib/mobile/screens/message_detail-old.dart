import 'package:flutter/material.dart';
import '../ai/ai_classifier.dart';
import '../widgets/glass_card.dart';
import 'package:inboxinsight/mobile/utils/mock_sms_data.dart';



class MessageDetail extends StatelessWidget {
  final Message message;
  final String category;
  MessageDetail({required this.message, required this.category});

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (category == 'Bills Due') {
      actions.add(ElevatedButton.icon(onPressed: (){ showDialog(context: context, builder: (_)=>AlertDialog(title:Text('Payment'), content:Text('Fake payment processed.'), actions:[TextButton(onPressed: ()=>Navigator.pop(context), child:Text('OK'))])); }, icon: Icon(Icons.payment), label: Text('Pay Now')));
    } else if (category == 'High-Value Offers') {
      actions.add(ElevatedButton.icon(onPressed: (){ showDialog(context: context, builder: (_)=>AlertDialog(title:Text('Redeem'), content:Text('Fake redeem link opened.'), actions:[TextButton(onPressed: ()=>Navigator.pop(context), child:Text('OK'))])); }, icon: Icon(Icons.local_offer), label: Text('Redeem Offer')));
    } else {
      actions.add(TextButton(onPressed: (){}, child: Text('Ignore')));
    }

    return Scaffold(
      appBar: AppBar(title: Text('Message')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('From: ' + message.sender, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height:8),
          Text(message.text),
          SizedBox(height:16),
          Row(children: actions)
        ]),
      ),
    );
  }
}
