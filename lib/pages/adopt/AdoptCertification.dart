import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';
import 'package:hello_world/utils/utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AdoptCertificationPage extends StatefulWidget {
  AdoptCertificationPage({Key key}) : super(key: key);

  @override
  _AdoptCertificationPageState createState() => _AdoptCertificationPageState();
}

class _AdoptCertificationPageState extends State<AdoptCertificationPage> {
  AssetEntity _idCardFront;
  AssetEntity _idCardReverse;
  IdCard _idCard = IdCard();

  selectIdCardFront() async {
    final List<AssetEntity> ass = await AssetPicker.pickAssets(context,
        requestType: RequestType.image, maxAssets: 1);
    if (ass == null) {
      return;
    }
    setState(() {
      _idCardFront = ass[0];
    });
  }
  
  selectIdCardReverse() async {
    final List<AssetEntity> ass = await AssetPicker.pickAssets(context,
        requestType: RequestType.image, maxAssets: 1);
    if (ass == null) {
      return;
    }
    setState(() {
      _idCardReverse = ass[0];
    });
  }
  //上传信息
  submitForm() async {
    var data = await PxzRequest().post(
      "/member/certification",
      data: {
        "username": _idCard.name,
        "identifynum": _idCard.id,
        "p_ident": _idCard.pIdent,
        "r_ident": _idCard.rIdent
      }
    );
    if(data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
    }else {
       
    }
  }
  // 上传图片
  Future<ImageData> updateImage(AssetEntity ass) async {
    ImageData img;
    img = await updateAssetsToAliyun(ass, "image");
    return img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("实名认证"),
        ),
        body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "上传身份证照片",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        _idCardFront == null ? 
                        GestureDetector(
                          onTap: () {
                            selectIdCardFront();
                          },
                          child: Image.asset("assets/adopt/idCard-1.png")
                        ) : 
                        FutureBuilder(
                          future: updateImage(_idCardFront),
                          builder: (BuildContext context, AsyncSnapshot<ImageData> snapshot) {
                            Widget child = Text("");
                            if (snapshot.hasData) {
                              _idCard.pIdent = snapshot.data.md5;
                              child = Container(
                                child: Image.network(
                                  snapshot.data.url,
                                  fit: BoxFit.cover
                                ),
                              );
                            } else if (snapshot.hasError) {
                              BotToast.showText(text: "图片上传失败");
                            } else {
                              child = Container(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey[200],
                                  valueColor:
                                    AlwaysStoppedAnimation(Colors.blue),
                                ));
                            }
                            return Container(
                              height: 110,
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: child,
                            );
                          }
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("身份证正面")
                      ],
                    ),
                  ),
                  SizedBox(width: 5,),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        selectIdCardReverse();
                      },
                      child: Column(
                      children: <Widget>[
                        _idCardReverse == null ? 
                        Image.asset("assets/adopt/idCard-2.png")
                        : 
                        FutureBuilder(
                          future: updateImage(_idCardReverse),
                          builder: (BuildContext context, AsyncSnapshot<ImageData> snapshot) {
                            Widget child = Text("");
                            if (snapshot.hasData) {
                              _idCard.rIdent = snapshot.data.md5;
                              child = Container(
                                child: Image.network(
                                  snapshot.data.url,
                                  fit: BoxFit.cover
                                ),
                              );
                            } else if (snapshot.hasError) {
                              BotToast.showText(text: "图片上传失败");
                            } else {
                              child = Container(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.grey[200],
                                  valueColor:
                                    AlwaysStoppedAnimation(Colors.blue),
                                ));
                            }
                            return Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 110,
                              child: child,
                            );
                          }
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("身份证反面")
                      ],
                    ),
                  ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.error_outline,
                      size: 20,
                      color: Color(0xffffba00),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Text(
                            "证件必须是清晰彩色原件电子版本。可以是扫描件或者数码拍摄照片。仅支持jpg、png、jpeg的图片格式。",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff999999))))
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                    width: 300,
                    height: 40,
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        color: Color(0xfff4cd20),
                        onPressed: () {
                          submitForm();
                        },
                        child: Text(
                          "提交审核",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class IdCard {
  String name;
  String id;
  String pIdent;
  String rIdent;
}