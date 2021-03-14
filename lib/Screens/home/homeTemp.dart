// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sout/Screens/drawer.dart';
// import 'package:sout/Screens/home/postCard.dart';
// import 'package:sout/blocs/blocs.dart';
// import 'package:sout/utils/scroll_physics_like_ios.dart';
// import '../../service_locator.dart';

// class Home extends StatefulWidget {
//   Home({Key key}) : super(key: key);

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List postslist = [];
//   AppBar appBar = AppBar(
//     title: Text(
//       'Home',
//       style: TextStyle(
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//     ),
//     backgroundColor: Color(0xff292b2c),
//   );

//   @override
//   Widget build(BuildContext context) {
//     //final mediaQuery = MediaQuery.of(context);
//     return StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection("post")
//             // .doc(sL<UserBloc>().user.id)
//             // .collection('notifications')
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.data != null) {
//             for (var item in snapshot.data.docs) {
//               String img = '';
//               try {
//                 img = item['image'].toString();
//               } on Exception catch (exception) {
//                 img = '';
//               } catch (error) {
//                 img = '';
//               }
//               postslist.add(PostCard(
//                 ownerImg: item['owner']['picURL'].toString(),
//                 ownerName: item['owner']['name'].toString(),
//                 img: img,
//                 date: item['date'].toString(),
//                 description: item['description'].toString(),
//               ));
//             }
//           }
//           return Scaffold(
//             drawer: buildDrawer(context),
//             appBar: this.appBar,
//             body: Container(
//               // width: mediaQuery.size.width,
//               // height: mediaQuery.size.height -
//               //     (mediaQuery.padding.top + appBar.toolbarHeight),
//               child: snapshot.data != null
//                   ? ListView.builder(
//                       physics: iosScrollPhysics(),
//                       itemCount: postslist.length,
//                       itemBuilder: (context, index) {
//                         return postslist[index];
//                       })
//                   : Center(
//                       child: CircularProgressIndicator(),
//                     ),
//             ),
//           );
//         });
//   }
// }
