import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';

class UserOpinionPage extends StatefulWidget {
  UserOpinionPage({Key key}) : super(key: key);

  @override
  _UserOpinionPageState createState() => _UserOpinionPageState();
}

class _UserOpinionPageState extends State<UserOpinionPage> {

  String content;

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
                  onChanged: (v) {
                    content = v;
                  },
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
                onPressed: () async {
                  try {
                    var data = await PxzRequest().post(
                        "/suggest/add",
                        data: {
                          "content": content,
                        }
                      );
                      if(data["code"] == 10000) {
                        BotToast.showText(text: "已反馈。谢谢");
                        Navigator.of(context).pop();
                      }else {
                        BotToast.showText(text: "出错了。${data['msg']}");
                      }
                  } on DioError catch (e) {
                    BotToast.showText(text: "出错了。${e.message}");
                  }
                },
                color: Color(0xfff3d72f),
                child: Text("提交", style: TextStyle(color: Colors.white)))
              )
            ],
          )),
    );
  }
}
