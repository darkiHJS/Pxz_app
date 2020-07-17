import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/pages/home/Concern.dart';
import 'package:hello_world/utils/Request.dart';

class ConcernItem extends StatefulWidget {
  final ConcernData data;
  
  ConcernItem({Key key, this.data}) : super(key: key);

  @override
  _ConcernItemState createState() => _ConcernItemState();
}

class _ConcernItemState extends State<ConcernItem> {
  bool _isLike = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 70.0,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 5.0, color: Color(0xffebebeb))),
                  color: Colors.white),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(widget.data.avatar),
                    ),
                  ),
                  Text(widget.data.title),
                  Expanded(child: Text("")),
                  AttentionButton(friendId: widget.data.memberId),
                  SizedBox(width: 20)
                ],
              )),
          Container(
              width: double.infinity, height: 365.0, child: ImagesAndVideo()),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.data.desc),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 70,
                        height: 25,
                        child: FlatButton(
                          onPressed: () => {},
                          padding: EdgeInsets.zero,
                          color: Color(0xffe0e0e0),
                          child: Text(
                            "评论一下",
                            style: TextStyle(color: Color(0xff585858)),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                      Expanded(child: Text("")),
                      GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.open_in_new, color: Color(0xff949494)),
                            SizedBox(width: 4,),
                            Text(widget.data.shareCount, style: TextStyle(color: Color(0xff949494)))
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.chat_bubble_outline, color: Color(0xff949494)),
                            SizedBox(width: 4,),
                            Text(widget.data.collectNum, style: TextStyle(color: Color(0xff949494)))
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      GestureDetector(
                        onTap: (){},
                        child: Row(
                          children: <Widget>[
                            _isLike ? Icon(Icons.favorite, color: Color(0xfff3d72f)) : Icon(Icons.favorite_border, color: Color(0xff949494)),
                            SizedBox(width: 4,),
                            Text(widget.data.likeNum, style: TextStyle(color: Color(0xff949494))),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

// 图片视频控件
class ImagesAndVideo extends StatefulWidget {
  ImagesAndVideo({Key key}) : super(key: key);
  @override
  _ImagesAndVideoState createState() => _ImagesAndVideoState();
}

class _ImagesAndVideoState extends State<ImagesAndVideo> {
  int _index = 1;
  @override
  Widget build(BuildContext context) {
    List<String> urlList = [
      "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2364654808,1367649755&fm=26&gp=0.jpg",
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589795536301&di=e65c12f32f0969f9337c309db95209cb&imgtype=0&src=http%3A%2F%2Fwww.chabeichong.com%2Fimages%2F2016%2F10%2F21-06155760.jpg",
      "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589795536301&di=9e0de8f85c1d0f270be6f5b6c004cfc7&imgtype=0&src=http%3A%2F%2Fg.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F8435e5dde71190efc8f16ea9cd1b9d16fdfa60ba.jpg"
    ];
    Widget _carousel(String url) {
      return Image.network(url, fit: BoxFit.fitHeight);
    }

    return Stack(children: <Widget>[
      PageView.builder(
        itemCount: urlList.length,
        onPageChanged: (index) {
          setState(() {
            _index = index + 1;
          });
        },
        itemBuilder: (context, index) {
          return _carousel(urlList[index]);
        },
      ),
      Positioned(
          top: 15,
          right: 15,
          child: Container(
              decoration: BoxDecoration(
                  color: Color(0xff86745f),
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              width: 39.0,
              height: 25.0,
              child: Center(
                child: Text(
                  '$_index / ${urlList.length}',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )))
    ]);
  }
}

// 关注按钮
class AttentionButton extends StatefulWidget {
  final String friendId;
  AttentionButton({Key key, this.friendId}) : super(key: key);

  @override
  _AttentionButtonState createState() => _AttentionButtonState();
}

class _AttentionButtonState extends State<AttentionButton> {
  bool _isAttention = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 60,
        height: 25,
        child: FlatButton(
          onPressed: () async {
            var data = await PxzRequest().post(
              "/member/attention",
              data: {
                "friend_id":  widget.friendId
              }
            );
            if(data["status"] == "error") {
              BotToast.showText(text: data["msg"]);
              return;
            }
            setState(() {
              _isAttention = !_isAttention;
            });
          },
          padding: EdgeInsets.zero,
          color: _isAttention ? Color(0xffe0e0e0) : Color(0xfff3d72f),
          child: Text(
            _isAttention ? "已关注" : "关注",
            style: TextStyle(color: Color(0xff585858)),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      ),
    );
  }
}
