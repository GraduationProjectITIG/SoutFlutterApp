// import 'package:intl/intl.dart';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: implementation_imports

class PostModel {
  String id, description, audio, video, talent;
  dynamic image;
  dynamic owner;
  Timestamp date;
  List<dynamic> like;
  List<dynamic> comment;

  PostModel(
      {this.id = "",
      this.description = "",
      this.audio = "",
      this.video = "",
      this.image = "",
      this.talent = "",
      this.owner,
      this.date,
      this.like,
      this.comment});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'audio': audio,
      'video': video,
      'image': image,
      'talent': talent,
      'owner': owner,
      'date': date,
      'like': like,
      'comment': comment,
    };
  }

  factory PostModel.fromDocument(DocumentSnapshot doc) {
    return PostModel(
        id: doc.data()["id"],
        description: doc.data()["description"],
        audio: doc.data()["audio"],
        video: doc.data()["video"],
        image: doc.data()["image"],
        talent: doc.data()["talent"],
        owner: doc.data()["owner"],
        date: doc.data()["date"],
        like: doc.data()["like"],
        comment: doc.data()["comment"]);
  }

  Future<List<PostModel>> getAllPosts() async {
    // ignore: deprecated_member_use
    CollectionReference ref = Firestore.instance.collection('post');
    // ignore: deprecated_member_use
    QuerySnapshot postsQuery = await ref.getDocuments();

    HashMap<String, PostModel> postsHashMap = new HashMap<String, PostModel>();

    // ignore: deprecated_member_use
    postsQuery.documents.forEach((document) {
      postsHashMap.putIfAbsent(document['id'], () {
        var postModel = new PostModel.fromDocument(document);
        return postModel;
      });
    });
    print(postsHashMap.values.toList()[1].owner["id"]);
    print(postsHashMap.values.toList()[7].owner["name"]);

    return postsHashMap.values.toList();
  }

  addPost(PostModel post) {
    // ignore: deprecated_member_use
    DocumentReference documentReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection('post').document();

    ///////////////Test////////////////
    // post.description = "Flutter Technology 2 Post";
    // post.owner = {
    //   "id": "j9ppSV3XMgP96xIYYrfFLfN4B4u2",
    //   "name": "Maaii Ahmed",
    //   "picURL":
    //       "https://firebasestorage.googleapis.com/v0/b/sout-2d0f6.appspot.com/o/Users%2Fprofile_pics%2Fj9ppSV3XMgP96xIYYrfFLfN4B4u2?alt=media&token=1b1a772c-f4ad-4cab-8f46-dac3f1fffb1d"
    // };

    // ignore: deprecated_member_use
    String postId = documentReference.documentID;
    post.id = postId;
    post.date = new Timestamp.now();
    // ignore: deprecated_member_use
    documentReference.set(post.toJson());
  }

  deletePost(String id) {
    // ignore: deprecated_member_use
    Firestore.instance.collection('post').doc(id).delete();
  }

  Future<int> getPostLikes(PostModel post) async {
    // ignore: deprecated_member_use
    CollectionReference ref =
        // ignore: deprecated_member_use
        Firestore.instance.collection('post').doc(post.id).collection('like');
    // ignore: deprecated_member_use
    QuerySnapshot likesQuery = await ref.getDocuments();

    return likesQuery.docs.length;
  }

  Future<List<PostModel>> getPostsbyTalent(String talentId) async {
    // ignore: deprecated_member_use
    CollectionReference ref = Firestore.instance.collection('post');
    QuerySnapshot postsQuery = await ref
        .where("talent", isEqualTo: talentId)
        // ignore: deprecated_member_use
        .getDocuments();

    HashMap<String, PostModel> postsHashMap = new HashMap<String, PostModel>();

    // ignore: deprecated_member_use
    postsQuery.documents.forEach((document) {
      postsHashMap.putIfAbsent(document['id'], () {
        var postModel = new PostModel.fromDocument(document);
        return postModel;
      });
    });
    print(postsHashMap.values.toList()[0].description);

    return postsHashMap.values.toList();
  }

  Future<List<PostModel>> getAllUserPosts(String userId) async {
    // ignore: deprecated_member_use
    CollectionReference ref = Firestore.instance.collection('post');
    QuerySnapshot postsQuery = await ref
        .where("owner.id", isEqualTo: userId)
        // ignore: deprecated_member_use
        .getDocuments();

    HashMap<String, PostModel> postsHashMap = new HashMap<String, PostModel>();

    // ignore: deprecated_member_use
    postsQuery.documents.forEach((document) {
      postsHashMap.putIfAbsent(document['id'], () {
        var postModel = new PostModel.fromDocument(document);
        return postModel;
      });
    });
    print(postsHashMap.values.toList().length);

    return postsHashMap.values.toList();
  }
}


