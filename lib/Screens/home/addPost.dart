import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextField(
                autofocus: true,
                cursorColor: Colors.redAccent,
                cursorHeight: 40,
                maxLength: 240,
                minLines: 10,
                maxLines: 11,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                )),
          ),
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
                Icon(
                  Icons.keyboard_voice,
                  color: Colors.redAccent,
                  size: 40,
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
        onPressed: () {},
      ),
    );
  }
}
