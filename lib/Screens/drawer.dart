import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sout/Screens/bookmarks/bookmarks.dart';
import 'package:sout/Screens/discover/discover.dart';
import 'package:sout/Screens/screens.dart';
import 'package:sout/app/app_bloc.dart';
import 'package:sout/app/app_localizations.dart';
import 'package:sout/blocs/blocs.dart';
import 'package:sout/models/models.dart';

import '../service_locator.dart';

Drawer buildDrawer(BuildContext context, {@required UserModel user}) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text(user.firstName != null
              ? user.firstName + " " + user.lastName
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
          title: Text(AppLocalizations.of(context).translate('home')),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Home(user: user)));
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.bell,
            size: 32,
          ),
          title: Text(AppLocalizations.of(context).translate('notifications')),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Notifications(user: user)));
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.hashtag,
            size: 32,
          ),
          title: Text(AppLocalizations.of(context).translate('discover')),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Discover(user: user)));
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.language,
            size: 32,
          ),
          title: Text(AppLocalizations.of(context).translate('language')),
          onTap: () {
            print(AppLocalizations.of(context).locale.toString());
            if (AppLocalizations.of(context).locale.toLanguageTag() == "ar")
              sL<AppBloc>().setLanguage(LANGUAGES.EN);
            if (AppLocalizations.of(context).locale.toLanguageTag() == "en")
              sL<AppBloc>().setLanguage(LANGUAGES.AR);
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.bookmark,
            size: 32,
          ),
          title: Text(AppLocalizations.of(context).translate('bookmarks')),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Bookmarks(
                          logedUser: user,
                        )));
          },
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.doorOpen,
            size: 32,
          ),
          title: Text(AppLocalizations.of(context).translate('logout')),
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Bookmarks(
                          logedUser: user,
                        )),
                (Route<dynamic> route) => false);
          },
        ),
      ],
    ),
  );
}
