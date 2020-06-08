import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserClawHomePage extends StatefulWidget {
  UserClawHomePage({Key key}) : super(key: key);

  @override
  _UserClawHomePageState createState() => _UserClawHomePageState();
}

class _UserClawHomePageState extends State<UserClawHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的爪窝"),
      ),
      body: Column(children: <Widget>[
        SizedBox(
            height: 170,
            child: Stack(
              fit: StackFit.expand,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(top: 0, left: 0, right: 0, child: BarkgroundWall()),
                Positioned(
                  top: 45,
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: CachedNetworkImage(
                      imageUrl:
                          "http://a1.att.hudong.com/05/00/01300000194285122188000535877.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ))
      ]),
    );
  }
}

/// 背景墙
class BarkgroundWall extends StatelessWidget {
  const BarkgroundWall({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      child: ClipPath(
        clipper: ButtomClipper(),
        child: Container(
          color: Color(0xfff3d72f),
          child: Center(
            child: Image.asset(
              "assets/user/user-clowhome-avatar.png",
              width: 80,
              height: 80,
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
