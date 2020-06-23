import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/components/PhotoViewSimpleScreen.dart';
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
    Map<String, dynamic> data = await PxzRequest().get("/rescue/detail/$id");
    setState(() {
      double maxHight = 0;
      _contentDetailsData = ContentDetailsData.fromJson(data["data"]);
      _contentDetailsData.resources.forEach((element) {
        if (maxHight < double.parse(element.whextends.height)) {
          maxHight = double.parse(element.whextends.height);
          _maxSwiper = element.whextends;
        }
      });
    });
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
                                borderSide: BorderSide(color: Color(0xfff3d72f)),
                                padding: EdgeInsets.zero,
                                child: Text(
                                  "关注",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xfff3d72f)),
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
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        PhotoViewSimpleScreen(
                                                          imageProvider:
                                                              NetworkImage(
                                                                  _contentDetailsData
                                                                      .resources[
                                                                          index]
                                                                      .url),
                                                          heroTag: "hero",
                                                        )));
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            height: double.parse(
                                                    _maxSwiper.height) /
                                                (double.parse(
                                                        _maxSwiper.width) /
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
                                      ),
                                    );
                                  },
                                  // control: new SwiperControl(),
                                  pagination: SwiperPagination(
                                      builder: DotSwiperPaginationBuilder(
                                    color: Color(0xffdfdfdf),
                                    activeColor: Color(0xfff3d72f),
                                    size: 5,
                                    activeSize: 7,
                                  )))),
                          Article(
                            title: _contentDetailsData.title,
                            desc: _contentDetailsData.desc,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              height: 50,
                              color: Color(0xffdddddd),
                            ),
                          )
                        ]),
                      ),
                      CommentList(
                        id: "1",
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(bottom: 55),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 0, left: 0, right: 0, child: DetailsBottomBar()),
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
          border:
              Border(top: BorderSide(color: Theme.of(context).dividerColor)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          FlatButton.icon(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Color(0xffececec),
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
    Map<String, dynamic> data = await PxzRequest().get("/rescue/get_comment",
        data: {"id": id, "page": _index, "limit": 10});
    setState(() {
      data["data"]["items"].forEach((element) {
        _commentItems.add(CommentItem.fromJson(element));
      });
      _totalItems = data["data"]["total_items"];
    });
  }

  Future getSecondaryCommentList(id, page) async {
    Map<String, dynamic> data = await PxzRequest().get("/rescue/get_subcomment",
        data: {"comment_id": id, "limit": 10, "page": page});
    return data["data"]["items"];
  }

  @override
  void initState() {
    super.initState();
    getCommentList();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        sliver: _commentItems == null
            ? SizedBox.shrink()
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                CommentItem item = _commentItems[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    index == 0
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              "共有 ${_commentItems.length}条 评论",
                              style: TextStyle(color: Color(0xff7F7F7F)),
                            ),
                          )
                        : SizedBox.shrink(),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 18,
                              backgroundImage:
                                  NetworkImage(item.memberDetail.avatar),
                            ),
                          ),
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(item.memberDetail.nickname),
                                  RichText(
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          text: item.content,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "  昨天 23:05",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 12))
                                          ]))
                                ]),
                          ),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: 20,
                                    color: Colors.grey,
                                  )),
                              Text(
                                "1151",
                                style:
                                    TextStyle(fontSize: 10, color: Colors.grey),
                              ),
                            ],
                          )
                        ]),
                    Container(
                      padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: item.commentItemChildrens.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CommentChildItem(
                                  item.commentItemChildrens[index]);
                            },
                          ),
                          item.childrenCount > 0 &&
                                  item.childrenCount -
                                          item.commentItemChildrens.length >
                                      0
                              ? FlatButton(
                                  onPressed: () {
                                    if (item.commentItemChildrens.length % 10 ==
                                            0 ||
                                        item.commentItemChildrens.length == 1) {
                                      if (item.commentItemChildrens.length ==
                                          1) {
                                        getSecondaryCommentList(item.id, 1)
                                            .then((value) {
                                          setState(() {
                                            item.commentItemChildrens = [];
                                            List newData = value;
                                            newData.forEach((element) {
                                              CommentItemChildrens newItem =
                                                  CommentItemChildrens.fromJson(
                                                      element);
                                              item.commentItemChildrens
                                                  .add(newItem);
                                            });
                                          });
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    "展开${item.childrenCount - item.commentItemChildrens.length}条回复",
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  ))
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    index == _commentItems.length - 1
                        ? SizedBox.shrink()
                        : Padding(
                            padding: EdgeInsets.only(left: 50),
                            child: Divider(
                              height: 30,
                              color: Color(0xffdddddd),
                            ),
                          )
                  ],
                );
              }, childCount: _commentItems.length)));
  }
}

// 二级评论 item

class CommentChildItem extends StatelessWidget {
  final CommentItemChildrens item;
  final TapGestureRecognizer _tapGestureRecognizer =
      new TapGestureRecognizer(); // 不卸载可能会出现问题
  CommentChildItem(this.item);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("点击了外层");
        },
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(item.memberDetail.avatar),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        item.memberDetail.nickname,
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: item.toMemberId == null
                            ? RichText(
                                text: TextSpan(
                                    text: item.content,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "  昨天 23:05",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12))
                                    ]),
                              )
                            : RichText(
                                softWrap: true,
                                text: TextSpan(
                                    text: "回复",
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: ' @${item.toMemberNickname}: ',
                                          style: TextStyle(color: Colors.grey),
                                          recognizer: _tapGestureRecognizer
                                            ..onTap = () {
                                              print("@被点击了");
                                            }),
                                      TextSpan(text: item.content),
                                      TextSpan(
                                          text: "  昨天 23:05",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12))
                                    ])),
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.grey,
                        )),
                    Text(
                      "1151",
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
          ],
        )));
  }
}
