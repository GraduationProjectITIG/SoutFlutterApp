import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Comment extends StatefulWidget {
  String ownerImg, ownerName, desc, date;
  Comment({this.ownerImg, this.ownerName, this.desc, this.date});
  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 18),
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 24.0,
                backgroundImage: NetworkImage(widget.ownerImg),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(width: 9),
              Container(
                width: 200.0,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Text(
                          widget.ownerName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          widget.date,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 7),
                        Text(widget.desc, style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              // Spacer(),
            ],
          ),
          SizedBox(height: 2),
        ],
      ),
    );
  }
}
