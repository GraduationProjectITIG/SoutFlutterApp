import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sout/Screens/drawer.dart';
import 'package:sout/blocs/blocs.dart';
import 'package:sout/utils/scroll_physics_like_ios.dart';
import '../../service_locator.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List list = [];
  AppBar appBar = AppBar(
    title: Text(
      'Notifications',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Color(0xff292b2c),
  );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("Users")
            .doc(sL<UserBloc>().user.id)
            .collection('notifications')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            for (var item in snapshot.data.docs) {
              if (item['seen'] == false)
                list.add(ListTile(
                  leading: Container(
                    child: item['maker']['picURL'] != null &&
                            item['maker']['picURL'].toString() !=
                                "./../../../../assets/avatar.png" &&
                            item['maker']['picURL'].toString() !=
                                "./../../../../assets/avatar2.png"
                        ? Image.network(
                            item['maker']['picURL'].toString(),
                          )
                        : item['maker']['picURL'].toString() !=
                                "./../../../../assets/avatar2.png"
                            ? Image.asset(
                                "assets/images/avatar.png",
                              )
                            : Image.asset(
                                "assets/images/avatar2.png",
                              ),
                  ),
                  title: Column(
                    children: [
                      Text(
                        item['description'].toString(),
                      ),
                      Text(
                        DateTime.parse(item['date'].toString())
                            .toLocal()
                            .toString(),
                      )
                    ],
                  ),
                  onTap: () {
                    _firestore
                        .collection("Users")
                        .doc(sL<UserBloc>().user.id)
                        .collection('notifications')
                        .doc(item.id)
                        .update({"seen": true});
                  },
                ));
            }
          }
          return Scaffold(
            drawer: buildDrawer(context),
            appBar: this.appBar,
            body: Container(
              width: mediaQuery.size.width,
              height: mediaQuery.size.height -
                  (mediaQuery.padding.top + appBar.toolbarHeight),
              child: snapshot.data != null
                  ? ListView.builder(
                      physics: iosScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return list[index];
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        });
  }
}
