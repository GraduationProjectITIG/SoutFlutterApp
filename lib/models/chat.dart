// import 'dart:html';

import 'dart:collection';

import 'message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String id, sender, receiver;
  Timestamp startDate;
  List<MessageModel> messages;

  ChatModel(
      {this.id, this.sender, this.receiver, this.startDate, this.messages}) {
    //print("constructooooor");
    //testFunction();
    //print(getUserChats('fdSTyNEXz1WNkIn0AljDirnUflZ2'))
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'startDate': startDate,
      'messages': messages,
    };
  }

  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    return ChatModel(
        id: doc.data()["id"],
        sender: doc.data()["sender"],
        receiver: doc.data()["receiver"],
        startDate: doc.data()["startDate"],
        messages: doc.data()["messages"]);
  }

  Future<HashMap<String, ChatModel>> getChats(String userID) async {
    // ignore: deprecated_member_use
    CollectionReference ref = Firestore.instance.collection('chat');
    // ignore: deprecated_member_use
    QuerySnapshot chatsQuery = await ref.getDocuments();

    HashMap<String, ChatModel> chatsHashMap = new HashMap<String, ChatModel>();

    chatsQuery.docs.forEach((document) {
      var tempChatModel = new ChatModel.fromDocument(document);
      if (tempChatModel.receiver == userID || tempChatModel.sender == userID) {
        chatsHashMap.putIfAbsent(document['id'], () {
          var chatsModel = new ChatModel.fromDocument(document);
          return chatsModel;
        });
      }
    });
    //print(chatsHashMap);

    return chatsHashMap;
  }

  Future<List<ChatModel>> getUserChats(String userID) async {
    List<String> chatsKeys;
    List<ChatModel> chats;
    HashMap<String, ChatModel> chatsHashMap;

    chatsHashMap = await getChats(userID);
    chatsKeys = chatsHashMap.keys;

    chatsKeys.toList().asMap().forEach((index, id) async {
      CollectionReference ref =
          // ignore: deprecated_member_use
          Firestore.instance.collection('chat/$id/1');
      // ignore: deprecated_member_use
      QuerySnapshot messagesQuery = await ref.getDocuments();
      chats[index].messages = messagesQuery.docs.cast<MessageModel>();
    });
    print('chats$chats');
    return chats;
  }

  sendMessage(MessageModel msg, String chatId) {
    // ignore: deprecated_member_use
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection('chat/$chatId/1').document();

    // ignore: deprecated_member_use
    String messageId = documentReference.documentID;
    msg.id = messageId;
    msg.date = new Timestamp.now();
    // ignore: deprecated_member_use
    documentReference.set(msg.toJson());
  }
}
