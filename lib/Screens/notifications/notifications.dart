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
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection("Users")
            .doc(sL<UserBloc>().user.id)
            .collection('notifications')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            for (var item in snapshot.data.docs) {
              //TODO continue
              list.add(ListTile());
            }
          }
          return Scaffold(
            drawer: buildDrawer(context),
                      body: Container(
              child: ListView.builder(
                  physics: iosScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return list[index];
                  }),
            ),
          );
        });
  }
}
