import 'package:flutter/material.dart';

import '../Concern.dart'; // 引入关注页面

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
              IconButton(icon: Image.asset("assets/home/seach-icon.png", width: 20.0,), onPressed: null),
              Expanded(
                child: TabBar(
                  indicatorColor: Color.fromRGBO(243, 215, 44, 1),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  tabs: tabTitleList
                )
              ),
              IconButton(icon: Image.asset("assets/home/alert-icon.png", width: 20.0), onPressed: null),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ConcernPage(),
                Text("321"),
                Text("123456")
              ]
            )
          )
        ],
      ),
    );
  }
}
