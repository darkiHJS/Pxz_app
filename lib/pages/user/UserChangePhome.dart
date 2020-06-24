import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';

import 'UserChangePhome2.dart';

class UserChangePhomePage extends StatefulWidget {
  final String myOldPhone;

  UserChangePhomePage({Key key, this.myOldPhone}) : super(key: key);

  @override
  _UserChangePhomePageState createState() => _UserChangePhomePageState();
}

class _UserChangePhomePageState extends State<UserChangePhomePage> {
  String captcha = "";
  bool isCaptction = false;
  int resetTime = 60;

  static bool isValidateCaptcha(String input) {
    RegExp mobile = new RegExp(r"\d{4}$");
    return mobile.hasMatch(input);
  }

  void countdown() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        resetTime--;
      });
      if (resetTime <= 0) {
        setState(() {
          resetTime = 60;
          isCaptction = false;
        });
      } else {
        countdown();
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("修改手机号")),
      backgroundColor: Color(0xffededed),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              padding: EdgeInsets.fromLTRB(10, 0, 30, 0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 80,
                      child: Text("原手机号",
                          style: TextStyle(color: Color(0xff606060)))),
                  Expanded(
                    child: Text(
                      widget.myOldPhone == null ? "获取手机号出错，请退出重试" : widget.myOldPhone.replaceFirst(new RegExp(r'\d{4}'), '****', 3),
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 80,
                      child: Text("验证码",
                          style: TextStyle(color: Color(0xff606060)))),
                  Expanded(
                    child: TextField(
                      onChanged: (v) {
                        if(isValidateCaptcha(v)) {
                          setState(() {
                            captcha = v;
                          });
                        }
                      },
                      maxLength: 4,
                      decoration: null,
                    ),
                  ),
                   GestureDetector(
                    onTap: () {
                      if (isCaptction) return; 
                      PxzRequest().post("/api/sms", data: {
                        "target": widget.myOldPhone,
                        "template": "cmobile"
                      }).then((d) {
                        print(d);
                      });
                      setState(() {
                        isCaptction = true;
                      });
                      countdown();
                    },
                    child: Text(
                      isCaptction ? "请${resetTime}s后再试" : "获取验证码",
                      style: TextStyle(color: Colors.yellow),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("如果原手机号无法接受短信，请联系客服。"),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: FlatButton(
                  onPressed: () async {
                    try {
                      var data = await PxzRequest().post(
                        "/member/l_check",
                        data: {
                          "mobile": widget.myOldPhone,
                          "vcode": captcha
                        }
                      );
                      if(data["code"] == 10000) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => UserChangePhomePage2(myOldPhone: widget.myOldPhone,)
                        ));
                      }else {
                        BotToast.showText(text: "出错了。${data['msg']}");
                      }
                    } on DioError catch (e) {
                      BotToast.showText(text: "出错了。${e.message}");
                    }
                    
                  },
                  color: Color(0xfff3d72f),
                  child: Text("下一步", style: TextStyle(color: Colors.white))),
            )
          ],
        ),
      ),
    ));
  }
}
