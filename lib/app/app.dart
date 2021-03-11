import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../utils/utils.dart';
import '../Routes.dart';
import '../service_locator.dart';
import 'app_bloc.dart';
import 'app_localizations.dart';
// import '../blocs/blocs.dart';

//trying chat model
import '../models/chat.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    sL<AppBloc>().dispose();
    super.dispose();
  }

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    // _firebaseMessaging.subscribeToTopic("all");
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     try {
    //       print(message['notification']['title'].toString());
    //     } catch (e) {
    //       print(e);
    //     }
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(
    //         sound: true, badge: true, alert: true, provisional: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });
    // _firebaseMessaging.getToken().then((String token) {
    //   assert(token != null);
    //
    //   setState(() {
    //     if(sL<UserBloc>().isLogin()){
    //       sL<UserBloc>().updateFCMToken(token);
    //     }
    //   });
    // });
    // setState(() {});

    super.initState();
    // ChatModel myChat;
    // myChat.getChats();
    print("I am ok");
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppState>(
        stream: sL<AppBloc>().stream,
        initialData: AppBloc.initialState,
        builder: (BuildContext context, AsyncSnapshot<AppState> snapshot) {
          return MaterialApp(
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              // A class which loads the translations from JSON files
              AppLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales:
                Constants.SUPPORTED_LOCALE.map((String s) => Locale(s)),
            localeResolutionCallback:
                (Locale locale, Iterable<Locale> supportedLocales) {
              for (final Locale supportedLocale in supportedLocales) {
                if (supportedLocale?.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            locale: snapshot.data.locale,
            debugShowCheckedModeBanner: false,
            theme: snapshot.data.themeData,
            initialRoute: PageRouteName.INITIAL,
            onGenerateRoute: Routes.generateRoute,
          );
        });
  }
}
