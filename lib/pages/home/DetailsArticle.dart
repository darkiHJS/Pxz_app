import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/jsons/CommentItem.dart';
import 'package:hello_world/jsons/ContentDetailsData.dart';
import 'package:hello_world/utils/Request.dart';

///
/// 文章详情页
/// 接收一个 [id] 请求接口
///

class DetailsArticlePage extends StatefulWidget {
  final String id;
  DetailsArticlePage({Key key, this.id}) : super(key: key);

  @override
  _DetailsArticlePageState createState() => _DetailsArticlePageState(id);
}

class _DetailsArticlePageState extends State<DetailsArticlePage> {
  String id;
  ContentDetailsData _contentDetailsData;
  Extends _maxSwiper;
  _DetailsArticlePageState(this.id);

  Future getPageData() async {
    Map<String, dynamic> data = await PxzRequest().get("/rescue/detail/1");
    setState(() {
      double maxHight = 0;
      _contentDetailsData = ContentDetailsData.fromJson(data["data"]);
      _contentDetailsData.resources.forEach((element) {
        if (maxHight < double.parse(element.whextends.height)) {
          maxHight = double.parse(element.whextends.height);
          _maxSwiper = element.whextends;
        }
      });
      print(_maxSwiper.width);
    });

    // return null;
  }

  @override
  void initState() {
    super.initState();
    getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            preferredSize: Size.fromHeight(0)),
        body: _contentDetailsData == null
            ? SizedBox.shrink()
            : Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        title: Row(
                          children: <Widget>[
                            IconButton(
                              color: Colors.grey,
                              alignment: Alignment.centerLeft,
                              icon: Icon(Icons.arrow_back_ios),
                              onPressed: () => Navigator.of(context).pop(),
                              padding: EdgeInsets.zero,
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: NetworkImage(
                                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1906469856,4113625838&fm=26&gp=0.jpg"),
                              ),
                            ),
                            Text(
                              "女王草莓",
                              style: TextStyle(fontSize: 14),
                            ),
                            Expanded(child: SizedBox.shrink()),
                            SizedBox(
                              width: 50,
                              height: 22,
                              child: OutlineButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                borderSide: BorderSide(color: Colors.yellow),
                                padding: EdgeInsets.zero,
                                child: Text(
                                  "关注",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.yellow),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            IconButton(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.all(0),
                              color: Colors.grey,
                              icon: Icon(Icons.open_in_new),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(<Widget>[
                          Container(
                              height: double.parse(_maxSwiper.height) /
                                      (double.parse(_maxSwiper.width) /
                                          MediaQuery.of(context).size.width) +
                                  30,
                              alignment: Alignment.topCenter,
                              child: Swiper(
                                  itemCount:
                                      _contentDetailsData.resources.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        CachedNetworkImage(
                                          height: double.parse(
                                                  _maxSwiper.height) /
                                              (double.parse(_maxSwiper.width) /
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width),
                                          alignment: Alignment.center,
                                          imageUrl: _contentDetailsData
                                              .resources[index].url,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        SizedBox.shrink()
                                      ],
                                    );
                                  },
                                  // control: new SwiperControl(),
                                  pagination: SwiperPagination(
                                      builder: DotSwiperPaginationBuilder(
                                    color: Color(0xffdfdfdf),
                                    activeColor: Colors.yellow,
                                    size: 5,
                                    activeSize: 7,
                                  )))),
                          Article(
                            title: _contentDetailsData.title,
                            desc: _contentDetailsData.desc,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 15), child: Divider(height: 20,color: Colors.grey,),),
                          CommentList(id: "1",),
                          SizedBox.fromSize(
                            size: Size.fromHeight(55),
                          )
                        ]),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: DetailsBottomBar()
                  ),
                  
                ],
              ));
  }
}

// 文章组件
class Article extends StatelessWidget {
  final String title;
  final String desc;
  const Article({Key key, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 18),
          ),
          Text(desc),
        ],
      ),
    );
  }
}

// bottom bar
class DetailsBottomBar extends StatefulWidget {
  @override
  _DetailsBottomBarState createState() => _DetailsBottomBarState();
}

class _DetailsBottomBarState extends State<DetailsBottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      height: 45,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color:  Theme.of(context).dividerColor)),
        color: Colors.white
      ),
      child: Row(
        children: <Widget>[
          FlatButton.icon(
            onPressed: null, 
            icon: Icon(Icons.create), 
            label: Text("说点什么吧……")),
          Expanded(child: SizedBox.shrink()),
          MaterialButton(
            onPressed: null,
            minWidth: 0,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.favorite_border),
                Text("1151"),
              ], 
            ),
          ),
          MaterialButton(
            onPressed: null,
            minWidth: 0,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.star_border),
                Text("1151"),
              ], 
            ),
          ),
          MaterialButton(
            onPressed: null,
            minWidth: 0,
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.chat_bubble_outline),
                Text("1151"),
              ], 
            ),
          ),
        ],
      ),
    );
  }
}

/// 评论列表
/// 

class CommentList extends StatefulWidget {
  final String id;
  CommentList({Key key, this.id}) : super(key: key);

  @override
  _CommentListState createState() => _CommentListState(id);
}

class _CommentListState extends State<CommentList> {
  String id;
  _CommentListState(this.id);
  
  List<CommentItem> _commentItems = [];
  int _totalItems;
  int _index = 1;
  Future getCommentList() async {
    Map<String, dynamic> data = 
      await PxzRequest().get(
        "/rescue/get_comment", 
        data: {
          "id": id,
          "page": _index,
          "limit": 10
        }
      );
    setState(() {
      data["data"]["items"].forEach((element) {
        _commentItems.add(CommentItem.fromJson(element));
      });
      _totalItems = data["data"]["total_items"];
    });
    print("请求数据");
    print(_commentItems);
    print(_totalItems);
  }

  @override
  void initState() {
    super.initState();
    getCommentList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _commentItems ?? SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Row(
            children: <Widget>[
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(_commentItems[index].memberDetail.avatar),
              )
            ],  
          );
        },
        childCount: _commentItems.length
      )
    )
    );
  }
}