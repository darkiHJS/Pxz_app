import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/components/IconFont.dart';
import 'package:hello_world/pages/user/UserAdopt.dart';
import 'package:hello_world/pages/user/UserCertificate.dart';
import 'package:hello_world/pages/user/UserCollection.dart';
import 'package:hello_world/pages/user/UserEdit.dart';
import 'package:hello_world/pages/user/UserRelease.dart';

import 'UserClawHome.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170,
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Positioned(top: 0, left: 0, right: 0, child: BarkgroundWall()),
                Positioned(top: 80, left: 20, child: UserAvatar()),
                Positioned(
                    top: 10,
                    right: 10,
                    child: IconButton(
                        icon: Icon(
                          Icons.subject,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        }))
              ]),
            ),
            UserInfoCompnent(),
            FunctionBox()
          ],
        ));
  }
}

/// 背景墙
class BarkgroundWall extends StatelessWidget {
  const BarkgroundWall({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipPath(
        clipper: ButtomClipper(),
        child: CachedNetworkImage(
          imageUrl: "http://img.wmtp.com/file/tu/20191210/001k1blpvqx.jpg",
          imageBuilder: (context, imageProvider) => Container(
            height: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 顶部 贝塞尔曲线
class ButtomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 50.0);
    var firstCoutrolPoint = Offset(size.width / 2, size.height);
    var firstEdnPoint = Offset(size.width, size.height - 50.0);

    path.quadraticBezierTo(firstCoutrolPoint.dx, firstCoutrolPoint.dy,
        firstEdnPoint.dx, firstEdnPoint.dy);
    path.lineTo(size.width, size.height - 50.0);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}

/// 用户头像
class UserAvatar extends StatelessWidget {
  const UserAvatar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: CachedNetworkImage(
            imageUrl:
                "http://a1.att.hudong.com/05/00/01300000194285122188000535877.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

/// 用户信息
///
class UserInfoCompnent extends StatelessWidget {
  const UserInfoCompnent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "大大",
                    style: TextStyle(fontSize: 32),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Pid: pxw694332",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                  Text(
                    "噯崾莱崾収場，僦匴恠那蕞逺の哋方；涐想，這僦媞涐蕞媄の遺莣。",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(IconFont.man, size: 14, color: Colors.blue),
                      Text(
                        "18岁",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "上海",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      MaterialButton(
                          onPressed: () {},
                          minWidth: 0,
                          height: 0,
                          padding: EdgeInsets.only(right: 10),
                          child: Text("0 获赞")),
                      MaterialButton(
                          onPressed: () {},
                          minWidth: 0,
                          height: 0,
                          padding: EdgeInsets.only(right: 10),
                          child: Text("0 关注")),
                      MaterialButton(
                          onPressed: () {},
                          minWidth: 0,
                          height: 0,
                          padding: EdgeInsets.only(right: 10),
                          child: Text("19999999 粉丝")),
                    ],
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => UserEditPage()));
                  },
                  color: Color(0xfff3d72f),
                  child: Text("编辑信息"),
                ))
          ],
        ),
      ),
    );
  }
}

/// 功能箱
///
class FunctionBox extends StatelessWidget {
  const FunctionBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 20),
            child: Text(
              "功能箱",
              style: TextStyle(fontSize: 24),
            ),
          ),
          Container(
              height: 200,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserReleasePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(5, 5, 10, 0),
                          child: Image.asset("assets/user/user-fn-fb.png"),
                        ),
                        Text(
                          "我的发布",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserCollectionPage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Image.asset("assets/user/user-fn-collect.png"),
                        ),
                        Text(
                          "我的收藏",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserClawHomePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Image.asset("assets/user/user-fn-whome.png"),
                        ),
                        Text(
                          "我的爪窝",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserAdoptPage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Image.asset("assets/user/user-fn-ly.png"),
                        ),
                        Text(
                          "我的领养",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserCertificatePage()));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 60,
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Image.asset("assets/user/user-fn-rz.png"),
                        ),
                        Text(
                          "我的认证",
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
