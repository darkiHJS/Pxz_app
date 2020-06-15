import 'package:flutter/material.dart';
import 'package:hello_world/pages/user/Login.dart';
import 'package:hello_world/pages/user/UserAboutUs.dart';
import 'package:hello_world/pages/user/UserOpinion.dart';
import 'package:hello_world/pages/user/UserSafety.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
            child: Text(
              "更多",
              style: TextStyle(fontSize: 30),
            ),
          ),
          ListTile(
            leading: Image.asset(
              "assets/user/user-dw-order.png",
              width: 30,
              height: 30,
            ),
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  "我的订单(未开放)",
                  style: TextStyle(color: Colors.grey),
                )),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              "assets/user/user-dw-aq.png",
              width: 30,
              height: 30,
            ),
            title: Row(
              children: <Widget>[
                Expanded(child: Text("账号与安全")),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => UserSafetyPage()));
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/user/user-dw-position.png",
              width: 30,
              height: 30,
            ),
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  "地址管理(未开放)",
                  style: TextStyle(color: Colors.grey),
                )),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Image.asset(
              "assets/user/user-dw-opinion.png",
              width: 30,
              height: 30,
            ),
            title: Row(
              children: <Widget>[
                Expanded(child: Text("意见反馈")),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => UserOpinionPage()
              ));
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/user/user-dw-about.png",
              width: 30,
              height: 30,
            ),
            title: Row(
              children: <Widget>[
                Expanded(child: Text("关于我们")),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => UserAboutUsPage()
              ));
            },
          ),
          ListTile(
            leading: Image.asset(
              "assets/user/user-dw-logout.png",
              width: 30,
              height: 30,
            ),
            title: Row(
              children: <Widget>[
                Expanded(child: Text("退出登录")),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()));
            },
          )
        ],
      ),
    );
  }
}
