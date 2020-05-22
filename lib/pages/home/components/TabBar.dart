import 'package:flutter/material.dart';
import 'package:hello_world/pages/home/Discovery.dart';

import '../Concern.dart'; // 引入关注页面
import '../Exaid.dart'; // 引入救助界面

class HomeTabBar extends StatefulWidget {
  HomeTabBar({Key key}) : super(key: key);

  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabTitleList = <Tab>[
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
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Image.asset(
                      "assets/home/seach-icon.png",
                      width: 20.0,
                    ),
                    onPressed: null),
                Expanded(
                    child: TabBar(
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 3.0, color: Color(0xfff5cd1f)),
                          insets: EdgeInsets.fromLTRB(30, 1, 30, 8),
                        ),
                        controller: _tabController,
                        tabs: tabTitleList)),
                IconButton(
                    icon:
                        Image.asset("assets/home/alert-icon.png", width: 20.0),
                    onPressed: null),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: [ConcernPage(), ExaidPage(), DiscoveryPage()]))
        ],
      ),
    );
  }
}
