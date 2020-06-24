import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/UserState.dart';
import 'package:provider/provider.dart';
import './pages/HomeNavigation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return 
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserState()),
        ],
        child: MaterialApp(
        title: '派小爪',
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xfff3d72f),
          primarySwatch: Colors.yellow
        ),
        localizationsDelegates: [
          //此处
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [const Locale("zh", "CH"), const Locale("en", "US")],
        home: Navigation()));
  }
}
