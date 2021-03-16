import 'package:flutter/material.dart';
import 'package:sout/Screens/discover/comment.dart';
import 'package:sout/Screens/home/audio.dart';
import 'package:intl/intl.dart';
import 'package:sout/models/models.dart';

// ignore: must_be_immutable
class PostCard extends StatefulWidget {
  String postId;
  String ownerName;
  String ownerImg;
  String description;
  String img;
  String date;
  String audio;
  List likes;
  List comments;
  PostCard(
      {this.postId,
      this.ownerName,
      this.ownerImg,
      this.description,
      this.img,
      this.date,
      this.audio,
      this.likes,
      this.comments});
  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  // String _selectedItem = 'Bookmark';
  List _options = ['Bookmark', 'Report Post'];
  final _text = TextEditingController();

  CommentModel commentModel = new CommentModel();
  List<CommentModel> comments = [];

  LikeModel likeModel = LikeModel();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 29.0,
                    backgroundImage: NetworkImage(widget.ownerImg),
                    backgroundColor: Colors.transparent,
                  ),
                  SizedBox(width: 7),
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
                  Align(
                    alignment: Alignment.topRight,
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(5, 15, 0, 15),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.description,
                              style: TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                        Image.network(widget.img),
                        if (widget.audio == "")
                          Container()
                        else
                          Audio(url: widget.audio)
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
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 30, 8),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: IconButton(
                              icon: Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 22,
                                color: Colors.red[900],
                              ),
                              onPressed: () {
                                LikeModel newLike = LikeModel();
                                likeModel.addLike(widget.postId, newLike);
                                setState(() {
                                  widget.likes.add(newLike);
                                });
                              },
                            ),
                          ),
                          Text("Like", style: TextStyle(fontSize: 19)),
                          // if (widget.likes == 0)
                          //   SizedBox(
                          //     width: 5,
                          //   )
                          // else
                          Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Text(widget.likes.length.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))
                            ],
                          )
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
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: IconButton(
                            icon: Icon(
                              Icons.comment_outlined,
                              size: 22,
                              color: Colors.red[900],
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    elevation: 0,
                                    child: Container(
                                      height: 540.0,
                                      width: mediaQuery.size.width,
                                      child: ListView(
                                        children: <Widget>[
                                          SizedBox(height: 20),
                                          Center(
                                            child: Text(
                                              "Comments",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          for (var comment in widget.comments)
                                            Comment(
                                              date: DateFormat('yyyy-MM-dd')
                                                  .format(comment.date.toDate())
                                                  .toString(),
                                              desc: comment.description,
                                              ownerName: comment.writer['name'],
                                              ownerImg:
                                                  comment.writer['picURL'],
                                            )
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
                          CommentModel newComment = CommentModel();
                          newComment.description = _text.text.toString();
                          commentModel.addComment(widget.postId, newComment);
                          _text.clear();
                          setState(() {
                            // ignore: unused_element
                            widget.comments.add(newComment);
                          });
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
    );
  }
}
