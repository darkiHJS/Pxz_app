import 'package:flutter/material.dart';
import 'package:hello_world/pages/user/components/PetHomingItem.dart';

class IssueAssociationPetPage extends StatefulWidget {
  IssueAssociationPetPage({Key key}) : super(key: key);

  @override
  _IssueAssociationPetPageState createState() => _IssueAssociationPetPageState();
}

class _IssueAssociationPetPageState extends State<IssueAssociationPetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("关联送养"),),
      body:  Container(
      height: double.infinity,
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return PetHommingItem();
        }
      ),
    )
    );
  }
}