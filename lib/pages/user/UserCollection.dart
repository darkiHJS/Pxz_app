import 'package:flutter/material.dart';
import 'package:hello_world/pages/user/UserCollectionHoming.dart';
import 'package:hello_world/pages/user/UserCollectionWorks.dart';

class UserCollectionPage extends StatefulWidget {
  UserCollectionPage({Key key}) : super(key: key);

  @override
  _UserCollectionPageState createState() => _UserCollectionPageState();
}

class _UserCollectionPageState extends State<UserCollectionPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> tabTitleList = <Tab>[
    Tab(text: "作品"),
    Tab(text: "送养"),
  ];

  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabTitleList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("我的收藏")),
        body: Container(
            child: Column(
          children: <Widget>[
            TabBar(
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Color(0xfff5cd1f)),
                  insets: EdgeInsets.fromLTRB(30, 1, 30, 8),
                ),
                controller: _tabController,
                tabs: tabTitleList),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  UserCollectionWorksPage(),
                  UserCollectionHomingPage()
                ],)
            )
          ],
        )),
      ),
    );
  }
}
