import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';
import 'package:path_provider/path_provider.dart';

class LoginPage extends StatefulWidget {
  

  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String userPhone = "";
  String captcha = "";
  bool isCaptction = false;
  int resetTime = 60;

  static bool isPhone(String input) {
    RegExp mobile = new RegExp(r"1[0-9]\d{9}$");
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/user/loginBG.jpg"),
                fit: BoxFit.fitWidth,
                colorFilter:
                    ColorFilter.mode(Colors.black45, BlendMode.darken))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/user/user-about-us-icons.png",
              width: 140,
              height: 140,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              width: 315,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.white))),
              child: Row(
                children: <Widget>[
                  Text(
                    "+86",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: TextField(
                            onChanged: (v) {
                              if(!isPhone(v)) return;
                              setState(() {
                                userPhone = v;
                              });
                            },
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            maxLength: 11,
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                hintText: "请输入手机号码",
                                hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                                border: InputBorder.none),
                          )))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 315,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Colors.white))),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: TextField(
                            onChanged: (d) {
                              setState(() {
                                captcha = d;
                              });
                            },
                            maxLength: 4,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                hintText: "请输入验证码",
                                hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                                border: InputBorder.none),
                          ))),
                  isPhone(userPhone) ?
                  GestureDetector(
                    onTap: () {
                      if (isCaptction) return; 
                      PxzRequest().post("/api/sms", data: {
                        "target": userPhone,
                        "template": "login"
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
                  ) : SizedBox.shrink()
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("注册登录代表同意",
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                Text("用户协议",
                    style: TextStyle(color: Colors.yellow, fontSize: 12)),
                Text("和", style: TextStyle(color: Colors.white, fontSize: 12)),
                Text("隐私政策",
                    style: TextStyle(color: Colors.yellow, fontSize: 12)),
              ],
            ),
            SizedBox(height: 5),
            SizedBox(
                width: 315,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () async{
                      print(userPhone);
                      print(captcha);
                      if(isPhone(userPhone) && isValidateCaptcha(captcha)) {
                        var data = await PxzRequest().post("/passport/login", data: {
                          "username": userPhone,
                          "vcode": captcha
                        });
                        if(data["status"] == "error") {
                          BotToast.showText(text: data["msg"]);
                          return;
                        }
                        Directory appDocDir = await getApplicationDocumentsDirectory();
                        String appDocPath = appDocDir.path;
                        var cj=PersistCookieJar(dir:appDocPath+"/.cookies/");
                        List<Cookie> cookies = cj.loadForRequest(Uri.parse("http://www.paixiaozhua.com"));
                        Navigator.of(context).popAndPushNamed("/");
                      }else {
                        BotToast.showText(text: "请填写正确的手机号和验证码");
                      }
                    },
                    color: Color(0xfff3d72f),
                    child: Text("登录", style: TextStyle(color: Colors.white))))
          ],      
        ),
      ),
    );
  }
}
