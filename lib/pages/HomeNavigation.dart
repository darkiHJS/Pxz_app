import 'package:flutter/material.dart';
import 'package:hello_world/pages/user/UserDrawer.dart';

import './home/Home.dart';
import './adopt/Adopt.dart';
import './issue/Issue.dart';
import './shop/Shop.dart';
import './user/User.dart';

class Navigation extends StatefulWidget {
  Navigation({Key key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  List _pageList = [
    HomePage(),
    AdoptPage(),
    IssuePage(),
    ShopPage(),
    UserPage(),
  ];

  changeIndex(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
                child: AppBar(
                  brightness: Brightness.light,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  actions: [Container()],
                ),
                preferredSize: Size.fromHeight(0)),
            endDrawer: UserDrawer(),
            body: this._pageList[this._currentIndex],
            floatingActionButton: Container(
              width: 72,
              height: 72,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(36),
                  color: Color.fromRGBO(249, 249, 249, 1)),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  changeIndex(2);
                },
                backgroundColor: Color(0xFFF5CD1F),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: NavigationBar(
              currentIndex: _currentIndex,
              changeIndex: changeIndex,
            ));
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar(
      {Key key, @required this.currentIndex, @required this.changeIndex})
      : super(key: key);

  final int currentIndex;
  final Function changeIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 24.0,
          currentIndex: currentIndex,
          onTap: (index) => {changeIndex(index)},
          items: [
            BottomNavigationBarItem(
                title: Text("爪爪们"),
                icon: Image.asset(
                  "assets/navigationbar/bar1.png",
                  width: 25.0,
                ),
                activeIcon: Image.asset(
                  "assets/navigationbar/bar1-a.png",
                  width: 25.0,
                )),
            BottomNavigationBarItem(
                title: Text("爪领养"),
                icon: Image.asset(
                  "assets/navigationbar/bar2.png",
                  width: 25.0,
                ),
                activeIcon: Image.asset(
                  "assets/navigationbar/bar2-a.png",
                  width: 25.0,
                )),
            BottomNavigationBarItem(title: Text("发布"), icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                title: Text("爪店"),
                icon: Image.asset(
                  "assets/navigationbar/bar3.png",
                  width: 25.0,
                ),
                activeIcon: Image.asset(
                  "assets/navigationbar/bar3-a.png",
                  width: 25.0,
                )),
            BottomNavigationBarItem(
                title: Text("爪窝"),
                icon: Image.asset(
                  "assets/navigationbar/bar4.png",
                  width: 25.0,
                ),
                activeIcon: Image.asset(
                  "assets/navigationbar/bar4-a.png",
                  width: 25.0,
                )),
          ]),
    );
  }
}
