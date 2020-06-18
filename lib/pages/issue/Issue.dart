import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum fileStatus { none, image, camera }

class IssuePage extends StatefulWidget {
  IssuePage({Key key}) : super(key: key);

  @override
  _IssuePageState createState() => _IssuePageState();
}

class _IssuePageState extends State<IssuePage> {
  String formTitle;
  String formContent;
  List<AssetEntity> assets = [];
  var formState = fileStatus.none;
  selectCamera() async {
    final List<AssetEntity> ass = await AssetPicker.pickAssets(context,
        requestType: RequestType.video, maxAssets: 1, selectedAssets: assets);
    if (ass == null) {
      setState(() {
        formState = fileStatus.none;
        assets = [];
      });
      return;
    } 
    setState(() {
      formState = fileStatus.camera;
      assets = ass;
    });
  }

  selectImage() async {
    final List<AssetEntity>ass = await AssetPicker.pickAssets(context,
        requestType: RequestType.image, maxAssets: 5, selectedAssets: assets);
    if (ass == null) {
      setState(() {
        formState = fileStatus.none;
        assets = [];
      });
      return;
    } 
    setState(() {
      formState = fileStatus.image;
      assets = ass;
    });
  }
  
  Future getVideoImage() async {
    var file = await assets[0].file;
    print(file);
    final uint8list = await VideoThumbnail.thumbnailFile(
      video: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    return uint8list;
  }

  Future<Widget> buildImageWrap() async {
    List<Widget> images = [];
    Widget content;
    for (var item in assets) {
      images.add(SizedBox(
          width: 80,
          height: 80,
          child: Image.file(
            await item.file,
            fit: BoxFit.fill,
          )));
    }
    images.add(GestureDetector(
      onTap: () {selectImage();},
      child: Container(
        width: 80,
        height: 80,
        color: Color(0xffdddddd),
        child: Icon(assets.length < 5 ? Icons.add : Icons.remove, color:Colors.white, size: 50,),
      ),
    ));
    content = Wrap(
      runAlignment: WrapAlignment.start,
      runSpacing: 10,
      spacing: 10,
      children: images,
    );
    
    return content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("发布内容")),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  constraints: BoxConstraints(
                    minHeight: 80
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: assets.length <= 0
                        ? Center(
                            child: Text.rich(
                            TextSpan(text: "上传 ", children: [
                              WidgetSpan(
                                  child: Icon(Icons.play_circle_outline,
                                      size: 20, color: Colors.blue)),
                              TextSpan(
                                  text: "一个视频 ",
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      selectCamera();
                                    }),
                              TextSpan(text: "或者 "),
                              WidgetSpan(
                                  child: Icon(Icons.insert_photo,
                                      size: 20, color: Colors.blue)),
                              TextSpan(
                                  text: "一组图片 ",
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      selectImage();
                                    })
                            ]),
                          ))
                        : Container(
                            child: formState == fileStatus.image
                                ? FutureBuilder(
                                    future: buildImageWrap(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text("未知错误"),
                                          );
                                        } else {
                                          return snapshot.data;
                                        }
                                      }
                                      return Center(
                                        child: Text("..."),
                                      );
                                    })
                                : FutureBuilder(
                                    future: getVideoImage(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      print(snapshot.data);
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text("未知错误"),
                                          );
                                        } else {
                                          return Image.asset(snapshot.data);
                                        }
                                      }
                                      return Center(
                                        child: Text("..."),
                                      );
                                    }))),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xffedecec),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      onChanged: (v) {
                        formTitle = v;
                      },
                      maxLength: 20,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "起个超好听的标题吧~",
                          hintStyle:
                              TextStyle(color: Color(0xff626262), fontSize: 14),
                          border: InputBorder.none),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Color(0xffedecec),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      onChanged: (v) {
                        formContent = v;
                      },
                      maxLines: 10,
                      decoration: InputDecoration(
                          counterText: "",
                          hintText: "这一刻的想法……",
                          hintStyle:
                              TextStyle(color: Color(0xff626262), fontSize: 14),
                          border: InputBorder.none),
                    )),
                formState == fileStatus.camera
                    ? Container(
                        margin: EdgeInsets.only(top: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: Color(0xffedecec),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                              "选择与视频关联的待领养的猫咪",
                              style: TextStyle(fontSize: 12),
                            )),
                            Text("0/个", style: TextStyle(fontSize: 12))
                          ],
                        ),
                      )
                    : Container(),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () async {
                      print(formTitle);
                      print(formContent);
                      for(var a in assets) {
                        print(a.relativePath);
                      }
                    },
                    color: Color(0xfff4cd20),
                    child: Text("发布"),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
