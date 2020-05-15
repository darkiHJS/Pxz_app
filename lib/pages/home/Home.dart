import 'package:flutter/material.dart';
import './components/TabBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 28.0, color: Color.fromRGBO(243, 215, 44, 1))
        )
      ),
      alignment: Alignment.topLeft,
      child: HomeTabBar()
    );
  }
}

