import 'package:flutter/material.dart';
import './components/TabBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: HomeTabBar()
    );
  }
}

