import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hello_world/pages/home/Exaid.dart';

class UserReleaseWorksPage extends StatefulWidget {
  UserReleaseWorksPage({Key key}) : super(key: key);

  @override
  _UserReleaseWorksPageState createState() => _UserReleaseWorksPageState();
}

class _UserReleaseWorksPageState extends State<UserReleaseWorksPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
       height: double.infinity,
       child: CustomScrollView(
         slivers: <Widget>[
            SliverStaggeredGrid.countBuilder(
              crossAxisCount: 4, 
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) => ProgramItem(), 
              staggeredTileBuilder:(int index) => StaggeredTile.fit(2),
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
            )
         ],
       ),
    );
  }
}


class ProgramItem extends StatefulWidget {
  ProgramItem({Key key}) : super(key: key);

  @override
  _ProgramItemState createState() => _ProgramItemState();
}

class _ProgramItemState extends State<ProgramItem> {
  String _imgUrl = "";
  void getHttp() async {
    try {
      Response response = await dio.get(
          "http://shibe.online/api/shibes?count=1&urls=false&httpsUrls=true");
      if (response.statusCode == HttpStatus.ok) {
        var data = response.toString();
        setState(() {
          _imgUrl =
              "https://cdn.shibe.online/shibes/${data.substring(1, data.length - 1)}.jpg";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getHttp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.3,
              offset: Offset(0, 0.5),
            )
          ]),
      child: Column(
        children: <Widget>[
          _imgUrl != ""
              ? ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
                  child: FadeInImage.assetNetwork(
                    placeholder:  "assets/navigationbar/bar4.png",
                    image: _imgUrl
                  )
                )
              : Text(""),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 10, 5),
            child: Text("黑化肥很黑化肥很黑化肥很黑化肥很黑化肥很黑化肥很黑化"),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            height: 35.0,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(
                    "https://timable.com/res/pic/84e4cdc6a00ef38cf9c8a48a0b1f3f0f3.jpg"),
                ),
                Text("派小爪", style: TextStyle(fontSize: 10),),
                Expanded(child: Text("")),
                FlatButton.icon(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.favorite, color: Color(0xfff3d72f), size: 15,), 
                  label: Text("1113", style: TextStyle(fontSize: 10),),
                  onPressed: null
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}