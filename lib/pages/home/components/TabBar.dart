import 'package:flutter/material.dart';

class HomeTabBar extends StatefulWidget {
  HomeTabBar({Key key}) : super(key: key);

  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> with SingleTickerProviderStateMixin{

  final List<Tab> tabTitleList = <Tab> [
    Tab(text: "关注"),
    Tab(text: "救助"),
    Tab(text: "发现")
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitleList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(icon: Image.asset("assets/home/seach-icon.png"), onPressed: null),
              Expanded(
                child: TabBar(
                  indicator: CircleTabIndicator(color: Color.fromRGBO(243, 215, 44, 1), radius: 3),
                  controller: _tabController,
                  tabs: tabTitleList
                )
              ),
              IconButton(icon: Image.asset("assets/home/alert-icon.png"), onPressed: null),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: tabTitleList.map((Tab tab) {
                return Center(child: Text(tab.text),);
              }).toList()
            )
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({@required Color color, @required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size.width / 2, cfg.size.height - radius - 5);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}