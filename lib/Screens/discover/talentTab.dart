import 'package:flutter/material.dart';
import 'package:sout/Screens/discover/postCard.dart';
import 'package:sout/models/models.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TalentTab extends StatefulWidget {
  final String talentId;
  final UserModel user;
  TalentTab(this.talentId,this.user);
  @override
  _TalentTabState createState() => _TalentTabState();
}

class _TalentTabState extends State<TalentTab> {
  PostModel postModel = new PostModel();
  List<PostModel> posts = [];

  LikeModel likeModel = new LikeModel();
  List<LikeModel> likes = [];
  List<LikeModel> likesList = [];

  CommentModel commentModel = new CommentModel();
  List<CommentModel> comments = [];

  @override
  void initState() {
    super.initState();
    getPostsbyTalent(widget.talentId);
    // setState(() {});
  }

  getPostsbyTalent(id) async {
    posts = await postModel.getPostsbyTalent(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          for (var post in posts)
            PostCard(
              postId: post.id,
              ownerName: post.owner["name"],
              ownerImg: post.owner["picURL"],
              img: post.image,
              description: post.description,
              date: DateFormat('yyyy-MM-dd')
                  .format(post.date.toDate())
                  .toString(),
              audio: post.audio,
              user:widget.user
            ),
        ],
      ),
    );
  }
}
