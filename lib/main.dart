import 'package:flutter/material.dart';
import './pages/HomeNavigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(243, 215, 44, 1)
        ),
        home: Navigation()
    );
  }
}

