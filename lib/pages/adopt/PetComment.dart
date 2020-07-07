import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/jsons/AdoptPetModel.dart';
import 'package:hello_world/jsons/CommentItem.dart';
import 'package:hello_world/utils/Request.dart';

class CommentPage extends StatefulWidget {
  final String id;
  CommentPage({Key key, this.id}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  int _commentIndex = 1;
  List<CommentItem> _commentItems = [];
  bool _isMore = true;
  List<int> _writeCache = [];
  MemberDetail _toMemberDetail;
  int listLength = 0;

  FocusNode _commentFocus; // 输入框焦点控制器

  // 评论窗口控制列表
  submitControl(MemberDetail toMember, String commentId) {
    // 写入toMemberDetail
    // 写入回复id
    _commentFocus.requestFocus();
  }

  // 获得一级评论列表
  Future getCommentList() async {
    var commentList;
    var data = await PxzRequest().get("/pet/get_comment",
        data: {"id": widget.id, "page": _commentIndex, "limit": 10});
    if (data["status"] == "success") {
      commentList = data["data"]["items"];
      listLength = data["data"]["total_items"];
      if (commentList.length < 10) _isMore = false;
      commentList.forEach((e) {
        _commentItems.add(CommentItem.fromJson(e));
      });
      setState(() {});
    }
  }

  // 获得二级评论列表
  Future _getChildCommentList(String id, int pageIndex) async {
    var commentList = [];
    List<CommentItemChildrens> childComment = [];
    var data = await PxzRequest().get("/pet/get_subcomment",
        data: {"comment_id": id, "page": pageIndex, "limit": 10});
    if (data["status"] == "success") {
      commentList = data["data"]["items"];
      commentList.forEach((element) {
        childComment.add(CommentItemChildrens.fromJson(element));
      });
    }
    return childComment;
  }

  @override
  void initState() {
    super.initState();
    getCommentList();

    _commentFocus = FocusNode();
    _commentFocus.addListener(() {
      print(_commentFocus.hasFocus.toString());
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _commentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("评论($listLength)"),
      ),
      body: GestureDetector(
        onTap: () {
          _commentFocus.unfocus();
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 60),
                child: ListView.builder(
                  itemCount: listLength,
                  itemBuilder: (BuildContext context, int index) {
                    return CommentList(
                        commentItem: _commentItems[index],
                        getChildCommentList: _getChildCommentList,
                        handleFocus: submitControl);
                  },
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration:
                      BoxDecoration(color: Colors.white , boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: Offset(0, 3))
                  ]),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffe9e9e9),
                            borderRadius: BorderRadius.circular(15)
                          ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          focusNode: _commentFocus,
                          decoration: InputDecoration(
                              isDense: true,
                              hintText: "输入评论信息",
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none),
                        ),
                      )),
                      SizedBox(width: 15,),
                      Container(
                        child: FlatButton(
                          onPressed: () {

                          },

                          color: Color(0xfff4cd20),
                          child: Text("发  送", style: TextStyle(fontSize: 16, color: Colors.white),),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

/// 一级评论
///

class CommentList extends StatefulWidget {
  final CommentItem commentItem;
  final Function getChildCommentList;
  final Function handleFocus;
  CommentList(
      {Key key, this.commentItem, this.getChildCommentList, this.handleFocus})
      : super(key: key);

  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  _CommentListState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 18,
            backgroundImage:
                NetworkImage(widget.commentItem.memberDetail.avatar),
          ),
        ),
        Expanded(
            child: GestureDetector(
          onTap: () {
            print("11");
            widget.handleFocus();
          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.commentItem.memberDetail.nickname),
                RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        text: widget.commentItem.content,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  "${DateTime.fromMillisecondsSinceEpoch(int.parse(widget.commentItem.createTime) * 1000).year}/${DateTime.fromMillisecondsSinceEpoch(int.parse(widget.commentItem.createTime) * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(widget.commentItem.createTime) * 1000).day}",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12))
                        ]))
              ]),
        )),
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
              widget.commentItem.praiseNum,
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        )
      ]),
      Container(
        margin: EdgeInsets.only(left: 45, top: 10),
        child: Column(
          children: <Widget>[
            for (var item in widget.commentItem.commentItemChildrens)
              CommentChildItem(
                item: item,
                masterId: widget.commentItem.memberDetail.id,
              ),
            widget.commentItem.childrenCount >
                    widget.commentItem.commentItemChildrens.length
                ? GestureDetector(
                    onTap: () async {
                      // 通过除法获得10位的inde下标  arr.length / 10 .floor
                      int index =
                          (widget.commentItem.commentItemChildrens.length / 10)
                                  .floor() +
                              1;
                      List<CommentItemChildrens> commentItems = await widget
                          .getChildCommentList(widget.commentItem.id, index);
                      if (index != 1) {
                        commentItems.forEach((e) {
                          widget.commentItem.commentItemChildrens.add(e);
                        });
                      } else {
                        widget.commentItem.commentItemChildrens = commentItems;
                      }
                      setState(() {});
                    },
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "加载更多",
                        style: TextStyle(color: Colors.blue, fontSize: 12),
                      ),
                    ))
                : Container()
          ],
        ),
      ),
      Divider()
    ]);
  }
}

// // 二级评论 item

class CommentChildItem extends StatelessWidget {
  final CommentItemChildrens item;
  final String masterId;
  final TapGestureRecognizer _tapGestureRecognizer =
      new TapGestureRecognizer(); // 不卸载可能会出现问题
  CommentChildItem({this.item, this.masterId});

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
                        child: item.toMemberId != masterId
                            ? RichText(
                                softWrap: true,
                                text: TextSpan(
                                    style: DefaultTextStyle.of(context).style,
                                    children: <TextSpan>[
                                      TextSpan(text: item.content),
                                      TextSpan(
                                          text:
                                              "   ${DateTime.fromMillisecondsSinceEpoch(int.parse(item.createTime) * 1000).year}/${DateTime.fromMillisecondsSinceEpoch(int.parse(item.createTime) * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(item.createTime) * 1000).day}",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12))
                                    ]))
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
                                          text:
                                              "   ${DateTime.fromMillisecondsSinceEpoch(int.parse(item.createTime) * 1000).year}/${DateTime.fromMillisecondsSinceEpoch(int.parse(item.createTime) * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(item.createTime) * 1000).day}",
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
                        onTap: () async {
                          var data = await PxzRequest().post("/member/like",
                              data: {"id": item.id, "type": "pet_comment"});
                          print(data);
                        },
                        child: Icon(
                          Icons.favorite_border,
                          size: 20,
                          color: Colors.grey,
                        )),
                    Text(
                      item.praiseNum,
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
