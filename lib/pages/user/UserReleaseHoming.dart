import 'package:flutter/material.dart';
import 'package:hello_world/pages/user/components/PetHomingItem.dart';

class UserReleaseHomingPage extends StatefulWidget {
  UserReleaseHomingPage({Key key}) : super(key: key);

  @override
  _UserReleaseHomingPageState createState() => _UserReleaseHomingPageState();
}

class _UserReleaseHomingPageState extends State<UserReleaseHomingPage> {
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