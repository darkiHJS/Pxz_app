import 'package:flutter/material.dart';
import './components/ConcernItem.dart';

class ConcernPage extends StatefulWidget {
  ConcernPage({Key key}) : super(key: key);

  @override
  _ConcernPageState createState() => _ConcernPageState();
}

class _ConcernPageState extends State<ConcernPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 100,
            itemBuilder: (BuildContext context, int index) {
            return ConcernItem();
           },
          ),
        );
  }
}

