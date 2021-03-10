import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'service_locator.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  //Overrides http.BaseClient with cache and default Headers
  // ignore: unused_label
  https: //web domin
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  await setupLocators();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://df2902652cc64e6193b706b3a1c66f79@o517861.ingest.sentry.io/5664844';
    },
    appRunner: () => runApp(
      Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
