import 'package:flutter/material.dart';
// import 'package:hello_world/pages/user/Login.dart';
import './components/TabBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (BuildContext context) => LoginPage()));
    return Container(
      width: double.infinity,
      child: HomeTabBar()
    );
  }
}

