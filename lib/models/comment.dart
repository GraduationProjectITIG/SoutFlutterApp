import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String id, description;
  dynamic writer;
  Timestamp date;

  CommentModel({
    this.id = "",
    this.writer,
    this.description = "",
    this.date,
  });

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'writer': writer,
      'date': date,
    };
  }

  factory CommentModel.fromDocument(DocumentSnapshot doc) {
    return CommentModel(
        id: doc.data()["id"],
        description: doc.data()["description"],
        writer: doc.data()["writer"],
        date: doc.data()["date"],
        );
  }

  addComment(String postId,CommentModel comment) {
    // ignore: deprecated_member_use
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection('post').document(postId).collection('comment').doc();

    ///////////////Test////////////////
    // comment.description = "Flutter Comment 4";
    comment.writer = {
      "id": "j9ppSV3XMgP96xIYYrfFLfN4B4u2",
      "name": "Maaii Ahmed",
      "picURL":
          "https://firebasestorage.googleapis.com/v0/b/sout-2d0f6.appspot.com/o/Users%2Fprofile_pics%2Fj9ppSV3XMgP96xIYYrfFLfN4B4u2?alt=media&token=1b1a772c-f4ad-4cab-8f46-dac3f1fffb1d"
    };

    // ignore: deprecated_member_use
    String commentId = documentReference.documentID;
    comment.id = commentId;
    comment.date = new Timestamp.now();
    // ignore: deprecated_member_use
    documentReference.set(comment.toJson());
  }

 Future<List<CommentModel>> getPostComments(String postId) async {
    // ignore: deprecated_member_use
    CollectionReference ref = Firestore.instance.collection('post').doc(postId).collection('comment');
    // ignore: deprecated_member_use
    QuerySnapshot commentsQuery = await ref.getDocuments();

    HashMap<String, CommentModel> commentsHashMap = new HashMap<String, CommentModel>();

    // ignore: deprecated_member_use
    commentsQuery.documents.forEach((document) {
      commentsHashMap.putIfAbsent(document['id'], () {
        var commentModel = new CommentModel.fromDocument(document);
        return commentModel;
      });
    });
    print(commentsHashMap.values.toList().length);

    return commentsHashMap.values.toList();
  }
}