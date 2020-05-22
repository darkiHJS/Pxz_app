import 'package:flutter/material.dart';

import 'package:awsome_video_player/awsome_video_player.dart';


class DiscoveryItemPage extends StatefulWidget {
  DiscoveryItemPage({Key key, this.itemId}) : super(key: key);
  final String itemId;

  @override
  _DiscoverItemPageState createState() => _DiscoverItemPageState(itemId);
}

class _DiscoverItemPageState extends State<DiscoveryItemPage> {
  final String itemId;
  _DiscoverItemPageState(this.itemId);

  String videoUrl = 'http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4';
  String mainSubtitles = ""; //主字幕
  String subSubtitles = ""; //辅字幕
  bool _isPlaying = false;
  bool _isFullscreen = false;

  bool showAdvertCover = false; //是否显示广告

  bool get isPlaying => _isPlaying;
  set isPlaying(bool playing) {
    print("playing $playing");
    _isPlaying=playing;
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(itemId);
    return Container(
      child: Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
        children: <Widget>[
          Expanded(
              child: GestureDetector(
            child: Stack(
              fit: StackFit.loose,
              children: <Widget>[
                // Image.network(
                //   "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1590127961783&di=b17b18d4f85eee8a8f411c4ddd255aff&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201608%2F18%2F20160818212432_Faxum.jpeg",
                //   fit: BoxFit.fitHeight,
                //   height: double.infinity,
                // ),
                
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: videoUrl != "" 
                  ? AwsomeVideoPlayer(
                    videoUrl,
                    videoStyle: VideoStyle(
                      videoControlBarStyle: VideoControlBarStyle(
                        backgroundColor: Colors.yellow
                      )
                    ),
                  ) : null,
                ),
                Positioned(
                  top: 50,
                  left: 5,
                  right: 5,
                  child: Row(
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: null),
                      Expanded(
                        child: Text(""),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.open_in_new,
                            color: Colors.white,
                          ),
                          onPressed: null)
                    ],
                  ),
                ),
                Positioned(
                    bottom: 30,
                    left: 15,
                    right: 15,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(
                                  "https://timable.com/res/pic/84e4cdc6a00ef38cf9c8a48a0b1f3f0f3.jpg"),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                              child: Text(
                                "猫爪爪的日常",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            AttentionButton()
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(right: 50),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "主人与猫咪之间的小游戏！猫：零食是逃不过我的眼睛的~",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ))
              ],
            ),
          )),
          Container(
            width: double.infinity,
            height: 55,
            child: Center(
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.play_arrow, color: Colors.white, size: 30,), onPressed: null),
                  Expanded(child: Text("")),
                  FlatButton.icon(onPressed: null, icon: Icon(Icons.favorite_border, color: Colors.white,), label: Text("1.2w", style: TextStyle(color: Colors.white,))),
                  FlatButton.icon(onPressed: null, icon: Icon(Icons.star_border, color: Colors.white,), label: Text("55", style: TextStyle(color: Colors.white,))),
                  FlatButton.icon(onPressed: null, icon: Icon(Icons.chat_bubble_outline, color: Colors.white,), label: Text("1.2w", style: TextStyle(color: Colors.white,))),
                ],
              )
            ),
          )
        ],
      )),)
    );
  }
}

// 关注按钮
class AttentionButton extends StatefulWidget {
  AttentionButton({Key key}) : super(key: key);

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
          onPressed: () {
            setState(() {
              _isAttention = !_isAttention;
            });
          },
          padding: EdgeInsets.zero,
          color: _isAttention ? Color(0xffe0e0e0) : Colors.yellow,
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

class DiscoveryItemData {
  String id;
  String title;
}
