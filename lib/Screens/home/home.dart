import 'package:flutter/material.dart';
import 'package:sout/Screens/home/addPost.dart';
import 'package:sout/Screens/home/postCard.dart';
import 'package:sout/blocs/blocs.dart';
//import 'package:sout/blocs/chatbloc.dart';
import 'package:sout/models/chat.dart';
import 'package:sout/service_locator.dart';

//import 'postCard.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //ChatBloc myChatBloc = ChatBloc();
  //List<ChatModel> myList = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      // body: Row(
      //   children: [
      //     Center(
      //         child: StreamBuilder(
      //       stream: sL<ChatBloc>().stream,
      //       builder: (context, snapshot) {
      //         print(snapshot.data.toString());
      //         return Container();
      //       },
      //     )),
      //     RaisedButton(
      //       onPressed: () {
      //         print("pressed");
      //         //myChatBloc.getUserChats('fdSTyNEXz1WNkIn0AljDirnUflZ2');
      //         // .getUserChats('fdSTyNEXz1WNkIn0AljDirnUflZ2')
      //         // .then((value) => myList = value);
      //         //print(myList[0]);
      //         //sL<ChatBloc>().getUserChats('fdSTyNEXz1WNkIn0AljDirnUflZ2');
      //       },
      //       color: Colors.blue[500],
      //       child: Text(
      //         "Press",
      //         style: TextStyle(color: Colors.white, fontSize: 25),
      //       ),
      //     ),
      //   ],
      // ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return PostCard(
              ownerImg: 'https://picsum.photos/50/50',
              ownerName: 'Mohamed Magdy',
              img: 'https://picsum.photos/370/200',
              date: '6/3/2021',
              description: 'Lorem ipsum ay kalam',
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.settings_voice_sharp,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
      ),
    );
  }
}
