import 'package:flutter/material.dart';
import 'package:sout/Screens/discover/postCard.dart';
import 'package:sout/models/models.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TalentTab extends StatefulWidget {
  final String talentId;
  TalentTab(this.talentId);
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

  getPostLikes(PostModel post) {
    likeModel.getPostLikes(post.id).then((value) {
      likes = value;
    });

    print("hhhhhhhhhhh " + likes.length.toString());

    return likes;
  }

  // getPostComments(PostModel post) {
  //   commentModel.getPostComments(post.id).then((value) => comments = value);
  //   print("hhhhhhhhhhh " + comments.length.toString());
  //   setState(() {});
  //   return comments.length;
  // }

  getPostAllComments(PostModel post) {
    commentModel.getPostComments(post.id).then((value) => comments = value);
    print("hhhhhhhhhhh " + comments.length.toString());
    setState(() {});
    return comments;
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
              likes: getPostLikes(post),
              comments: getPostAllComments(post),
            ),
        ],
      ),
    );
  }
}
