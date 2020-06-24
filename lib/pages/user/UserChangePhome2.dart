import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';

class UserChangePhomePage2 extends StatefulWidget {
  final String myOldPhone;
  UserChangePhomePage2({Key key, this.myOldPhone}) : super(key: key);

  @override
  _UserChangePhomePageState createState() => _UserChangePhomePageState();
}

class _UserChangePhomePageState extends State<UserChangePhomePage2> {
  String myNewPhone = "";
  String captcha = "";
  bool isCaptction = false;
  int resetTime = 60;

  @override
  void initState() {
    super.initState();
  }

  static bool isPhone(String input) {
    RegExp mobile = new RegExp(r"1[0-9]\d{9}$");
    print(mobile.hasMatch(input));
    return mobile.hasMatch(input);
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("填写新手机")),
        backgroundColor: Color(0xffededed),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                          width: 80,
                          child: Text("新手机号",
                              style: TextStyle(color: Color(0xff606060)))),
                      Expanded(
                        child: TextField(
                          maxLength: 11,
                          onChanged: (v) {
                            myNewPhone = v;
                          },
                          decoration: null,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                          width: 80,
                          child: Text("验证码",
                              style: TextStyle(color: Color(0xff606060)))),
                      Expanded(
                        child: TextField(
                          maxLength: 4,
                          onChanged: (v) {
                            if (isValidateCaptcha(v)) {
                              setState(() {
                                captcha = v;
                              });
                            }
                          },
                          decoration: null,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!isPhone(myNewPhone)) {
                            BotToast.showText(text: "请输入正确的手机号");
                            return;
                          }
                          if (isCaptction) return;
                          PxzRequest().post("/api/sms", data: {
                            "target": myNewPhone,
                            "template": "umobile"
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
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: FlatButton(
                      onPressed: () async {
                        try {
                          var data = await PxzRequest().post("/member/r_iphone",
                              data: {"mobile": widget.myOldPhone, "new_mobile": myNewPhone, "vcode": captcha});
                          if (data["code"] == 10000) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    UserChangePhomePage2()));
                          } else {
                            BotToast.showText(text: "出错了。${data['msg']}");
                          }
                        } on DioError catch (e) {
                          BotToast.showText(text: "出错了。${e.message}");
                        }
                      },
                      color: Color(0xfff3d72f),
                      child:
                          Text("修改手机", style: TextStyle(color: Colors.white))),
                )
              ],
            ),
          ),
        ));
  }
}
