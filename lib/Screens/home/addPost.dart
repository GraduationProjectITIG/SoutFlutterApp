import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sout/Screens/home/recorderTest/recorderExample.dart';
import 'package:sout/blocs/blocs.dart';
import 'package:sout/models/models.dart';

import '../../service_locator.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  //FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentReference _documentReference =
      FirebaseFirestore.instance.collection('post').doc();

  //post initialize
  PostModel _myPost = PostModel();

  //Text Controller
  final myController = TextEditingController();

  //Image picker
  File _image;
  final picker = ImagePicker();

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //Recorder
  bool wantToRecord = false;
  String recordedFile;
  setRecordedFile(myFile) {
    recordedFile = myFile;
  }
  // bool isRecDone = false;
  // Directory appDirectory;
  // String recordedFile;
  // _recDone() {
  //   getApplicationDocumentsDirectory().then((value) {
  //     appDirectory = value;
  //     appDirectory.list().listen((onData) {
  //       recordedFile = onData.path;
  //     });
  //   });
  //   setState(() {
  //     isRecDone = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextField(
              cursorColor: Colors.redAccent,
              cursorHeight: 40,
              maxLength: 240,
              minLines: 1,
              maxLines: 11,
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              )),
          _image != null
              ? Image(
                  image: FileImage(_image),
                  width: 200,
                  height: 200,
                )
              : SizedBox(),
          wantToRecord
              ? RecorderExample(
                  filePath: setRecordedFile,
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child: Icon(
                    Icons.image,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    getImageCamera();
                  },
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      wantToRecord = true;
                    });
                  },
                  child: Icon(
                    Icons.keyboard_voice,
                    color: Colors.redAccent,
                    size: 40,
                  ),
                )
              ],
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        tooltip: 'Post',
        child: Icon(
          Icons.done,
          size: 40,
          color: Colors.white,
        ),
        onPressed: () {
          // var temp = myController.text;
          // print(recordedFile);
          // print(temp);
          // print(_image.path);
          _uploadPost();
          Navigator.pop(context, true);
        },
      ),
    );
  }

  _uploadPost() async {
    _myPost.description = myController.text;
    if (_image != null) {
      _myPost.image = await uploadImageToFirebase();
    }
    if (recordedFile != null) {
      _myPost.audio = await uploadAudioToFirebase();
    }
    Map<String, dynamic> owner = Map();
    // owner['id'] = sL<UserBloc>().user.id;
    // owner['name'] =
    //     sL<UserBloc>().user.firstName + ' ' + sL<UserBloc>().user.lastName;
    // owner['picURL'] = sL<UserBloc>().user.picURL;
    owner['id'] = "fakeID";
    owner['name'] = "Mohamed Magdy";
    owner['picURL'] =
        "https://firebasestorage.googleapis.com/v0/b/sout-2d0f6.appspot.com/o/Users%2Fprofile_pics%2Fj9ppSV3XMgP96xIYYrfFLfN4B4u2?alt=media&token=1b1a772c-f4ad-4cab-8f46-dac3f1fffb1d";
    _myPost.owner = owner;
    PostModel postModel = new PostModel();
    postModel.addPost(_myPost);
  }

  Future uploadImageToFirebase() async {
    String fileName = _image.path;
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('/post/images/$fileName');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    print(imageUrl.toString());
    return imageUrl.toString();
    // firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    //     );
  }

  Future<String> uploadAudioToFirebase() async {
    File _audio = File(recordedFile);
    String fileName = recordedFile;
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('/post/audio/$fileName');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(_audio);
    var audioUrl = await (await uploadTask).ref.getDownloadURL();
    print(audioUrl.toString());
    return audioUrl.toString();
    // firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // taskSnapshot.ref.getDownloadURL().then(
    //       (value) => print("Done: $value"),
    //     );
  }
}
