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
  int _commentIndex = 1;
  List<CommentItem> _commentItems = [];
  bool _isMore = true;

  Future getCommentList() async {
    var commentList;
    var data = await PxzRequest().get("/pet/get_comment",
      data: {
        "id": widget.id,
        "page": _commentIndex,
        "limit": 10
      }
    );
    print(data);
    if(data["status"] == "success") {
      commentList = data["data"]["items"];
      if(commentList.length < 10) _isMore = false;
      commentList.forEach((e) {
        _commentItems.add(CommentItem.fromJson(e));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCommentList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("评论"),
      ),
      body: Container(
      ),
    );
  }
}

/// 评论列表
///

// class CommentList extends StatefulWidget {
//   final String id;
//   CommentList({Key key, this.id}) : super(key: key);

//   @override
//   _CommentListState createState() => _CommentListState(id);
// }

// class _CommentListState extends State<CommentList> {
//   String id;
//   _CommentListState(this.id);

//   List<CommentItem> _commentItems = [];
//   int _totalItems;
//   int _index = 1;
//   Future getCommentList() async {
//     Map<String, dynamic> data = await PxzRequest().get("pet/get_comment",
//         data: {"id": id, "page": _index, "limit": 10});
//     print(data);
//     setState(() {
//       data["data"]["items"].forEach((element) {
//         _commentItems.add(CommentItem.fromJson(element));
//       });
//       _totalItems = data["data"]["total_items"];
//     });
//   }

//   Future getSecondaryCommentList(id, page) async {
//     Map<String, dynamic> data = await PxzRequest().get("/rescue/get_subcomment",
//         data: {"comment_id": id, "limit": 10, "page": page});
//     return data["data"]["items"];
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCommentList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SliverPadding(
//         padding: EdgeInsets.symmetric(horizontal: 15),
//         sliver: _commentItems == null
//             ? SizedBox.shrink()
//             : SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                 CommentItem item = _commentItems[index];
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     index == 0
//                         ? Padding(
//                             padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
//                             child: Text(
//                               "共有 ${_commentItems.length}条 评论",
//                               style: TextStyle(color: Color(0xff7F7F7F)),
//                             ),
//                           )
//                         : SizedBox.shrink(),
//                     Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(right: 10),
//                             child: CircleAvatar(
//                               radius: 18,
//                               backgroundImage:
//                                   NetworkImage(item.memberDetail.avatar),
//                             ),
//                           ),
//                           Expanded(
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(item.memberDetail.nickname),
//                                   RichText(
//                                       textAlign: TextAlign.start,
//                                       text: TextSpan(
//                                           style: DefaultTextStyle.of(context)
//                                               .style,
//                                           text: item.content,
//                                           children: <TextSpan>[
//                                             TextSpan(
//                                                 text: "  昨天 23:05",
//                                                 style: TextStyle(
//                                                     color: Colors.grey,
//                                                     fontSize: 12))
//                                           ]))
//                                 ]),
//                           ),
//                           Column(
//                             children: <Widget>[
//                               GestureDetector(
//                                   onTap: () {},
//                                   child: Icon(
//                                     Icons.favorite_border,
//                                     size: 20,
//                                     color: Colors.grey,
//                                   )),
//                               Text(
//                                 "1151",
//                                 style:
//                                     TextStyle(fontSize: 10, color: Colors.grey),
//                               ),
//                             ],
//                           )
//                         ]),
//                     Container(
//                       padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           ListView.builder(
//                             shrinkWrap: true,
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: item.commentItemChildrens.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return CommentChildItem(
//                                   item.commentItemChildrens[index]);
//                             },
//                           ),
//                           item.childrenCount > 0 &&
//                                   item.childrenCount -
//                                           item.commentItemChildrens.length >
//                                       0
//                               ? FlatButton(
//                                   onPressed: () {
//                                     if (item.commentItemChildrens.length % 10 ==
//                                             0 ||
//                                         item.commentItemChildrens.length == 1) {
//                                       if (item.commentItemChildrens.length ==
//                                           1) {
//                                         getSecondaryCommentList(item.id, 1)
//                                             .then((value) {
//                                           setState(() {
//                                             item.commentItemChildrens = [];
//                                             List newData = value;
//                                             newData.forEach((element) {
//                                               CommentItemChildrens newItem =
//                                                   CommentItemChildrens.fromJson(
//                                                       element);
//                                               item.commentItemChildrens
//                                                   .add(newItem);
//                                             });
//                                           });
//                                         });
//                                       }
//                                     }
//                                   },
//                                   child: Text(
//                                     "展开${item.childrenCount - item.commentItemChildrens.length}条回复",
//                                     style: TextStyle(
//                                         color: Colors.blue, fontSize: 12),
//                                   ))
//                               : SizedBox.shrink(),
//                         ],
//                       ),
//                     ),
//                     index == _commentItems.length - 1
//                         ? SizedBox.shrink()
//                         : Padding(
//                             padding: EdgeInsets.only(left: 50),
//                             child: Divider(
//                               height: 30,
//                               color: Color(0xffdddddd),
//                             ),
//                           )
//                   ],
//                 );
//               }, childCount: _commentItems.length)));
//   }
// }

// // 二级评论 item

// class CommentChildItem extends StatelessWidget {
//   final CommentItemChildrens item;
//   final TapGestureRecognizer _tapGestureRecognizer =
//       new TapGestureRecognizer(); // 不卸载可能会出现问题
//   CommentChildItem(this.item);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           print("点击了外层");
//         },
//         child: Container(
//             child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
//                   child: CircleAvatar(
//                     radius: 10,
//                     backgroundImage: NetworkImage(item.memberDetail.avatar),
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         item.memberDetail.nickname,
//                         style: TextStyle(fontSize: 14),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 5),
//                         child: item.toMemberId == null
//                             ? RichText(
//                                 text: TextSpan(
//                                     text: item.content,
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                           text: "  昨天 23:05",
//                                           style: TextStyle(
//                                               color: Colors.grey, fontSize: 12))
//                                     ]),
//                               )
//                             : RichText(
//                                 softWrap: true,
//                                 text: TextSpan(
//                                     text: "回复",
//                                     style: DefaultTextStyle.of(context).style,
//                                     children: <TextSpan>[
//                                       TextSpan(
//                                           text: ' @${item.toMemberNickname}: ',
//                                           style: TextStyle(color: Colors.grey),
//                                           recognizer: _tapGestureRecognizer
//                                             ..onTap = () {
//                                               print("@被点击了");
//                                             }),
//                                       TextSpan(text: item.content),
//                                       TextSpan(
//                                           text: "  昨天 23:05",
//                                           style: TextStyle(
//                                               color: Colors.grey, fontSize: 12))
//                                     ])),
//                       )
//                     ],
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     GestureDetector(
//                         onTap: () {},
//                         child: Icon(
//                           Icons.favorite_border,
//                           size: 20,
//                           color: Colors.grey,
//                         )),
//                     Text(
//                       "1151",
//                       style: TextStyle(fontSize: 10, color: Colors.grey),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ],
//         )));
//   }
// }