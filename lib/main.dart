import 'dart:io';

import 'package:flutter/material.dart';
import './pages/HomeNavigation.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(MyApp());
  if(Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(243, 215, 44, 1)
        ),
        home: Navigation()
    );
  }
}

