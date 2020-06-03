import 'package:flutter/material.dart';

class UserEditPage extends StatefulWidget {
  UserEditPage({Key key}) : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("编辑资料"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 30),
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 0,
                    child: Column(children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://a1.att.hudong.com/05/00/01300000194285122188000535877.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.grey, BlendMode.darken)),
                        ),
                        child: Icon(
                          Icons.crop_free,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Text("点击修改头像", style: TextStyle(fontSize: 18),)
                      ]
                    ),
                  )
                ),
                Divider(color: Colors.grey,)
            ],
          ),
        ),
      ),
    );
  }
}
