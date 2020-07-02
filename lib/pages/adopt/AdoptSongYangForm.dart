import 'package:bot_toast/bot_toast.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/jsons/FormModelSongYang.dart';
import 'package:hello_world/utils/Request.dart';
import 'package:hello_world/utils/utils.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AdoptSongYangFormPage extends StatefulWidget {
  AdoptSongYangFormPage({Key key}) : super(key: key);

  @override
  _AdoptSongYangFormPageState createState() => _AdoptSongYangFormPageState();
}

class _AdoptSongYangFormPageState extends State<AdoptSongYangFormPage> {
  FormModelSongYang _formModelSongYang;
  FormDataSongYang _formDataSongYang = new FormDataSongYang();
  List<AssetEntity> _asset = [];
  AssetEntity _wechatNumber;
  final List _ages = [
    { "key": "1", "title": "不详" },
    { "key": "2", "title": "0-3个月" },
    { "key": "3", "title": "4-6个月" },
    { "key": "4", "title": "7-12个月" },
    { "key": "5", "title": "1岁" },
    { "key": "6", "title": "2岁" },
    { "key": "7", "title": "3岁" },
    { "key": "8", "title": "4岁" },
    { "key": "9", "title": "5岁" },
    { "key": "10", "title": "6岁" },
    { "key": "11", "title": "7岁" },
    { "key": "12", "title": "8岁" },
    { "key": "13", "title": "9岁" },
    { "key": "14", "title": "10岁" },
    { "key": "15", "title": "10岁以上" },
  ];
  // 用 接口加载 form item 去加载表单

  // 获取服务器传回的from item
  Future getFromModel() async {
    var res = await PxzRequest().get("/pet/edit");
    if (res['status'] == 'success') {
      setState(() {
        _formModelSongYang = FormModelSongYang.fromJson(res["data"]);
        if (_formDataSongYang.tags == null) _formDataSongYang.tags = [];
        if (_formDataSongYang.aboptionNeeds == null)
          _formDataSongYang.aboptionNeeds = [];
        _formDataSongYang.cateId = "1";
      });
    }
  }

  // 选择图片
  selectImage() async {
    final List<AssetEntity> ass = await AssetPicker.pickAssets(context,
        requestType: RequestType.image, maxAssets: 1);
    if (ass == null) {
      return;
    }
    int index = _asset.indexWhere((element) => element.title == ass[0].title);
    if (index == -1) {
      setState(() {
        _asset.add(ass[0]);
      });
    } else {
      BotToast.showText(text: "请不要上传重复图片");
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
    // print(_formDataSongYang.verifyForm());
    // 空置检查
    var data = await PxzRequest().post("/pet/push", data: {
      "name": _formDataSongYang.name,
      "cate_id": _formDataSongYang.cateId,
      "age": _formDataSongYang.age,
      "sex": _formDataSongYang.sex,
      "vaccine": _formDataSongYang.vaccine,
      "sterilization": _formDataSongYang.sterilization,
      "deworming": _formDataSongYang.deworming,
      "origin": _formDataSongYang.origin,
      "body_type": _formDataSongYang.bodyType,
      "hair": _formDataSongYang.hair,
      "health": _formDataSongYang.health,
      "intro": _formDataSongYang.intro,
      "area": _formDataSongYang.area,
      "addr": _formDataSongYang.addr,
      "wechat_number": _formDataSongYang.wechatNumber,
      "wechat_qrcode": _formDataSongYang.wechatQrcode,
      "mobile": _formDataSongYang.mobile,
      "resources": _formDataSongYang.resources,
      "tags": _formDataSongYang.tags,
      "adoption_needs": _formDataSongYang.aboptionNeeds,
      "pet_variety_id": _formDataSongYang.petVarietyId,
      "marketable": true
    });
    BotToast.showText(text: data["msg"]);
    if(data["status"] == "success") {
      Navigator.of(context).pop();
    }
  }

  Future<int> _showAgeSelect() {
    return showModalBottomSheet<int>(
    context: context,
    builder: (BuildContext context) {
      return ListView.builder(
        itemCount: _ages.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_ages[index]["title"]),
            onTap: () {
              setState(() {
                _formDataSongYang.age = _ages[index]["key"];
              });
              Navigator.of(context).pop(index);
            } 
          );
        },
      );
    },
  );
  }

  @override
  void initState() {
    super.initState();
    getFromModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布送养"),
      ),
      body: _formModelSongYang == null
          ? Center(
              child: Text('加载中……'),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      for (var item in _asset)
                        FutureBuilder(
                            future: updateImage(item),
                            builder: (BuildContext context,
                                AsyncSnapshot<ImageData> snapshot) {
                              int index = _asset.indexWhere(
                                  (element) => element.title == item.title);
                              Widget child = Text("");
                              if (snapshot.hasData) {
                                if (_formDataSongYang.resources ==
                                    null) // 初始化检查
                                  _formDataSongYang.resources = [];
                                if (_formDataSongYang.resources
                                        .indexOf(snapshot.data.md5) ==
                                    -1) // 防止重复添加
                                  _formDataSongYang.resources
                                      .add(snapshot.data.md5);
                                print(_formDataSongYang.resources.length);
                                child = Container(
                                  height: 80,
                                  width: 80,
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
                                width: 90,
                                height: 90,
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
                                                _formDataSongYang.resources
                                                    .removeAt(index); // 移除数据源
                                                _asset.removeAt(index); // 移除表单源
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
                            }),
                      _asset.length < 5
                          ? GestureDetector(
                              onTap: () {
                                selectImage();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 80,
                                height: 80,
                                color: Color(0xffdddddd),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ))
                          : Container()
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Text(
                      "宠物信息",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 1, child: Text("昵称")),
                        Expanded(
                            flex: 2,
                            child: TextField(
                              controller: TextEditingController()
                                ..text = _formDataSongYang.name,
                              onChanged: (v) {
                                _formDataSongYang.name = v;
                              },
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                  hintText: "请输入昵称",
                                  hintStyle: TextStyle(
                                      color: Color(0xffdfdfdf), fontSize: 14),
                                  border: InputBorder.none),
                            )),
                        Expanded(flex: 1, child: Text("月龄")),
                        Expanded(
                            flex: 2,
                            child: GestureDetector(
                              onTap: () {
                                _showAgeSelect();
                              },
                              child: Text(
                                _formDataSongYang.age == null
                                    ? "请选择月龄"
                                    : _ages[int.parse(_formDataSongYang.age) - 1]["title"],
                                style: TextStyle(
                                    fontSize: 14,
                                    color: _formDataSongYang.age == null
                                        ? Color(0xffdfdfdf)
                                        : Colors.black87),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("类别"),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          for (var item in _formModelSongYang.cate)
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: FlatButton(
                                  onPressed: () {},
                                  color: Color(
                                      _formDataSongYang.cateId == item.id
                                          ? 0xfffcf4cc
                                          : 0xfff5f2f3),
                                  child: Text(item.name,
                                      style: TextStyle(
                                        color: Color(
                                            _formDataSongYang.cateId == item.id
                                                ? 0xfff4cd20
                                                : 0xDD000000),
                                      )),
                                ))
                        ],
                      ))
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("性别"),
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          for (var item in _formModelSongYang.sex)
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      _formDataSongYang.sex = item.id;
                                    });
                                  },
                                  color: Color(_formDataSongYang.sex == item.id
                                      ? 0xfffcf4cc
                                      : 0xfff5f2f3),
                                  child: Text(item.name,
                                      style: TextStyle(
                                        color: Color(
                                            _formDataSongYang.sex == item.id
                                                ? 0xfff4cd20
                                                : 0xDD000000),
                                      ))),
                            )
                        ],
                      ))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                        child: Text("品种"),
                      ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  alignment: WrapAlignment.start,
                                  children: <Widget>[
                                    for (var item
                                        in _formModelSongYang.petVariety)
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _formDataSongYang.petVarietyId =
                                                item.id;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          color: Color(
                                              _formDataSongYang.petVarietyId ==
                                                      item.id
                                                  ? 0xfffcf4cc
                                                  : 0xfff5f2f3),
                                          child: Text(item.name,
                                              style: TextStyle(
                                                color: Color(_formDataSongYang
                                                            .petVarietyId ==
                                                        item.id
                                                    ? 0xfff4cd20
                                                    : 0xDD000000),
                                              )),
                                        ),
                                      )
                                  ])))
                    ],
                  ),

                  /// 宠物现状
                  ///
                  ///
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Text(
                      "宠物现状",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("疫苗"),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xfff6f5f5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (var item in _formModelSongYang.vaccine)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _formDataSongYang.vaccine = item.id;
                                    });
                                  },
                                  child: Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            _formDataSongYang.vaccine == item.id
                                                ? Color(0xfffcf4cc)
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            color: _formDataSongYang.vaccine ==
                                                    item.id
                                                ? Color(0xfff4cd20)
                                                : Colors.black87,
                                            fontSize: 12),
                                      )),
                                ),
                            ]),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("绝育"),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xfff6f5f5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (var item in _formModelSongYang.sterilization)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _formDataSongYang.sterilization = item.id;
                                    });
                                  },
                                  child: Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            _formDataSongYang.sterilization ==
                                                    item.id
                                                ? Color(0xfffcf4cc)
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            color: _formDataSongYang
                                                        .sterilization ==
                                                    item.id
                                                ? Color(0xfff4cd20)
                                                : Colors.black87,
                                            fontSize: 12),
                                      )),
                                ),
                            ]),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("驱虫"),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xfff6f5f5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (var item in _formModelSongYang.deworming)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _formDataSongYang.deworming = item.id;
                                    });
                                  },
                                  child: Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _formDataSongYang.deworming ==
                                                item.id
                                            ? Color(0xfffcf4cc)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            color:
                                                _formDataSongYang.deworming ==
                                                        item.id
                                                    ? Color(0xfff4cd20)
                                                    : Colors.black87,
                                            fontSize: 12),
                                      )),
                                ),
                            ]),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("来源"),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xfff6f5f5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (var item in _formModelSongYang.origin)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _formDataSongYang.origin = item.id;
                                    });
                                  },
                                  child: Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            _formDataSongYang.origin == item.id
                                                ? Color(0xfffcf4cc)
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            color: _formDataSongYang.origin ==
                                                    item.id
                                                ? Color(0xfff4cd20)
                                                : Colors.black87,
                                            fontSize: 12),
                                      )),
                                ),
                            ]),
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("体型"),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xfff6f5f5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (var item in _formModelSongYang.bodyType)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _formDataSongYang.bodyType = item.id;
                                    });
                                  },
                                  child: Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _formDataSongYang.bodyType ==
                                                item.id
                                            ? Color(0xfffcf4cc)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            color: _formDataSongYang.bodyType ==
                                                    item.id
                                                ? Color(0xfff4cd20)
                                                : Colors.black87,
                                            fontSize: 12),
                                      )),
                                ),
                            ]),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("毛发"),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xfff6f5f5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (var item in _formModelSongYang.hair)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _formDataSongYang.hair = item.id;
                                    });
                                  },
                                  child: Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 18),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: _formDataSongYang.hair == item.id
                                            ? Color(0xfffcf4cc)
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            color: _formDataSongYang.hair ==
                                                    item.id
                                                ? Color(0xfff4cd20)
                                                : Colors.black87,
                                            fontSize: 12),
                                      )),
                                ),
                            ]),
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  /// 健康状况
                  ///
                  ///
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    child: Text(
                      "健康状况",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("健康状况"),
                      ),
                      Expanded(
                          child: Container(
                        width: double.infinity,
                        height: 32,
                        decoration: BoxDecoration(
                            color: Color(0xfff6f5f5),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              for (var item in _formModelSongYang.health)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _formDataSongYang.health = item.id;
                                    });
                                  },
                                  child: Container(
                                      height: 32,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            _formDataSongYang.health == item.id
                                                ? Color(0xfffcf4cc)
                                                : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      child: Text(
                                        item.name,
                                        style: TextStyle(
                                            color: _formDataSongYang.health ==
                                                    item.id
                                                ? Color(0xfff4cd20)
                                                : Colors.black87,
                                            fontSize: 12),
                                      )),
                                ),
                            ]),
                      ))
                    ],
                  ),

                  /// 宠物特点
                  ///
                  ///
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "宠物特点",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "  (最多选择3个选填)",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 4.0,
                      runSpacing: 4.0,
                      children: <Widget>[
                        for (var item in _formModelSongYang.petTag)
                          MaterialButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              var index =
                                  _formDataSongYang.tags.indexOf(item.id);
                              setState(() {
                                if (index == -1) {
                                  if (_formDataSongYang.tags.length >= 3)
                                    return;
                                  _formDataSongYang.tags.add(item.id);
                                } else {
                                  _formDataSongYang.tags.removeAt(index);
                                }
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                  color:
                                      _formDataSongYang.tags.indexOf(item.id) !=
                                              -1
                                          ? Color(0xfff4cd20)
                                          : Colors.black26),
                            ),
                            child: Text(
                              item.name,
                              style: TextStyle(
                                  color:
                                      _formDataSongYang.tags.indexOf(item.id) !=
                                              -1
                                          ? Color(0xfff4cd20)
                                          : Colors.black45),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Color(0xffe1e1e1),
                    ),
                    child: TextField(
                        onChanged: (v) {
                          _formDataSongYang.intro = v;
                        },
                        style: TextStyle(fontSize: 14),
                        minLines: 8,
                        maxLines: 10086,
                        controller: TextEditingController()
                          ..text = _formDataSongYang.intro,
                        decoration: InputDecoration(
                            hintText: "它的故事……",
                            hintStyle: TextStyle(
                                color: Color(0xff626262), fontSize: 14),
                            border: InputBorder.none,
                            counterText: "")),
                  ),

                  /// 领养要求
                  ///
                  ///
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Text(
                      "领养要求",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: <Widget>[
                        for (var item in _formModelSongYang.adoptionNeeds)
                          AdoptSongYangFormCheckBox(
                            onTap: () {
                              var index = _formDataSongYang.aboptionNeeds
                                  .indexOf(item.id);
                              setState(() {
                                if (index == -1) {
                                  _formDataSongYang.aboptionNeeds.add(item.id);
                                } else {
                                  _formDataSongYang.aboptionNeeds
                                      .removeAt(index);
                                }
                              });
                            },
                            state: _formDataSongYang.aboptionNeeds
                                    .indexOf(item.id) !=
                                -1,
                            title: Text(item.name),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Text(
                      "联系方式",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 50,
                              child: Text("地址"),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Color(0xffe1e1e1),
                                  borderRadius: BorderRadius.circular(3)),
                              width: 250,
                              child: GestureDetector(
                                onTap: () {
                                  CityPickers.showCityPicker(context: context)
                                      .then((value) {
                                    setState(() {
                                      _formDataSongYang.area = [
                                        value.provinceName,
                                        value.cityName,
                                        value.areaName
                                      ];
                                    });
                                  });
                                },
                                child: Text(
                                  _formDataSongYang.area != null
                                      ? "${_formDataSongYang.area[0]} ${_formDataSongYang.area[1]} ${_formDataSongYang.area[2]}"
                                      : "请选择所在地",
                                  style: TextStyle(
                                      color: _formDataSongYang.area == null
                                          ? Color(0xff626262)
                                          : Colors.black,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 60,
                            ),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffe1e1e1),
                              ),
                              child: TextField(
                                  onChanged: (v) {
                                    _formDataSongYang.addr = v;
                                  },
                                  style: TextStyle(fontSize: 12),
                                  minLines: 2,
                                  maxLines: 5,
                                  controller: TextEditingController()
                                    ..text = _formDataSongYang.addr,
                                  decoration: InputDecoration(
                                      hintText: "详细地址: 如道路、门牌号、小区、楼栋号、单元室等",
                                      hintStyle: TextStyle(
                                          color: Color(0xff626262),
                                          fontSize: 12),
                                      border: InputBorder.none,
                                      counterText: "")),
                            ))
                          ],
                        )
                      ],
                    ),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xffe1e1e1),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      width: 150,
                                      child: TextField(
                                        onChanged: (v) {
                                          _formDataSongYang.mobile = v;
                                        },
                                        controller: TextEditingController()
                                          ..text = _formDataSongYang.mobile,
                                        keyboardType: TextInputType.phone,
                                        style: TextStyle(fontSize: 12),
                                        decoration: InputDecoration(
                                            hintText: "手机联系方式",
                                            hintStyle: TextStyle(
                                                color: Color(0xff626262),
                                                fontSize: 12),
                                            border: InputBorder.none,
                                            counterText: "",
                                            fillColor: Color(0xffe1e1e1)),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Color(0xffe1e1e1),
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      width: 150,
                                      child: TextField(
                                        onChanged: (v) {
                                          _formDataSongYang.wechatNumber = v;
                                        },
                                        controller: TextEditingController()
                                          ..text =
                                              _formDataSongYang.wechatNumber,
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
                                          color: Color(0xffe1e1e1),
                                          borderRadius:
                                              BorderRadius.circular(3)),
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
                                      _formDataSongYang.wechatQrcode =
                                          snapshot.data.md5;
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
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.blue),
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
                                                      _formDataSongYang
                                                          .wechatQrcode = null;
                                                      _wechatNumber = null;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50)),
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
                  SizedBox(
                    height: 80,
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
                              "发布",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      )),
                ],
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
