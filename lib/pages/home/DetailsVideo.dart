import 'package:awsome_video_player/awsome_video_player.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/jsons/ContentDetailsData.dart';
import 'package:hello_world/pages/HomeNavigation.dart';
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
    setState(() {
      _contentDetailsData = ContentDetailsData.fromJson(data["data"]);
    });
    print(_contentDetailsData);
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
                      child: AwsomeVideoPlayer(
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
                              color: Colors.white, size: 30),
                          pauseIcon: Icon(
                            Icons.pause,
                            color: Colors.red,
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
                            color: Colors.red,
                          ),
                          timeFontSize: 12,
                          progressStyle: VideoProgressStyle(
                              padding: EdgeInsets.only(top: 30), height: 8)),
                    ),
                  )),
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
              ));
  }
}
