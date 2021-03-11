// import 'dart:html';

import 'message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String id, sender, receiver;
  DateTime startDate;
  List<MessageModel> messages;

  // Future<void> getChats() async {
  //   await FirebaseFirestore.instance
  //       .collection('chat')
  //       .get()
  //       .then((querySnapshot) => print(querySnapshot));
  // }
}
