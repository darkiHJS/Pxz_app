import 'dart:io';
import 'dart:typed_data';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:hello_world/utils/Request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:crypto/crypto.dart';
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
  String formTitle = "";
  String formContent = "";
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
    final List<AssetEntity> ass = await AssetPicker.pickAssets(context,
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
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File newFile = new File("$tempPath/video");
    if (!newFile.existsSync()) {
      newFile.createSync();
    }
    newFile.writeAsBytesSync(await file.readAsBytes());

    final uint8list = await VideoThumbnail.thumbnailData(
        video: newFile.path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 400,
        quality: 100);

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
      onTap: () {
        selectImage();
      },
      child: Container(
        width: 80,
        height: 80,
        color: Color(0xffdddddd),
        child: Icon(
          assets.length < 5 ? Icons.add : Icons.remove,
          color: Colors.white,
          size: 50,
        ),
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
                    constraints: BoxConstraints(minHeight: 80),
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
                                    // 视频展示框架
                                    future: getVideoImage(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasError) {
                                          return Center(
                                            child: Text("未知错误"),
                                          );
                                        } else {
                                          return Stack(
                                            alignment:
                                                AlignmentDirectional.center,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 10, 10, 0),
                                                height: 100,
                                                width: 100,
                                                alignment:
                                                    AlignmentDirectional.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                      image: MemoryImage(
                                                          snapshot.data),
                                                      fit: BoxFit.fitWidth),
                                                ),
                                                child: Icon(
                                                    Icons.play_circle_outline,
                                                    size: 40,
                                                    color: Colors.white),
                                              ),
                                              Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        formState =
                                                            fileStatus.none;
                                                        assets = [];
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                    ),
                                                  ))
                                            ],
                                          );
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
                      List<String> fileMd5List = [];
                      String sltUpdateMd5;
                      // 判断标题 想法是否填写 判断图片是否存在
                      if (assets.length <= 0) {
                        BotToast.showText(text: "上传一个视频或者图片内容吧~");
                        return;
                      }
                      if (formTitle == "") {
                        BotToast.showText(
                          text: "赶快取一个好听的标题吧！",
                        );
                        return;
                      }
                      if (formContent == "") {
                        BotToast.showText(text: "把想法写出来吧~");
                        return;
                      }
                      var loading = BotToast.showLoading();
                      if (formState == fileStatus.image) {
                        for (AssetEntity ass in assets) {
                          File file = await ass.file;
                          Response updateCell;
                          // 跟服务器打申请
                          var data = await PxzRequest().get(
                            "/console/public_trait/upload",
                            data: {
                              "old_name": ass.title,
                              "bucket_type": "image"
                            },
                          );
                          data = data["data"];
                          // 复制到临时目录，重命名，上传到阿里服务器
                          String fileMd5 =
                              md5.convert(await file.readAsBytes()).toString();
                          List<String> nameAndType = ass.title.split(".");
                          Directory tempDir = await getTemporaryDirectory();
                          String tempPath = tempDir.path;
                          File newFile = File(
                              "$tempPath/photo/$fileMd5.${nameAndType[1]}");
                          if (!newFile.existsSync()) {
                            newFile.createSync(recursive: true);
                          }
                          newFile.writeAsBytesSync(await file.readAsBytes());
                          FormData fileFormData = FormData.fromMap({
                            "key": "images/$fileMd5.${nameAndType[1]}",
                            "policy": data["policy"],
                            "OSSAccessKeyId": data["accessid"],
                            "success_action_status": "200",
                            "callback": data["callback"],
                            "signature": data["signature"],
                            "file": await MultipartFile.fromFile(newFile.path,
                                filename: "$fileMd5.${nameAndType[1]}")
                          });
                          try {
                            updateCell = await Dio()
                                .post(data["host"], data: fileFormData);
                          } on DioError catch (e) {
                            print("请求失败 --- 错误类型${e.type} $e");
                          }
                          fileMd5List.add(updateCell.data["data"]["md5"]);
                        }
                      } else {
                        File file = await assets[0].file;
                        Response updateCell;

                        var data = await PxzRequest().get(
                          "/console/public_trait/upload",
                          data: {
                            "old_name": assets[0].title,
                            "bucket_type": "video"
                          },
                        );
                        data = data["data"];
                        String fileMd5 =
                            md5.convert(await file.readAsBytes()).toString();
                        List<String> nameAndType = assets[0].title.split(".");
                        Directory tempDir = await getTemporaryDirectory();
                        String tempPath = tempDir.path;
                        File newFile =
                            File("$tempPath/photo/$fileMd5.${nameAndType[1]}");
                        if (!newFile.existsSync()) {
                          newFile.createSync(recursive: true);
                        }
                        newFile.writeAsBytesSync(await file.readAsBytes());
                        FormData fileFormData = FormData.fromMap({
                          "key": "videos/$fileMd5.${nameAndType[1]}",
                          "policy": data["policy"],
                          "OSSAccessKeyId": data["accessid"],
                          "success_action_status": "200",
                          "callback": data["callback"],
                          "signature": data["signature"],
                          "file": await MultipartFile.fromFile(newFile.path,
                              filename: "$fileMd5.${nameAndType[1]}")
                        });
                        try {
                          updateCell = await Dio()
                              .post(data["host"], data: fileFormData);
                        } on DioError catch (e) {
                          print("请求失败 --- 错误类型${e.type} $e");
                        }
                        fileMd5List.add(updateCell.data["data"]["md5"]);
                        //  上传视频缩略图

                        // 获得视频缩略图的md5
                        Uint8List slt = await getVideoImage();
                        String sltMd5 = md5.convert(slt).toString();
                        Response sltRp;

                        File newSltFile = File("$tempPath/photo/$sltMd5.jpg");
                        if (!newSltFile.existsSync()) {
                          newSltFile.createSync(recursive: true);
                        }
                        newSltFile.writeAsBytesSync(slt);
                        var utData = await PxzRequest().get(
                          "/console/public_trait/upload",
                          data: {
                            "old_name": "$sltMd5.jpg",
                            "bucket_type": "image"
                          },
                        );
                        utData = utData["data"];
                        FormData sltData = FormData.fromMap({
                          "key": "images/$sltMd5.jpg",
                          "policy": utData["policy"],
                          "OSSAccessKeyId": utData["accessid"],
                          "success_action_status": "200",
                          "callback": utData["callback"],
                          "signature": utData["signature"],
                          "file": await MultipartFile.fromFile(newSltFile.path,
                              filename: "$sltMd5.jpg")
                        });
                        try {
                          sltRp = await Dio()
                              .post(utData["host"], data: sltData);
                          var d = sltRp.data["data"];
                          print(d["md5"]);
                          sltUpdateMd5 = d["md5"];
                        } on DioError catch (e) {
                          print("请求失败 --- 错误类型${e.type} $e");
                        }
                      }
                      try {
                        var data = {
                          "title": formTitle, // 文章标题
                          "desc": formContent, // 详情
                          "resources": fileMd5List // 资源列表
                        };
                        if(formState == fileStatus.camera) {
                          data["main_default_id"] = sltUpdateMd5;
                        }
                        PxzRequest().post("/rescue/add", data: data).then((d) {
                          print(d);
                          if (d["status"] == "success") {
                            BotToast.showText(
                              text: "内容发布成功。",
                            );
                            Navigator.popAndPushNamed(context, "/");
                          } else {
                            BotToast.showText(
                              text: "内容发布失败。原因: ${d["msg"]}",
                            );
                          }
                        });
                        loading();
                      } on DioError catch (_) {
                        BotToast.showText(
                          text: "内容发布失败",
                        );
                        loading();
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
