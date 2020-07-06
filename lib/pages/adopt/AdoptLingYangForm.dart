import 'package:bot_toast/bot_toast.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hello_world/jsons/FormModelLingYang.dart';
import 'package:hello_world/utils/Request.dart';
import 'package:hello_world/utils/utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AdoptLingYangFormPage extends StatefulWidget {
  AdoptLingYangFormPage({Key key}) : super(key: key);
  @override
  _AdoptLingYangFormPageState createState() => _AdoptLingYangFormPageState();
}

class _AdoptLingYangFormPageState extends State<AdoptLingYangFormPage> {
  final FormModelLingYang _formModelLingYang = FormModelLingYang();
  FormDataLingyang _dataLingyang = FormDataLingyang();
  List<ItemLingYang> _abandon = [];
  AssetEntity _wechatNumber;

  // 请求不寄养原因
  Future getReason() async {
    var res = await PxzRequest().get("/give_up/index");
    if (res["status"] == "success") {
      print(res);
      res["data"].forEach((e) {
        _abandon.add(ItemLingYang(id: e["id"], title: e["name"]));
      });
      setState(() {});
    }
  }

  // 选择微信二维码
  selectWechatQR() async {
    final List<AssetEntity> ass = await AssetPicker.pickAssets(context,
        requestType: RequestType.image, maxAssets: 1);
    if (ass == null) {
      return;
    }
    setState(() {
      _wechatNumber = ass[0];
    });
  }

  // 上传图片
  Future<ImageData> updateImage(AssetEntity ass) async {
    ImageData img;
    img = await updateAssetsToAliyun(ass, "image");
    return img;
  }

  // submit form
  submitForm() async {
    // print(_dataLingyang.verifyForm());
    // 空置检查
    var from = {
      "occupation": _dataLingyang.occupation, // 职业
      "contact": _dataLingyang.contact, // 联系方式
      "age": _dataLingyang.age, // 年龄
      "sex": _dataLingyang.sex, // 性别
      "wechat": _dataLingyang.wechat,
      "wechat_img": _dataLingyang.wechatImg,
      "experience": _dataLingyang.experience,
      "livi_environment": _dataLingyang.liviEnvironment,
      "marriage": _dataLingyang.marriage,
      "family_consent": _dataLingyang.familyConsent,
      "allergy": _dataLingyang.allergy,
      "paid": _dataLingyang.paid,
      "area": _dataLingyang.area,
      "budget": _dataLingyang.budget,
      "give_up": _dataLingyang.giveUp
    };
    var data = await PxzRequest().post("/member_pexp/add", data: from);
    print(data);
    BotToast.showText(text: data["msg"]);
    if (data["status"] == "success") {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    getReason();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("领养申请信息填写")),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "所在城市",
                style: TextStyle(fontSize: 18),
              ),
              GestureDetector(
                  onTap: () {
                    CityPickers.showCityPicker(context: context).then((value) {
                      setState(() {
                        _dataLingyang.area = [
                          value.provinceName,
                          value.cityName,
                          value.areaName
                        ];
                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    color: Color(0xfff6f5f5),
                    child: Text(
                      _dataLingyang.area != null
                          ? "${_dataLingyang.area[0]} ${_dataLingyang.area[1]} ${_dataLingyang.area[2]}"
                          : "请选择所在城市",
                      style: TextStyle(
                          color: _dataLingyang.area == null
                              ? Color(0xff626262)
                              : Colors.black,
                          fontSize: 16),
                    ),
                  )),
              Text(
                "性别",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    for (var item in _formModelLingYang.sex)
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: FlatButton(
                          color: _dataLingyang.sex == item.id
                              ? Color(0xfff4cd20)
                              : Color(0xfff6f5f5),
                          onPressed: () {
                            setState(() {
                              _dataLingyang.sex = item.id;
                            });
                          },
                          child: Text(item.title),
                        ),
                      )
                  ],
                ),
              ),
              Text(
                "年龄",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  children: <Widget>[
                    for (var item in _formModelLingYang.age)
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: FlatButton(
                          color: _dataLingyang.age == item.id
                              ? Color(0xfff4cd20)
                              : Color(0xfff6f5f5),
                          onPressed: () {
                            setState(() {
                              _dataLingyang.age = item.id;
                            });
                          },
                          child: Text(item.title),
                        ),
                      )
                  ],
                ),
              ),
              Text(
                "养宠经验",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.experience
                            ? Color(0xfff4cd20)
                            : Color(0xfff6f5f5),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.experience = true;
                          });
                        },
                        child: Text("有"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.experience
                            ? Color(0xfff6f5f5)
                            : Color(0xfff4cd20),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.experience = false;
                          });
                        },
                        child: Text("无"),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "养宠预算",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for (var item in _formModelLingYang.budget)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _dataLingyang.budget = item.id;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          alignment: AlignmentDirectional.center,
                          color: _dataLingyang.budget == item.id
                              ? Color(0xfff4cd20)
                              : Color(0xfff6f5f5),
                          width: 80,
                          child: Text(item.title),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                "职业",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    for (var item in _formModelLingYang.occupation)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _dataLingyang.occupation = item.id;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          alignment: AlignmentDirectional.center,
                          color: _dataLingyang.occupation == item.id
                              ? Color(0xfff4cd20)
                              : Color(0xfff6f5f5),
                          width: 80,
                          child: Text(item.title),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                "住房情况",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    for (var item in _formModelLingYang.liviEnvironment)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _dataLingyang.liviEnvironment = item.id;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          alignment: AlignmentDirectional.center,
                          color: _dataLingyang.liviEnvironment == item.id
                              ? Color(0xfff4cd20)
                              : Color(0xfff6f5f5),
                          width: 80,
                          child: Text(item.title),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                "婚姻情况",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.marriage
                            ? Color(0xfff4cd20)
                            : Color(0xfff6f5f5),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.marriage = true;
                          });
                        },
                        child: Text("已婚"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.marriage
                            ? Color(0xfff6f5f5)
                            : Color(0xfff4cd20),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.marriage = false;
                          });
                        },
                        child: Text("未婚"),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "联系方式",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 50,
                                  child: Text("手机"),
                                ),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff6f5f5),
                                      borderRadius: BorderRadius.circular(3)),
                                  width: 150,
                                  child: TextField(
                                    onChanged: (v) {
                                      _dataLingyang.contact = v;
                                    },
                                    controller: TextEditingController()
                                      ..text = _dataLingyang.contact,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                        hintText: "手机联系方式",
                                        hintStyle: TextStyle(
                                            color: Color(0xff626262),
                                            fontSize: 12),
                                        border: InputBorder.none,
                                        counterText: "",
                                        fillColor: Color(0xfff6f5f5)),
                                  ),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 50,
                                  child: Text("微信"),
                                ),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      color: Color(0xfff6f5f5),
                                      borderRadius: BorderRadius.circular(3)),
                                  width: 150,
                                  child: TextField(
                                    onChanged: (v) {
                                      _dataLingyang.wechat = v;
                                    },
                                    controller: TextEditingController()
                                      ..text = _dataLingyang.wechat,
                                    style: TextStyle(fontSize: 12),
                                    decoration: InputDecoration(
                                      hintText: "微信联系方式",
                                      hintStyle: TextStyle(
                                          color: Color(0xff626262),
                                          fontSize: 12),
                                      border: InputBorder.none,
                                      counterText: "",
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _wechatNumber == null
                          ? GestureDetector(
                              onTap: () {
                                selectWechatQR();
                              },
                              child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  padding: EdgeInsets.all(20),
                                  alignment: AlignmentDirectional.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xfff6f5f5),
                                      borderRadius: BorderRadius.circular(3)),
                                  width: 105,
                                  height: 105,
                                  child: Text(
                                    "请提交一张微信二维码",
                                    style: TextStyle(fontSize: 12),
                                  )))
                          : FutureBuilder(
                              future: updateImage(_wechatNumber),
                              builder: (BuildContext context,
                                  AsyncSnapshot<ImageData> snapshot) {
                                Widget child = Text("");
                                if (snapshot.hasData) {
                                  _dataLingyang.wechatImg = snapshot.data.md5;
                                  child = Container(
                                    height: 90,
                                    width: 90,
                                    child: Image.network(
                                      snapshot.data.url,
                                      fit: BoxFit.cover,
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
                                  margin: EdgeInsets.only(left: 10),
                                  width: 105,
                                  height: 105,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      child,
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _dataLingyang.wechatImg =
                                                      null;
                                                  _wechatNumber = null;
                                                });
                                              },
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              )))
                                    ],
                                  ),
                                );
                              })
                    ],
                  )),
              Text(
                "家人(朋友)是否养同意宠物",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.familyConsent
                            ? Color(0xfff4cd20)
                            : Color(0xfff6f5f5),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.familyConsent = true;
                          });
                        },
                        child: Text("同意"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.familyConsent
                            ? Color(0xfff6f5f5)
                            : Color(0xfff4cd20),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.familyConsent = false;
                          });
                        },
                        child: Text("不同意"),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "家人(朋友)是否有宠物过敏史",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    for (var item in _formModelLingYang.allergy)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _dataLingyang.allergy = item.id;
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                          alignment: AlignmentDirectional.center,
                          color: _dataLingyang.allergy == item.id
                              ? Color(0xfff4cd20)
                              : Color(0xfff6f5f5),
                          width: 80,
                          child: Text(item.title),
                        ),
                      ),
                  ],
                ),
              ),
              Text(
                "是否赞同有偿领养",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.paid
                            ? Color(0xfff4cd20)
                            : Color(0xfff6f5f5),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.paid = true;
                          });
                        },
                        child: Text("同意"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: FlatButton(
                        color: _dataLingyang.paid
                            ? Color(0xfff6f5f5)
                            : Color(0xfff4cd20),
                        onPressed: () {
                          setState(() {
                            _dataLingyang.paid = false;
                          });
                        },
                        child: Text("不同意"),
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "以下哪些原因会使你放弃继续养它",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 10,
                  children: <Widget>[
                    for (var item in _abandon)
                      AdoptSongYangFormCheckBox(
                        onTap: () {
                          var index = _dataLingyang.giveUp.indexOf(item.id);
                          setState(() {
                            if (index == -1) {
                              _dataLingyang.giveUp.add(item.id);
                            } else {
                              _dataLingyang.giveUp.removeAt(index);
                            }
                          });
                        },
                        state: _dataLingyang.giveUp.indexOf(item.id) != -1,
                        title: Text(item.title),
                      ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 60),
                  alignment: AlignmentDirectional.center,
                  child: SizedBox(
                    width: 180,
                    height: 50,
                    child: FlatButton(
                        color: Color(0xfff3d72f),
                        onPressed: () {
                          submitForm();
                        },
                        child: Text(
                          "提交",
                          style: TextStyle(fontSize: 20),
                        )),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class AdoptSongYangFormCheckBox extends StatefulWidget {
  bool state;
  Widget title;
  Function onTap;

  AdoptSongYangFormCheckBox(
      {Key key, this.title, @required this.state, this.onTap})
      : super(key: key);

  @override
  _AdoptSongYangFormCheckBoxState createState() =>
      _AdoptSongYangFormCheckBoxState();
}

class _AdoptSongYangFormCheckBoxState extends State<AdoptSongYangFormCheckBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap();
        },
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  width: 18,
                  height: 18,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color:
                          widget.state ? Color(0xfff4cd20) : Colors.transparent,
                      border: Border.all(color: Color(0xff626262), width: 1),
                      borderRadius: BorderRadius.circular(6))),
              SizedBox(
                width: 3,
              ),
              widget.title
            ],
          ),
        ));
  }
}
