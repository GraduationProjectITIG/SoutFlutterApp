import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sout/Screens/discover/comment.dart';
import 'package:sout/Screens/home/audio.dart';
import 'package:sout/blocs/userbloc.dart';
import 'package:sout/models/post.dart';
import 'package:sout/models/user.dart';
import 'package:sout/utils/scroll_physics_like_ios.dart';
import '../../service_locator.dart';
import '../drawer.dart';
import 'package:intl/intl.dart';
// import 'MyCard.dart';
// import 'package:sout/models/models.dart';

// import 'package:transparent_image/transparent_image.dart';
class Bookmarks extends StatefulWidget {
  UserModel logedUser = UserModel();
  Bookmarks({this.logedUser});
  // final String title;

  @override
  _BookmarksState createState() => _BookmarksState(); //_:private
}

class ImageCard extends StatelessWidget {
  final String imagePath;

  ImageCard({this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Image.asset(imagePath),
    );
  }
}

class _BookmarksState extends State<Bookmarks> {
  // List<Posts> postList=new List();
  // List<String> imgs = [
  //   "https://picsum.photos/200/300",
  //   "https://via.placeholder.com/150",
  //   "https://via.placeholder.com/150"
  // ];
  BuildContext dialogContext;
  PostModel bookmark = PostModel();
  PostModel bookmark1 = PostModel();
  List<PostModel> list = [];
  List _options = ['Bookmark', 'Report Post'];
  final _text = TextEditingController();
  int likes = 0;
  void initState() {
    super.initState();
    print("initState");
    getBookmarksFromFirestore();
  }

  getBookmarksFromFirestore() async {
    bookmark.description = 'Hello Everyone';
    bookmark.image = 'https://picsum.photos/200';
    bookmark.owner = {
      'name': 'Fatma Gamal',
      'picURL': 'https://picsum.photos/id/1001/200'
    };
    bookmark.date = new Timestamp.now();

    bookmark1.description = 'Hello world!';
    bookmark1.image = '';
    bookmark1.owner = {
      'name': 'Abdelrahman',
      'picURL': 'https://picsum.photos/id/1001/200'
    };
    bookmark1.date = new Timestamp.now();

    list.add(bookmark);
    list.add(bookmark1);
    print("after list");
    // CollectionReference _firestore = Firestore.instance.collection("Users");

    // QuerySnapshot bookmarksSnap = await _firestore
    //     .doc(widget.logedUser.id)
    //     .collection('bookmarks')
    //     .getDocuments();
    // print("id");
    // print(bookmarksSnap);
    // bookmarksSnap.documents.forEach((document) {
    //   print(document.data);
    // });

    //  return Scaffold(
    //         drawer: buildDrawer(context),
    //         body: Container(
    //           child: ListView.builder(
    //               physics: iosScrollPhysics(),
    //               itemCount: list.length,
    //               itemBuilder: (context, index) {
    //                 return list[index];
    //               }),
    //         ),
    //       );

    // return StreamBuilder<QuerySnapshot>(
    //     stream: ,
    //     builder: (context, snapshot) {
    //       print("snap");
    //       print(snapshot);
    //       if (snapshot.data != null) {
    //         for (var item in snapshot.data.docs) {
    //           list.add(item);
    //           print("item");
    //           print(item);
    //         }
    //       }
    //       return Scaffold(
    //         drawer: buildDrawer(context),
    //         body: Container(
    //           child: ListView.builder(
    //               physics: iosScrollPhysics(),
    //               itemCount: list.length,
    //               itemBuilder: (context, index) {
    //                 return list[index];
    //               }),
    //         ),
    //       );
    //     });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //String width = "80";//MediaQuery.of(context).size.width/4;
    // double myWidth=150;
    // String width1 = "150";
    // Image img1=Image.network("https://picsum.photos/id/237/80/300");
    print("build");
    print(list[0].description);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                child: new InkWell(
                    onTap: () {
                      print("taped");
                      showDialog(
                          context: context,
                          builder: (context) {
                            dialogContext = context;
                            return Dialog(
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: new BorderRadius.all(
                              //       new Radius.circular(32.0)),
                              // ),
                              // elevation: 16,
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      decoration: new BoxDecoration(
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.grey[300],
                                            blurRadius: 25.0,
                                          ),
                                        ],
                                      ),
                                      // child: Card(
                                      // shape: RoundedRectangleBorder(
                                      //     // side: BorderSide(width: 0.2),
                                      //     borderRadius: BorderRadius.circular(12)),
                                      // margin: EdgeInsets.fromLTRB(7, 0, 7, 7),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Row(children: [
                                              CircleAvatar(
                                                radius: 29.0,
                                                backgroundImage: NetworkImage(
                                                    list[index]
                                                        .owner['picURL']),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              SizedBox(width: 7),
                                              Text(list[index].owner['name'],
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: PopupMenuButton(
                                                  icon: Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(120, 0, 0, 0),
                                                    child: Icon(
                                                      Icons.more_horiz,
                                                      color: Colors.red[900],
                                                      size: 26,
                                                    ),
                                                  ),
                                                  itemBuilder:
                                                      (BuildContext bc) {
                                                    return _options
                                                        .map((x) =>
                                                            PopupMenuItem(
                                                              child: Text(x),
                                                              value: x,
                                                            ))
                                                        .toList();
                                                  },
                                                  onSelected: (value) {
                                                    setState(() {
                                                      // _selectedItem = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ]),
                                            Column(
                                              children: [
                                                SizedBox(height: 5),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          66, 0, 0, 0),
                                                      child: Icon(
                                                        Icons.public,
                                                        size: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          3, 0, 20, 0),
                                                      child: Text(
                                                          list[index]
                                                              .date
                                                              .toDate()
                                                              .toLocal()
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[700])),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),

                                            //   ],
                                            // ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                5, 15, 0, 15),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            list[index]
                                                                .description,
                                                            style: TextStyle(
                                                                fontSize: 19),
                                                          ),
                                                        ),
                                                      ),
                                                      Image.network(
                                                          list[index].image),
                                                      if (list[index].audio ==
                                                          "")
                                                        Container()
                                                      else
                                                        Audio(
                                                            url: list[index]
                                                                .audio)
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const Divider(
                                              height: 15,
                                              thickness: 1,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      2, 0, 0, 0),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 15, 8),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: IconButton(
                                                            icon: Icon(
                                                              Icons
                                                                  .thumb_up_alt_outlined,
                                                              size: 20,
                                                              color: Colors
                                                                  .red[900],
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                likes += 1;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        Text("Like",
                                                            style: TextStyle(
                                                                fontSize: 16)),
                                                        if (likes == 0)
                                                          SizedBox(
                                                            width: 5,
                                                          )
                                                        else
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                  likes
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold))
                                                            ],
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 8, 15, 8),
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  2, 0, 2, 0),
                                                          child: Icon(
                                                            Icons
                                                                .mic_none_outlined,
                                                            size: 20,
                                                            color:
                                                                Colors.red[900],
                                                          ),
                                                        ),
                                                        Text("Voice",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 0, 0, 0),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons
                                                                .comment_outlined,
                                                            size: 20,
                                                            color:
                                                                Colors.red[900],
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Dialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  elevation: 0,
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        540.0,
                                                                    width: mediaQuery
                                                                        .size
                                                                        .width,
                                                                    child:
                                                                        ListView(
                                                                      children: <
                                                                          Widget>[
                                                                        SizedBox(
                                                                            height:
                                                                                20),
                                                                        Center(
                                                                          child:
                                                                              Text(
                                                                            "Comments",
                                                                            style:
                                                                                TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                5),
                                                                        Comment(
                                                                            ownerImg:
                                                                                'https://picsum.photos/50/50',
                                                                            ownerName:
                                                                                "Mai Ahmed",
                                                                            desc:
                                                                                "Good Post",
                                                                            date:
                                                                                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString()),
                                                                        Comment(
                                                                            ownerImg:
                                                                                'https://picsum.photos/50/50',
                                                                            ownerName:
                                                                                "Mai Ahmed",
                                                                            desc:
                                                                                "Hello Hello",
                                                                            date:
                                                                                DateFormat('yyyy-MM-dd').format(DateTime.now()).toString())
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      Text("Comment",
                                                          style: TextStyle(
                                                            fontSize: 19,
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              height: 15,
                                              thickness: 1,
                                            ),
                                            Row(children: [
                                              CircleAvatar(
                                                radius: 20.0,
                                                backgroundImage: NetworkImage(
                                                    list[index]
                                                        .owner['picURL']),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              SizedBox(width: 1),
                                              Expanded(
                                                  child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 5, 0, 0),
                                                    child: TextField(
                                                      style:
                                                          TextStyle(height: 1),
                                                      controller: _text,
                                                      decoration:
                                                          new InputDecoration(
                                                        fillColor:
                                                            Colors.grey[300],
                                                        filled: true,
                                                        border:
                                                            new OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(35),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                        hintStyle:
                                                            new TextStyle(
                                                                color: Colors
                                                                    .grey[700]),
                                                        hintText:
                                                            "Write a comment...",
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                14,
                                                                11.5,
                                                                0,
                                                                11.5),
                                                        isDense: true,
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: IconButton(
                                                      icon: Icon(
                                                        Icons.send,
                                                        color: Colors.red[900],
                                                      ),
                                                      onPressed: () {
                                                        _text.clear();
                                                        setState(() {});
                                                      },
                                                    ),
                                                  )
                                                ],
                                              )),
                                            ])
                                          ],
                                        ),
                                      ),
                                    ),
                                  ]),
                            );
                          });
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          (list[index].image != '')
                              ? Container(
                                  width: 150,
                                  height: 150,
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.topLeft,
                                  child: Image.network(list[index].image))
                              : Container(
                                  width: 150,
                                  height: 150,
                                  margin: EdgeInsets.all(10),
                                  alignment: Alignment.topLeft,
                                  child: Image.network(
                                      list[index].owner['picURL'])),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(list[index].description,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Column(children: <Widget>[
                                    Text("Bookmark Section . Later"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: <Widget>[
                                      CircleAvatar(
                                        radius: 18.0,
                                        backgroundImage: NetworkImage(
                                            list[index].owner['picURL']),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Text("  Saved From "),
                                      Text(list[index].owner['name']),
                                    ]),
                                  ])),

                              // SizedBox(
                              //   height: 35,
                              // ),
                              // Text(list[index].description),
                            ],
                          ),
                        ])));
          }),
    );
  }
}
