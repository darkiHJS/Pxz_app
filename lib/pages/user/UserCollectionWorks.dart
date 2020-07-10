import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hello_world/jsons/HomeDiscoveryDataModel.dart';
import 'package:hello_world/pages/home/DetailsArticle.dart';
import 'package:hello_world/pages/home/DetailsVideo.dart';
import 'package:hello_world/utils/Request.dart';

class UserCollectionWorksPage extends StatefulWidget {
  UserCollectionWorksPage({Key key}) : super(key: key);

  @override
  _UserCollectionWorksPageState createState() => _UserCollectionWorksPageState();
}

class _UserCollectionWorksPageState extends State<UserCollectionWorksPage> {

  List<DiscoveryDataItem> _discoverItems = [];

  int _page = 1; // 
  int _commentNum = 0;
  bool _isMore = true;

  // 获取item数据
  Future getData() async {
    var data = await PxzRequest().get(
      "/member/collect_rescue",
      data: {
        "page": _page,
        "limit": 20
      }
    );
    if(data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }
    if(data["data"]["items"].length < 20) _isMore = false;
    _commentNum = data["data"]["total_items"];
    data["data"]["items"].forEach((e){
      _discoverItems.add(DiscoveryDataItem.fromJson(e));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(5),
          sliver: SliverStaggeredGrid.countBuilder(
            crossAxisCount: 4,
            itemCount: _commentNum,
            itemBuilder: (BuildContext context, int index) {
              if(index >= _discoverItems.length && _isMore) {
                _page++;
                getData();
              }
              return ProgramItem(discoveryDataItem: _discoverItems[index]);
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            mainAxisSpacing: 5.0,
            crossAxisSpacing: 5.0,
          ),
        )
      ],
    );
  }
}

///
/// 页面展示小卡片
///
class ProgramItem extends StatelessWidget {
  const ProgramItem({Key key, this.discoveryDataItem}) : super(key: key);
  final DiscoveryDataItem discoveryDataItem;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0.5,
              blurRadius: 0.3,
              offset: Offset(0, 0.5),
            )
          ]),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (discoveryDataItem.resourceType == "video") {
                Navigator.push(context, MaterialPageRoute(builder:(context) => DetailsVideoPage(id: discoveryDataItem.id)));
              } else {
                Navigator.push(context, MaterialPageRoute(builder:(context) => DetailsArticlePage(id: discoveryDataItem.id,)));              
              }
            },
            child: Stack(
              children: <Widget>[
                ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
                child: discoveryDataItem.mainDefaultId != null
                    ? CachedNetworkImage (
                      placeholder: (context, url) => Image.asset("assets/home/loading.png"),
                      imageUrl: discoveryDataItem.mainDefaultId,
                    ) 
                    : Image.asset("assets/home/loading.png")),
                discoveryDataItem.resourceType == "video" ?  
                Positioned(
                  right: 5,
                  bottom: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: Icon(Icons.play_arrow, color: Colors.white, size: 25,),
                  ) 
                ) : 
                SizedBox.shrink() 
              ],
            )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 10, 5),
            child: Text(
              discoveryDataItem.title,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
            height: 35.0,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage:
                        NetworkImage(discoveryDataItem.memberDetail.avatar),
                  ),
                ),
                Text(
                  discoveryDataItem.memberDetail.nickname,
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
                Expanded(child: Text("")),
                SizedBox(
                  width: 28,
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Color(0xfff3d72f),
                        size: 15,
                      ),
                      onPressed: null),
                ),
                Text(
                  discoveryDataItem.likeNum,
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
