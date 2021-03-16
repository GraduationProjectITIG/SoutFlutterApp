import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id, sender, description;
  Timestamp date;

  MessageModel({this.id, this.sender, this.description, this.date});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'description': description,
      'date': date,
    };
  }
}
