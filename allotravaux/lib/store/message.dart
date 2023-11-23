import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final String date;
  final bool isMe;

  const Message({required this.text, required this.date, required this.isMe});

  factory Message.fromDocument(DocumentSnapshot doc) {
    String text = doc.get('text');
    String date = doc.get('date').toString();
    bool isMe = doc.get('isMe');
    return Message(text: text, date: date, isMe: isMe);
  }
}
