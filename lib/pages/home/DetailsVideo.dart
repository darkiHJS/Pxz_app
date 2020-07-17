import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/jsons/ContentDetailsData.dart';
import 'package:hello_world/utils/Request.dart';

/// 视频详情页
/// 接受一个 [id] 请求接口
///
class DetailsVideoPage extends StatefulWidget {
  final String id;
  DetailsVideoPage({Key key, this.id}) : super(key: key);

  @override
  _DetailsVideoPageState createState() => _DetailsVideoPageState(id);
}

class _DetailsVideoPageState extends State<DetailsVideoPage> {
  String id;
  bool _isFull = false;
  ContentDetailsData _contentDetailsData;
  _DetailsVideoPageState(this.id);

  Future getPageData() async {
    Map<String, dynamic> data = await PxzRequest().get("/rescue/detail/$id");
    if(data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }
    _contentDetailsData = ContentDetailsData.fromJson(data["data"]);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    print(id);
    getPageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: _isFull
                ? SizedBox.shrink()
                : AppBar(
                    brightness: Brightness.dark,
                    backgroundColor: Colors.black,
                    elevation: 0.0,
                  ),
            preferredSize: Size.fromHeight(30)),
        body: _contentDetailsData == null
            ? SizedBox.shrink()
            : Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        AwsomeVideoPlayer(
                          _contentDetailsData.resources[0].url,
                          onfullscreen: (isF) {
                            setState(() {
                              _isFull = isF;
                            });
                          },
                          videoStyle: VideoStyle(
                            videoTopBarStyle: VideoTopBarStyle(
                                show: true,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                popIcon: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                actions: [
                                  GestureDetector(
                                    onTap: () {
                                      print("弹出");
                                    },
                                    child: Icon(
                                      Icons.open_in_new,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  )
                                ]),
                            videoControlBarStyle: VideoControlBarStyle(
                                height: 50,
                                playIcon: Icon(Icons.play_arrow,
                                    color: Color(0xffebd644), size: 30),
                                pauseIcon: Icon(
                                  Icons.pause,
                                  color: Color(0xffebd644),
                                  size: 30,
                                ),
                                rewindIcon: SizedBox.shrink(),
                                forwardIcon: SizedBox.shrink(),
                                fullscreenIcon: Icon(
                                  Icons.fullscreen,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                /// 更改进度栏的退出全屏按钮
                                fullscreenExitIcon: Icon(
                                  Icons.fullscreen_exit,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                timeFontSize: 12,
                                progressStyle: VideoProgressStyle(
                                    padding: EdgeInsets.only(top: 30),
                                    height: 8,
                                    playedColor: Color(0xffebd644),
                                    bufferedColor: Colors.white)),
                          ),
                        ),
                        Positioned(
                            bottom: 40,
                            left: 25,
                            right: 20,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                _contentDetailsData.petList != null && _contentDetailsData.petList.length > 0 ?
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Color(0xffebd644),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Text(
                                        "视频中的猫咪",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                        height: 60,
                                        padding: EdgeInsets.only(top: 10),
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: _contentDetailsData
                                                .petList.length,
                                            itemBuilder: (context, index) {
                                              PetList put = _contentDetailsData
                                                  .petList[index];
                                              return Container(
                                                margin:
                                                    EdgeInsets.only(right: 10),
                                                width: 50,
                                                child: ClipRect(
                                                  child: Image.network(
                                                    put.imageDefaultId.url,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              );
                                            })),
                                  ],
                                ) : SizedBox.shrink(),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(children: <Widget>[
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          _contentDetailsData
                                              .memberDetail.avatar),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        _contentDetailsData.title,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ]),
                                ),
                                Text(
                                  _contentDetailsData.desc,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            )
                              )
                        ],
                    ),
                  ),
                  _isFull
                      ? SizedBox.shrink()
                      : Container(
                          width: double.infinity,
                          color: Colors.black,
                          height: 55,
                          child: Center(
                              child: Row(
                            children: <Widget>[
                              Expanded(child: Text("")),
                              FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                  label: Text(_contentDetailsData.likeNum,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  ),
                                  label: Text(_contentDetailsData.collectNum,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                              FlatButton.icon(
                                  onPressed: null,
                                  icon: Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.white,
                                  ),
                                  label: Text(_contentDetailsData.commentCount,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))),
                            ],
                          )),
                        )
                ],
              ));
  }
}
