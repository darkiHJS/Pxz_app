import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dio/dio.dart';

Dio dio = new Dio();

class ExaidPage extends StatefulWidget {
  ExaidPage({Key key}) : super(key: key);

  @override
  _ExaidPageState createState() => _ExaidPageState();
}

class _ExaidPageState extends State<ExaidPage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            backgroundColor: Colors.transparent,
            floating: false,
            snap: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                title: Text(""),
                background: NekoBanner()),
          )
        ];
      },
      body: Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: StaggeredGridView.countBuilder(
            addAutomaticKeepAlives: true,
            crossAxisCount: 4,
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => ProgramItem(),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 6.0,
            crossAxisSpacing: 6.0,
          )),
    );
  }
}

class NekoBanner extends StatefulWidget {
  NekoBanner({Key key}) : super(key: key);

  @override
  _NekoBannerState createState() => _NekoBannerState();
}

class _NekoBannerState extends State<NekoBanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            margin: EdgeInsets.fromLTRB(10, 12, 10, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: PageView(
                children: <Widget>[
                  Image.network(
                    "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2364654808,1367649755&fm=26&gp=0.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                  Image.network(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589795536301&di=e65c12f32f0969f9337c309db95209cb&imgtype=0&src=http%3A%2F%2Fwww.chabeichong.com%2Fimages%2F2016%2F10%2F21-06155760.jpg",
                    fit: BoxFit.fitWidth,
                  )
                ],
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
