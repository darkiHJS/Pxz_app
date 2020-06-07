import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/components/PhotoViewSimpleScreen.dart';
import 'package:hello_world/jsons/ContentDetailsData.dart';
import 'package:hello_world/utils/Request.dart';

class DiscoveryItemPage extends StatefulWidget {
  DiscoveryItemPage({Key key, this.itemId}) : super(key: key);
  final String itemId;
  @override
  _DiscoverItemPageState createState() => _DiscoverItemPageState(itemId);
}

class _DiscoverItemPageState extends State<DiscoveryItemPage> {
  final String itemId;
  ContentDetailsData _discoveryItemData;
  _DiscoverItemPageState(this.itemId);

  bool _isPlaying = false;
  // bool _isFullscreen = false;

  bool get isPlaying => _isPlaying;
  set isPlaying(bool playing) {
    print("playing $playing");
    _isPlaying = playing;
  }

  @override
  void initState() {
    super.initState();
    getData() async {
      Map<String, dynamic> data =  await PxzRequest().get("/rescue/detail/$itemId");
      setState(() {
        _discoveryItemData = ContentDetailsData.fromJson(data["data"]);
      });
    }

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Container(
          color: Colors.black,
          child: _discoveryItemData == null ? SizedBox.shrink() :
           Column(
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                child: Stack(
                  fit: StackFit.loose,
                  children: <Widget>[
                    _discoveryItemData == null
                        ? SizedBox.shrink()
                        : _discoveryItemData.resources[0].type == "video"
                            ? VideoComponent(
                                // videoUrl: "assets/test_video.mp4",
                                videoUrl: _discoveryItemData.resources[0].url
                              )
                            : Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PhotoViewSimpleScreen(
                                                    imageProvider: NetworkImage(
                                                        _discoveryItemData
                                                            .resources[index]
                                                            .url),
                                                    heroTag: "hero",
                                                  )));
                                    },
                                    onDoubleTap: () {
                                      print("双击");
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: _discoveryItemData
                                          .resources[index].url,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  );
                                },
                                itemCount: _discoveryItemData.resources.length,
                                viewportFraction: 0.9,
                                scale: 0.9,
                              ),
                    Positioned(
                      top: 30,
                      left: 5,
                      right: 5,
                      child: Row(
                        children: <Widget>[
                          // 返回按钮
                          IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed:() {
                                Navigator.of(context).pop();
                              }),
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
                                      _discoveryItemData.memberDetail.avatar),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 15, 0),
                                  child: Text(
                                    _discoveryItemData.memberDetail.nickname,
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
                                _discoveryItemData.title,
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
                    IconButton(
                        icon: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),  
                        onPressed: null),
                    Expanded(child: Text("")),
                    FlatButton.icon(
                        onPressed: null,
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                        label: Text("1.2w",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                    FlatButton.icon(
                        onPressed: null,
                        icon: Icon(
                          Icons.star_border,
                          color: Colors.white,
                        ),
                        label: Text("55",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                    FlatButton.icon(
                        onPressed: null,
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.white,
                        ),
                        label: Text("1.2w",
                            style: TextStyle(
                              color: Colors.white,
                            ))),
                  ],
                )),
              )
            ],
          )),
    ));
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

/// 图片控件
///

/// 视频控件
///
class VideoComponent extends StatelessWidget {
  const VideoComponent({Key key, this.videoUrl}) : super(key: key);
  final String videoUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: videoUrl != ""
            ? AwsomeVideoPlayer(
                videoUrl,
                videoStyle: VideoStyle(
                    videoControlBarStyle:
                        VideoControlBarStyle(backgroundColor: Colors.yellow)),
              )
            : null,
      ),
    );
  }
}
