import 'package:flutter/material.dart';

import 'components/PetHomingItem.dart';

class UserAdoptPage extends StatefulWidget {
  UserAdoptPage({Key key}) : super(key: key);

  @override
  _UserAdoptPageState createState() => _UserAdoptPageState();
}

class _UserAdoptPageState extends State<UserAdoptPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的领养"),),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return PetHommingItem();
        }
      ),
    );
  }
}