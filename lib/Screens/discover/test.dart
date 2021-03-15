import 'package:flutter/material.dart';
import 'package:sout/Screens/discover/postCard.dart';
// import 'package:intl/intl.dart';
// import 'package:sout/models/models.dart';
// import 'postCard.dart';

class Test extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Discover",
            style: TextStyle(fontSize: 23),
          ),
        ),
        body: PostCard(
          ownerImg: 'https://picsum.photos/50/50',
          ownerName: 'Mai Ahmed',
          img: '',
          date: '6/3/2021',
          description: 'Lorem ipsum ay kalam',
          audio: "",
          likes: 5,
          comments: [],
        ));
  }
}
