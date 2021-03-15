// import 'package:flutter/material.dart';
// // import '../models/post.dart';
// // import 'postDetails.dart';
// // import 'package:slimy_card/slimy_card.dart';

// class MyCard extends StatefulWidget {
//   // String imgLink;
//   Posts text;
//   MyCard({this.text});
//   @override
//   _MyCardState createState() => _MyCardState();
// }

// class _MyCardState extends State<MyCard> {
//    myWidget01(){
//      return Text(
//                 widget.text.title,
//                 style: TextStyle(color: Colors.white, fontSize: 16,),
//               );
//    }
//    myWidget02(){
//      return Text(
//                 "Fatma Elwasify",
//                 style: TextStyle(color: Colors.white, fontSize: 20,),
//               );
//    }
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child:new InkWell(
//     onTap: () {
//       Navigator.push(context,
//         MaterialPageRoute(builder: (context) =>PostDetails(body:widget.text.body)),
//         );
//     },
//     child: Container(
//       padding: const EdgeInsets.all(8.0),
//       child: ListView(
//         children: <Widget>[
//           SlimyCard(
//             color: Colors.pink,
//             width: 200,
//             topCardHeight: 400,
//             bottomCardHeight: 200,
//             borderRadius: 15,
//             topCardWidget: myWidget01(),
//             bottomCardWidget: myWidget02(),
//             slimeEnabled: true,
//           ),
//         ],
//       ),

//     ),
//   ),
//   );

//   }
// }
