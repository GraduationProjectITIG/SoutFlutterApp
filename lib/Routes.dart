import 'package:flutter/material.dart';

import 'Screens/screens.dart';
import 'utils/page_route_name.dart';

import './utils/utils.dart';
// import 'screens/screens.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PageRouteName.INITIAL:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Home(), settings: settings);
        break;
      // case PageRouteName.INITIAL:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Splash(), settings: settings);
      //   break;
      // case PageRouteName.INTRO:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Intro(), settings: settings);
      //   break;
      case PageRouteName.LOGIN:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Login(), settings: settings);
        break;
      // case PageRouteName.REGISTER:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Register(), settings: settings);
      //   break;
      // case PageRouteName.FORGET_PASSWORD:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => ForgetPassword(), settings: settings);
      //   break;
      // case PageRouteName.CODE:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Code(), settings: settings);
      //   break;
      // case PageRouteName.HOME:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => MainScreen(), settings: settings);
      //   break;
      // case PageRouteName.ABOUT_APP:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => AboutApp(), settings: settings);
      //   break;
      // case PageRouteName.CONTACT_US:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => ContactUs(), settings: settings);
      //   break;
      // case PageRouteName.POLICIES:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Polices(), settings: settings);
      //   break;
      // case PageRouteName.SEARCH:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Search(), settings: settings);
      //   break;
      // case PageRouteName.ADD_STORE:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => AddStore(), settings: settings);
      //   break;
      // case PageRouteName.CATEGORY:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Category(), settings: settings);
      //   break;
      // case PageRouteName.FAVORITE:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Favorites(), settings: settings);
      //   break;
      // case PageRouteName.STORE:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Store(), settings: settings);
      //   break;
      // case PageRouteName.FILTER:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Filter(), settings: settings);
      //   break;
      // case PageRouteName.PROFILE:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => Profile(), settings: settings);
      //   break;
      // case PageRouteName.CHANGEPASSWORD:
      //   return MaterialPageRoute<dynamic>(
      //       builder: (_) => ChangePassword(), settings: settings);
      //   break;
      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Login(), settings: settings);
    }
  }
}
