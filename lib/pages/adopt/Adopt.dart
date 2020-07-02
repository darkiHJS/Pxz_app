import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/components/IconFont.dart';
import 'package:hello_world/pages/adopt/AdoptBlackList.dart';
import 'package:hello_world/pages/adopt/AdoptCertification.dart';
import 'package:hello_world/pages/adopt/AdoptLicense.dart';
import 'package:hello_world/pages/adopt/AdoptLingYangForm.dart';
import 'package:hello_world/pages/adopt/AdoptNotice.dart';
import 'package:hello_world/pages/adopt/AdoptPet.dart';
import 'package:hello_world/pages/adopt/AdoptSongYangForm.dart';
import 'package:hello_world/pages/user/components/PetHomingItem.dart';
import 'package:hello_world/utils/Request.dart';

class AdoptPage extends StatefulWidget {
  AdoptPage({Key key}) : super(key: key);

  @override
  _AdoptPageState createState() => _AdoptPageState();
}

class _AdoptPageState extends State<AdoptPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  void _showDialog() async {
    await  Future.delayed(Duration(microseconds: 50));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: AdoptNoticePage(),
          actions: <Widget>[
            new FlatButton(
              child: new Text("去实名认证"),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdoptCertificationPage()));
              },
            ),
          ],
        );
      },
    );
  }

  Future getPetList() async{
    var data = await PxzRequest().get(
      "/pet/index",
      data: {
        "page": 1,
        "limit": 20,
      }
    );
    print(data);
  }

  @override
  void initState() {
    this.tabController = TabController(length: 2, vsync: this);
    super.initState();
    getPetList();
    _showDialog();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 190.0,
          backgroundColor: Colors.transparent,
          flexibleSpace: FlexibleSpaceBar(
            background: NekoSwiper(),
          ),
          actions: <Widget>[Container()],
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Wrap(
            direction: Axis.horizontal,
            spacing: 2,
            runSpacing: 5,
            alignment: WrapAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () async{
                  var data = await PxzRequest().get("/member/index");
                  print(data);
                  if(data["data"]["is_verified"] == "2") {
                     Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdoptSongYangFormPage()));
                  }else {
                    if(data["data"]["is_verified"] == "1") {
                      Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdoptCertificationPage()));
                      BotToast.showText(text: "请先实名认证。");
                    }
                    if(data["data"]["is_verified"] == "3") {
                      BotToast.showText(text: "认证中，将在三个工作日内完成。");
                    }
                  }
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff41bcba),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Icon(
                          IconFont.songyang,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                    Text(
                      "发布送养",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdoptLingYangFormPage()));
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xfff4bc61),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Icon(
                          IconFont.lingyangshengqing,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    Text(
                      "领养申请",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AdoptLicensePage()));
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff5d79bb),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Icon(
                          IconFont.jiuzhujidi,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      "救助基地",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => AdoptBlackListPage()));
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Color(0xff4596d1),
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Icon(
                          IconFont.heimindan,
                          color: Colors.white,
                          size: 19,
                        ),
                      ),
                    ),
                    Text(
                      "黑名单查询",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
        SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
                minHeight: 40,
                maxHeight: 40,
                child: Container(
                    color: Color(0xffedecec),
                    child: Row(
                      children: <Widget>[
                        FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(IconFont.dingwei),
                            label: Text("上海市")),
                        Expanded(child: SizedBox.expand()),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            "筛选更多",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    )))),
        SliverList(delegate:
            SliverChildBuilderDelegate((BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          AdoptPetPage()));
            },
            child: PetHommingItem(),
          );
        }))
      ],
    );
  }
}

///
/// 轮播图
///
class NekoSwiper extends StatelessWidget {
  static List<Widget> swiperItem = [
    CachedNetworkImage(
      fit: BoxFit.fitWidth,
      placeholder: (context, url) => Image.asset("assets/home/loading.png"),
      imageUrl:
          "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2364654808,1367649755&fm=26&gp=0.jpg",
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
    CachedNetworkImage(
      fit: BoxFit.fitWidth,
      placeholder: (context, url) => Image.asset("assets/home/loading.png"),
      imageUrl:
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589795536301&di=e65c12f32f0969f9337c309db95209cb&imgtype=0&src=http%3A%2F%2Fwww.chabeichong.com%2Fimages%2F2016%2F10%2F21-06155760.jpg",
      errorWidget: (context, url, error) => Icon(Icons.error),
    )
  ];
  const NekoSwiper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(5, 12, 5, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(3.0)),
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return swiperItem[index];
                },
                itemCount: 2,
                pagination: SwiperPagination(),
              ),
            )),
        Positioned(
          width: 45.0,
          height: 45.0,
          top: -5.0,
          left: 20,
          child: Image.asset("assets/home/swiper_decorate_left.png"),
        ),
        Positioned(
          width: 45.0,
          height: 45.0,
          top: -5.0,
          right: 20,
          child: Image.asset("assets/home/swiper_decorate_right.png"),
        )
      ],
    ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
