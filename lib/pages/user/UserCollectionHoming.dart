import 'package:flutter/material.dart';
import 'package:hello_world/pages/user/components/PetHomingItem.dart';

class UserCollectionHomingPage extends StatefulWidget {
  UserCollectionHomingPage({Key key}) : super(key: key);

  @override
  _UserCollectionHomingPageState createState() => _UserCollectionHomingPageState();
}

class _UserCollectionHomingPageState extends State<UserCollectionHomingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return PetHommingItem();
        }
      ),
    );
  }
}