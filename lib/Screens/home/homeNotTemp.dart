import 'package:flutter/material.dart';
import 'package:sout/blocs/blocs.dart';
import 'package:sout/models/comment.dart';
import 'package:sout/models/like.dart';
import 'package:sout/models/models.dart';
import 'package:intl/intl.dart';
import '../../service_locator.dart';
import '../drawer.dart';
import 'addPost.dart';
import 'postCard.dart';

class Home extends StatefulWidget {
  UserModel user;
  Home({this.user});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
    print("in init state");
    getAllPosts();
    // print('User ${sL<UserBloc>().userL.id}');
    // setState(() {});
  }

  getAllPosts() async {
    posts = await postModel.getAllPosts();
    setState(() {});
  }

  // getPostLikes(PostModel post) {
  //   likeModel.getPostLikes(post.id).then((value) => likes = value);
  //   // likes = foo(post.id);
  //   print("hhhhhhlikes" + likes.length.toString());
  //   //setState(() {});
  //   return likes;
  // }

  // foo(x) async {
  //   dynamic temp = await likeModel.getPostLikes(x);
  //   return temp;
  // }

  // getPostComments(PostModel post) {
  //   commentModel.getPostComments(post.id).then((value) => comments = value);
  //   print("hhhhhhhhhhh " + comments.length.toString());
  //   setState(() {});
  //   return comments.length;
  // }

  // getPostAllComments(PostModel post) {
  //   print("before waiting");
  //   commentModel.getPostComments(post.id).then((value) => comments = value);
  //   print("hhhhhhhhcomments " + comments.length.toString());
  //   //setState(() {});
  //   return comments;
  // }

  AppBar appBar = AppBar(
    title: Text(
      'Home',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Color(0xff292b2c),
  );

  @override
  Widget build(BuildContext context) {
    UserModel uss = this.widget.user;
    return Scaffold(
      drawer: buildDrawer(context,user:uss),
      appBar: this.appBar,
      body: Container(
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
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(
          Icons.settings_voice_sharp,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(
                new MaterialPageRoute(builder: (_) => new AddPost()),
              )
              .then((val) => val ? getAllPosts() : null);
        },
      ),
    );
  }
}
