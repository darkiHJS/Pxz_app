import 'package:flutter/material.dart';

class UserOpinionPage extends StatefulWidget {
  UserOpinionPage({Key key}) : super(key: key);

  @override
  _UserOpinionPageState createState() => _UserOpinionPageState();
}

class _UserOpinionPageState extends State<UserOpinionPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            title: Text("意见反馈"),
          ),
          backgroundColor: Color(0xffededed),
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(30),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 200,
                color: Colors.white,
                child: TextField(
                  maxLength: 8,
                  decoration: InputDecoration(
                    hintText: "请输入你的反馈意见",
                    hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                    border: InputBorder.none,
                    counterText: ""
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: FlatButton(
                onPressed: () {},
                color: Color(0xfff3d72f),
                child: Text("提交", style: TextStyle(color: Colors.white)))
              )
            ],
          )),
    );
  }
}
