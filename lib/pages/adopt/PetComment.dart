import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/jsons/CommentItem.dart';
import 'package:hello_world/utils/Request.dart';

class CommentPage extends StatefulWidget {
  final String id;
  CommentPage({Key key, this.id}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  int _commentNum = 0;
  int _commentPage = 1; // 列表下标
  List<CommentItem> _list = []; // 评论列表
  bool _isMore = true;
  List<String> _commentCache = [];

  MemberDetail _toMemberDetail; //评论的对象
  String _commentId; //评论的id
  String _commentContent = ""; //评论的内容

  FocusNode _focusNode; // 输入焦点控制

  // 请求一级列表
  Future getCommentList() async {
    var commentList;
    var data = await PxzRequest().get("/pet/get_comment",
        data: {"id": widget.id, "page": _commentPage, "limit": 10});
    print(data);
    if (data["status"] == "success") {
      commentList = data["data"]["items"];
      _commentNum = data["data"]["total_items"];
      if (commentList.length < 10) _isMore = false;
      commentList.forEach((e) {
        CommentItem ci = CommentItem.fromJson(e);
        if (_commentCache.indexOf(ci.id) == -1) {
          _list.add(ci);
        }
      });
      setState(() {});
    }
  }

  // 获得二级评论列表
  Future _getChildCommentList(String id, int pageIndex) async {
    var commentList = [];
    List<CommentItem> childComment = [];
    var data = await PxzRequest().get("/pet/get_subcomment",
        data: {"comment_id": id, "page": pageIndex, "limit": 10});
    if (data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }
    commentList = data["data"]["items"];
    _list.forEach((element) {
      // 找到对应数组
      if (element.id == id) {
        // 过滤
        commentList.removeWhere((newItem) {
          print(newItem);
          bool judgment = false;
          if (_commentCache.indexOf(newItem["id"]) != -1) judgment = true;
          if (pageIndex == 1) {
            element.childrens.forEach((oldItem) {
              if (oldItem.id == newItem["id"]) judgment = true;
            });
          }
          print(judgment);
          return judgment;
        });
        
        // 转换
        commentList.forEach((element) {
          print(element);
          CommentItem ci = CommentItem.fromJson(element);
          if (_commentCache.indexOf(ci.id) == -1) {
            childComment.add(ci);
          }
        });
        element.childrens.addAll(childComment);
      }
    });
    setState(() {});
  }

  // 呼出小键盘
  cellKeyboard(MemberDetail toMember, String commentId) {
    setState(() {
      // 写入toMemberDetail
      _toMemberDetail = toMember;
      // 写入回复id
      _commentId = commentId;
    });
    _focusNode.requestFocus();
  }

  @override
  void initState() {
    super.initState();
    getCommentList();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _toMemberDetail = null;
          _commentId = null;
          _commentContent = "";
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // 释放监视器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("评论($_commentNum)"),
        ),
        body: GestureDetector(
          onTap: () {
            // 点击其他地方取消输入
            _focusNode.unfocus();
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 60),
                child: ListView.builder(
                    itemCount: _commentNum,
                    itemBuilder: (BuildContext context, int index) {
                      if (_list.length <= index && _isMore && index > 9) {
                        // 如果加载到新item处时,请求新的数据
                        _commentPage++;
                        getCommentList();
                        return Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center,
                            child: SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2.0)));
                      }
                      return CommentItemComp(
                        commentItem: _list[index],
                        cellKeyboard: cellKeyboard,
                        getChildCommentList: _getChildCommentList,
                      );
                    }),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
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
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextField(
                            focusNode: _focusNode,
                            controller: TextEditingController()
                              ..text = _commentContent,
                            onChanged: (v) {
                              _commentContent = v;
                            },
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: _toMemberDetail == null
                                    ? "输入评论信息"
                                    : "回复@${_toMemberDetail.nickname}:",
                                hintStyle: TextStyle(color: Colors.black38),
                                border: InputBorder.none),
                          ),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        Container(
                          child: FlatButton(
                            onPressed: () async {
                              CommentItem commentitem;
                              if (_commentContent == "") {
                                BotToast.showText(text: "请填写评论内容！");
                                return;
                              }
                              var form = {
                                "pet_id": widget.id,
                                "content": _commentContent,
                              };
                              if (_commentId != null) {
                                form["comment_id"] = _commentId;
                              }
                              // 提交评论
                              var data = await PxzRequest()
                                  .post("/pet/add_comment", data: form);
                              print(data);
                              if (data["status"] != "success") {
                                BotToast.showText(text: data["msg"]);
                                return;
                              }
                              _commentContent = "";
                              // 评论加入队尾 id归入缓存池
                              if (data["data"]["start_id"] == null) {
                                commentitem =
                                    CommentItem.fromJson(data["data"]);
                                if (commentitem.childrens == null) {
                                  commentitem.childrens = [];
                                  commentitem.childrenCount = 0;
                                }
                                _list.add(commentitem);
                                _commentNum++;
                              } else {
                                commentitem =
                                    CommentItem.fromJson(data["data"]);
                                _list.forEach((e) {
                                  if (e.id == commentitem.startId) {
                                    e.childrens.add(commentitem);
                                    e.childrenCount++;
                                  }
                                });
                              }
                              _commentCache.add(commentitem.id);
                              setState(() {});
                              _focusNode.unfocus();
                            },
                            color: Color(0xfff4cd20),
                            child: Text(
                              "发  送",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

/// 一级评论组件
///

class CommentItemComp extends StatelessWidget {
  final CommentItem commentItem;
  final Function getChildCommentList;
  final Function cellKeyboard;
  const CommentItemComp(
      {Key key, this.commentItem, this.cellKeyboard, this.getChildCommentList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String createTime =
        "${DateTime.fromMillisecondsSinceEpoch(int.parse(commentItem.createTime) * 1000).year}/${DateTime.fromMillisecondsSinceEpoch(int.parse(commentItem.createTime) * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(commentItem.createTime) * 1000).day}";

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: commentItem.memberDetail.avatar != null
                      ? NetworkImage(commentItem.memberDetail.avatar)
                      : AssetImage("assets/details/details_loading.gif"),
                ),
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  // 调用父级的呼出小键盘方法
                  cellKeyboard(commentItem.memberDetail, commentItem.id);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(commentItem.memberDetail.nickname),
                    SizedBox(
                      height: 5,
                    ),
                    Text(commentItem.content),
                    SizedBox(
                      height: 10,
                    ),
                    Text(createTime,
                        style: TextStyle(color: Colors.grey, fontSize: 12))
                  ],
                ),
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
                    commentItem.praiseNum,
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
          // 楼中楼
          Container(
            margin: EdgeInsets.only(left: 45, top: 10),
            child: Column(
              children: <Widget>[
                for (var item in commentItem.childrens)
                  CommentChildItemComp(
                    item: item,
                    parentId: commentItem.id,
                    cellKeyboard: cellKeyboard,
                  ),
                commentItem.childrenCount > commentItem.childrens.length
                    ? GestureDetector(
                        onTap: () async {
                          int page =
                              (commentItem.childrens.length / 10).floor() + 1;
                          await getChildCommentList(commentItem.id, page);
                        },
                        child: Container(
                          alignment: AlignmentDirectional.centerStart,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "加载更多",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ))
                    : Container(),
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}

// // 二级评论 item

class CommentChildItemComp extends StatelessWidget {
  final CommentItem item;
  final String parentId;
  final Function cellKeyboard;
  final TapGestureRecognizer _tapGestureRecognizer =
      new TapGestureRecognizer(); // 不卸载可能会出现问题
  CommentChildItemComp({this.item, this.parentId, this.cellKeyboard});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          cellKeyboard(item.memberDetail, item.id);
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
                    backgroundImage: item.memberDetail.avatar != null
                      ? NetworkImage(item.memberDetail.avatar)
                      : AssetImage("assets/details/details_loading.gif"),
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
                        child: item.pid == parentId
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
                                              print("@���点击了");
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
