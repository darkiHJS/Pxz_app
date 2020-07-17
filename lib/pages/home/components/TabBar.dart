import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/home/Discovery.dart';
import 'package:hello_world/pages/home/MessageList.dart';
import 'package:hello_world/utils/Request.dart';

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
  int _messageCount = 0;
  TabController _tabController;

  /// 获取新消息数量
  Future getMessageCount() async {
    var data = await PxzRequest().get(
      "/member_notify/count"
    );
    if(data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }
    print(data);
    _messageCount = data["data"];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabTitleList.length, vsync: this);
    _tabController.index = 1;
    getMessageCount();
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
                          borderSide:
                              BorderSide(width: 3.0, color: Color(0xfff5cd1f)),
                          insets: EdgeInsets.fromLTRB(30, 1, 30, 8),
                        ),
                        controller: _tabController,
                        tabs: tabTitleList)),
                Stack(
                  children: <Widget>[
                    IconButton(
                        icon: Image.asset("assets/home/alert-icon.png",
                            width: 20.0),
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) => MessageListPage())).then((value) {
                                getMessageCount();
                              });
                        }),
                    _messageCount == 0 ?
                    Container() :  
                    Positioned(
                      top: 8,
                      right: 8, 
                      child: Container(
                        width: 18,
                        height: 18,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red
                        ),
                        child: Text(_messageCount.toString(), style: TextStyle(color: Colors.white),),
                      ),
                    )
                    
                  ],
                )
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
