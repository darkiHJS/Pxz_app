import 'package:flutter/material.dart';

class ConcernItem extends StatefulWidget {
  ConcernItem({Key key}) : super(key: key);

  @override
  _ConcernItemState createState() => _ConcernItemState();
}

class _ConcernItemState extends State<ConcernItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 70.0,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 5.0, color: Color(0xffebebeb))
                ),
                color: Colors.white
              ),
              child: Text('header')
            ),
            Container(
              width: double.infinity,
              height: 225.0,
              color: Colors.black, 
            ),
            Container(
              width: double.infinity,
              height: 75.0,
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Text("主人与猫咪之间的小游戏！猫：零食是逃不过我的眼睛的~")
                ],
              ),
            )
          ],
        ),
    );
  }
}