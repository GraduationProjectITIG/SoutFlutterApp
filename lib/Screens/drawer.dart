import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sout/blocs/blocs.dart';

import '../service_locator.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text(sL<UserBloc>().user.firstName != null
              ? sL<UserBloc>().user.firstName +
                  " " +
                  sL<UserBloc>().user.lastName
              : ""),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.home,
            size: 32,
          ),
          title: Text('Home'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.bell,
            size: 32,
          ),
          title: Text('Notifications'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.envelope,
            size: 32,
          ),
          title: Text('Messages'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.music,
            size: 32,
          ),
          title: Text('Talents'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.hashtag,
            size: 32,
          ),
          title: Text('Discover'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.cog,
            size: 32,
          ),
          title: Text('Settings'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.bookmark,
            size: 32,
          ),
          title: Text('Bookmarks'),
          onTap: () {},
        ),
      ],
    ),
  );
}
