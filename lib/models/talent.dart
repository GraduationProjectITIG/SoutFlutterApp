// import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: implementation_imports

class TalentModel {
  String id, name;

  TalentModel({this.id = "", this.name = ""});

  factory TalentModel.fromDocument(DocumentSnapshot doc) {
    return TalentModel(id: doc.data()["id"], name: doc.data()["name"]);
  }


  Future<List<TalentModel>> getAllTalents() async {
    // ignore: deprecated_member_use
    CollectionReference ref = Firestore.instance.collection('talents');
    // ignore: deprecated_member_use
    QuerySnapshot talentsQuery = await ref.getDocuments();

    HashMap<String, TalentModel> talentsHashMap = new HashMap<String, TalentModel>();

    // ignore: deprecated_member_use
    talentsQuery.documents.forEach((document) {
      talentsHashMap.putIfAbsent(document['id'], () {
        var talentModel = new TalentModel.fromDocument(document);
        return talentModel;
      });
    });
    print(talentsHashMap.values.toList().length);
    // print(talentsHashMap.values.toList()[7]);

    return talentsHashMap.values.toList();
  }
}
