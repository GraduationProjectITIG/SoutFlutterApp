import 'package:flutter/material.dart';
import 'package:sout/Screens/home/audio.dart';

// ignore: must_be_immutable
class PostCard extends StatefulWidget {
  String ownerName;
  String ownerImg;
  String description;
  String img;
  String date;
  PostCard(
      {this.ownerName, this.ownerImg, this.description, this.img, this.date});
  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // String _selectedItem = 'Bookmark';
  List _options = ['Bookmark', 'Report Post'];
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.grey[300],
            blurRadius: 25.0,
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
            // side: BorderSide(width: 0.2),
            borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.fromLTRB(7, 0, 7, 7),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(widget.ownerImg),
                      backgroundColor: Colors.transparent,
                    ),
                    Column(
                      children: [
                        Text(widget.ownerName,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.public,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3, 0, 20, 0),
                              child: Text(widget.date,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[700])),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                      child: PopupMenuButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.red[900],
                          size: 26,
                        ),
                        itemBuilder: (BuildContext bc) {
                          return _options
                              .map((x) => PopupMenuItem(
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
                  ],
                ),
                Image.network(widget.img),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                            child: Text(
                              widget.description,
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                          Audio(
                              url:
                                  "https://luan.xyz/files/audio/ambient_c_motion.mp3")
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
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 8, 34, 8),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 22,
                                color: Colors.red[900],
                              ),
                            ),
                            Text("Like", style: TextStyle(fontSize: 19)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 34, 8),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                              child: Icon(
                                Icons.mic_none_outlined,
                                size: 23,
                                color: Colors.red[900],
                              ),
                            ),
                            Text("Voice",
                                style: TextStyle(
                                  fontSize: 19,
                                )),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                            child: Icon(
                              Icons.comment_outlined,
                              size: 22,
                              color: Colors.red[900],
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
                    backgroundImage: NetworkImage(widget.ownerImg),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 1),
                  Expanded(
                      child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: TextField(
                          style: TextStyle(height: 1),
                          controller: _text,
                          decoration: new InputDecoration(
                            fillColor: Colors.grey[300],
                            filled: true,
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(35),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            hintStyle: new TextStyle(color: Colors.grey[700]),
                            hintText: "Write a comment...",
                            contentPadding:
                                EdgeInsets.fromLTRB(14, 11.5, 0, 11.5),
                            isDense: true,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.red[900],
                          ),
                          onPressed: () {
                            _text.clear();
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
      ),
    );
  }
}
