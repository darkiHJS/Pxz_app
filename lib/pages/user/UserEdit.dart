import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:hello_world/components/PageLoading.dart';
import 'package:hello_world/utils/Request.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UserEditPage extends StatefulWidget {
  UserEditPage({Key key}) : super(key: key);

  @override
  _UserEditPageState createState() => _UserEditPageState();
}

class _UserEditPageState extends State<UserEditPage> {
  final List sexList = [
    {"title": "小哥哥", "type": "2"},
    {"title": "小姐姐", "type": "1"}
  ];
  UserFormData _data;
  File avatarImage;
  @override
  initState() {
    initFormData();
    super.initState();
  }

  Future initFormData() async {
    var formdata = await PxzRequest().get("/member/index");
    formdata = formdata["data"];
    setState(() {
      _data = UserFormData(
          avatar: formdata["avatar"],
          nickname: formdata["nickname"],
          birthday: formdata["birhday"],
          sex: formdata["sex"] ?? "2",
          areaDetail: formdata["areaDetail"] != null
              ? formdata["areaDetail"].split
              : null,
          motto: formdata["motto"]);
    });
    return formdata;
  }

  changeAvater() async {
    final List<AssetEntity> asss = await AssetPicker.pickAssets(
      context,
      requestType: RequestType.image,
      maxAssets: 1,
    );
    if (asss.length > 0) {
      File file = await asss[0].file;
      setState(() {
        avatarImage = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑资料"),
      ),
      body: _data == null
          ? PageLoading()
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        child: MaterialButton(
                          onPressed: () {
                            changeAvater();
                          },
                          minWidth: 0,
                          child: Column(children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.fromLTRB(0, 40, 0, 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: avatarImage != null
                                        ? MemoryImage(
                                            avatarImage.readAsBytesSync())
                                        : NetworkImage(
                                            "http://a1.att.hudong.com/05/00/01300000194285122188000535877.jpg"),
                                    fit: BoxFit.cover,
                                    colorFilter: avatarImage != null
                                        ? null
                                        : ColorFilter.mode(
                                            Colors.grey, BlendMode.darken)),
                              ),
                              child: avatarImage != null
                                  ? null
                                  : Icon(
                                      Icons.crop_free,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (avatarImage != null) {
                                  setState(() {
                                    avatarImage = null;
                                  });
                                } else {
                                  changeAvater();
                                }
                              },
                              child: Text(
                                avatarImage != null ? "撤销" : "点击修改头像",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: avatarImage != null
                                        ? Colors.red
                                        : Colors.blue),
                              ),
                            ),
                          ]),
                        )),
                    Divider(
                      color: Colors.grey,
                      height: 50,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 80,
                          child: Text(
                            "昵称",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              _data.nickname = value;
                            },
                            controller: TextEditingController()
                              ..text = _data.nickname,
                            decoration: InputDecoration(
                                hintText: "请输入您的昵称",
                                hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 80,
                          child: Text(
                            "性别",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: _data.sex == "2"
                                              ? Color(0xfff3d72f)
                                              : Color(0xffdfdfdf)),
                                      borderRadius: BorderRadius.circular(50)),
                                  onPressed: () {
                                    setState(() {
                                      _data.sex = "2";
                                    });
                                  },
                                  child: Text(
                                    sexList[0]["title"],
                                    style: TextStyle(
                                        color: _data.sex == "2"
                                            ? Color(0xfff3d72f)
                                            : Color(0xffdfdfdf)),
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: _data.sex == "1"
                                              ? Color(0xfff3d72f)
                                              : Color(0xffdfdfdf)),
                                      borderRadius: BorderRadius.circular(50)),
                                  onPressed: () {
                                    setState(() {
                                      _data.sex = "1";
                                    });
                                  },
                                  child: Text(
                                    sexList[1]["title"],
                                    style: TextStyle(
                                        color: _data.sex == "1"
                                            ? Color(0xfff3d72f)
                                            : Color(0xffdfdfdf)),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 80,
                            child: Text(
                              "生日",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: GestureDetector(
                            onTap: () async {
                              var a = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate:
                                      DateTime(DateTime.now().year - 100),
                                  lastDate: DateTime(DateTime.now().year + 100),
                                  locale: Locale("zh"));
                              setState(() {
                                if (a != null) {
                                  int mill = a.millisecondsSinceEpoch;
                                  _data.birthday = mill.toString();
                                  print(_data.birthday);
                                }
                              });
                            },
                            child: Text(
                              _data.birthday == null
                                  ? "请选择生日日期"
                                  : "${DateTime.fromMillisecondsSinceEpoch(int.parse(_data.birthday)).year}/${DateTime.fromMillisecondsSinceEpoch(int.parse(_data.birthday)).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(_data.birthday)).day}",
                              style: TextStyle(
                                  color: _data.birthday == null
                                      ? Color(0xffdfdfdf)
                                      : Colors.black,
                                  fontSize: 16),
                            ),
                          )),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 80,
                            child: Text(
                              "所在地",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                CityPickers.showCityPicker(context: context)
                                    .then((value) {
                                  setState(() {
                                    _data.areaDetail =
                                        '${value.provinceName},${value.cityName},${value.areaName}';
                                  });
                                });
                              },
                              child: Text(
                                _data.areaDetail ?? "请选择所在地",
                                style: TextStyle(
                                    color: _data.areaDetail == null
                                        ? Color(0xffdfdfdf)
                                        : Colors.black,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 80,
                          child: Text(
                            "简介",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              _data.motto = value;
                            },
                            controller: TextEditingController()
                              ..text = _data.motto,
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: "请最多用二十个字介绍一下自己叭~W(￣_￣)W",
                                hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    FlatButton(
                        onPressed: () async {
                          print("------------------------");
                          print("-昵称: ${_data.nickname}-");
                          print("-性别: ${_data.sex}-");
                          print("-生日: ${_data.birthday}-");
                          print("-地理位置: ${_data.areaDetail}-");
                          print("-----------");
                          String avatarMd5;
                          // 判断是否有更新头像的需求
                          if (avatarImage != null) {
                            Response updateCell;
                            avatarMd5 = md5
                                .convert(avatarImage.readAsBytesSync())
                                .toString();
                            final String avaterFileName =
                                avatarImage.path.split("/").last;
                            final String fileType = avaterFileName.split(".").last;
                            var data = await PxzRequest()
                                .get("/console/public_trait/upload", data: {
                              "old_name": avatarImage,
                              "bucket_type": "image"
                            });
                            data = data["data"];

                            FormData fileFormData = FormData.fromMap({
                              "key": "images/$avatarMd5.$fileType",
                              "policy": data["policy"],
                              "OSSAccessKeyId": data["accessid"],
                              "success_action_status": "200",
                              "callback": data["callback"],
                              "signature": data["signature"],
                              "file": await MultipartFile.fromFile(avatarImage.path,
                                  filename: "$avatarMd5.$fileType")
                            });
                            try {
                            updateCell = await Dio()
                                .post(data["host"], data: fileFormData);
                            } on DioError catch (e) {
                              print("请求失败 --- 错误类型${e.type} $e");
                            }
                            avatarMd5 = updateCell.data["data"]["md5"];
                          }

                          // 上传用户修改内容
                        },
                        color: Color(0xfff3d72f),
                        child:
                            Text("保存", style: TextStyle(color: Colors.white)))
                  ],
                ),
              ),
            ),
    );
  }
}

class UserFormData {
  String avatar;
  String nickname;
  String sex;
  String birthday;
  String areaDetail;
  String motto;
  UserFormData(
      {this.avatar,
      this.nickname,
      this.sex,
      this.areaDetail,
      this.birthday,
      this.motto});
}
