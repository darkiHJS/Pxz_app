import 'package:flutter/material.dart';

class AdoptLicensePage extends StatefulWidget {
  AdoptLicensePage({Key key}) : super(key: key);

  @override
  _AdoptLicensePageState createState() => _AdoptLicensePageState();
}

class _AdoptLicensePageState extends State<AdoptLicensePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              brightness: Brightness.light,
              backgroundColor: Color(0xfff3d72f),
              elevation: 0.0,
              actions: [Container()],
            ),
            preferredSize: Size.fromHeight(0)),
        body: Column(
          children: <Widget>[
            Container(
              height: 180,
              child: Stack(
                fit: StackFit.expand,
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Positioned(
                      top: 0, left: 0, right: 0, child: BarkgroundWall()),
                  Positioned(
                      width: 300,
                      height: 140,
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "认证救助机构&个人",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  "assets/adopt/wechar.png",
                                  width: 40,
                                  height: 40,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                        text: TextSpan(
                                            text: "微信添加:",
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: <TextSpan>[
                                          TextSpan(
                                              text: "  Love-every-pet",
                                              style: TextStyle(
                                                  color: Color(0xff42b13a)))
                                        ])),
                                    Text(
                                      "(请备注：城市+救助组织名称)",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              child:
            ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return AdoptLicenseItem(); 

              },
            )
            )
          ],
        ),
      ),
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
        child: Container(color: Color(0xfff3d72f)),
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

class AdoptLicenseItem extends StatelessWidget {
  const AdoptLicenseItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    image: DecorationImage(
                      image: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591779038846&di=9d63fab81c0577ded41daa89c6d294e6&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2017%2F0306%2F8722F5CC66C667DB2FC904EDA20DCC3B6BF863A0_size50_w750_h503.jpeg"),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
                SizedBox(width: 8,),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("派小爪", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    Text("ID: 1234", style: TextStyle(fontSize: 12, color: Colors.black87)),
                    Text("上海 - 嘉定", style: TextStyle(fontSize: 12, color: Colors.black87))
                  ], 
                )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                          color:Color(0xfff3d72f),
                          borderRadius: BorderRadius.circular(4)
                        ),
                        margin: EdgeInsets.only(bottom: 8),
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        child: Text("关注"), 
                      )
                    ),
                    Text("12711", style: TextStyle(fontSize: 12, color: Colors.black45))
                  ],  
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591779038846&di=9d63fab81c0577ded41daa89c6d294e6&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2017%2F0306%2F8722F5CC66C667DB2FC904EDA20DCC3B6BF863A0_size50_w750_h503.jpeg"),
                      fit: BoxFit.cover,
                    )
                  )
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591779038846&di=9d63fab81c0577ded41daa89c6d294e6&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2017%2F0306%2F8722F5CC66C667DB2FC904EDA20DCC3B6BF863A0_size50_w750_h503.jpeg"),
                      fit: BoxFit.cover,
                    )
                  )
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591779038846&di=9d63fab81c0577ded41daa89c6d294e6&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2017%2F0306%2F8722F5CC66C667DB2FC904EDA20DCC3B6BF863A0_size50_w750_h503.jpeg"),
                      fit: BoxFit.cover,
                    )
                  )
                ),
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1591779038846&di=9d63fab81c0577ded41daa89c6d294e6&imgtype=0&src=http%3A%2F%2Fp0.ifengimg.com%2Fpmop%2F2017%2F0306%2F8722F5CC66C667DB2FC904EDA20DCC3B6BF863A0_size50_w750_h503.jpeg"),
                      fit: BoxFit.cover,
                    )
                  )
                )
              ],
            )
          ],
        ),
    );
  }
}