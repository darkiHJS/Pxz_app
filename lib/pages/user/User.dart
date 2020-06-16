import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/components/IconFont.dart';
import 'package:hello_world/pages/user/UserAdopt.dart';
import 'package:hello_world/pages/user/UserCertificate.dart';
import 'package:hello_world/pages/user/UserCollection.dart';
import 'package:hello_world/pages/user/UserEdit.dart';
import 'package:hello_world/pages/user/UserRelease.dart';
import 'package:hello_world/utils/Request.dart';

import 'UserClawHome.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserInfo _userInfo ;
  @override
  void initState() {
    PxzRequest().get("/member/index").then((d){
      setState(() {
        print(d);
        _userInfo = UserInfo.fromJson(d["data"]);
        print(_userInfo.avatar);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return 
      _userInfo == null ?
      Container() : 
      Container(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170,
              child: Stack(fit: StackFit.expand, children: <Widget>[
                Positioned(top: 0, left: 0, right: 0, child: BarkgroundWall()),
                Positioned(top: 80, left: 20, child: UserAvatar(avatar: _userInfo.avatar,)),
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
  final String avatar;
  const UserAvatar({Key key, this.avatar}) : super(key: key);
  
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
              avatar,
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
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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

class UserInfo {
  String id;
  String idNumber;
  String avatar;
  String username;
  String nickname;
  String sex;
  String birthday;
  String motto;
  String followCount;
  String fansCount;
  String likeCount;
  String memberMark;

  UserInfo(
      {this.id,
      this.idNumber,
      this.avatar,
      this.username,
      this.nickname,
      this.sex,
      this.birthday,
      this.motto,
      this.followCount,
      this.fansCount,
      this.likeCount,
      this.memberMark});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idNumber = json['id_number'];
    avatar = json['avatar'];
    username = json['username'];
    nickname = json['nickname'];
    sex = json['sex'];
    birthday = json['birthday'];
    motto = json['motto'];
    followCount = json['follow_count'];
    fansCount = json['fans_count'];
    likeCount = json['like_count'];
    memberMark = json['member_mark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_number'] = this.idNumber;
    data['avatar'] = this.avatar;
    data['username'] = this.username;
    data['nickname'] = this.nickname;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['motto'] = this.motto;
    data['follow_count'] = this.followCount;
    data['fans_count'] = this.fansCount;
    data['like_count'] = this.likeCount;
    data['member_mark'] = this.memberMark;
    return data;
  }
}