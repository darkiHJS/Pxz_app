import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            SizedBox(height: 40,),
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
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                hintText: "请输入手机号码",
                                hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                                border: InputBorder.none),
                          )))
                ],
              ),
            ),
            SizedBox(height: 20,),
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
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 10),
                                hintText: "请输入验证码",
                                hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                                border: InputBorder.none),
                          ))),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      "获取验证码",
                      style: TextStyle(color: Colors.yellow),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 60,),
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
                    borderRadius: BorderRadius.circular(30)
                  ),
                  onPressed: () {},
                  color: Color(0xfff3d72f),
                  child: Text("登录", style: TextStyle(color: Colors.white))))
          ],
        ),
      ),
    );
  }
}
