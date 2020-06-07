import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';


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

  FormData _data;
  @override
  void initState() {
    _data = FormData(sex: "1");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑资料"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {},
                    minWidth: 0,
                    child: Column(children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "http://a1.att.hudong.com/05/00/01300000194285122188000535877.jpg"),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.grey, BlendMode.darken)),
                        ),
                        child: Icon(
                          Icons.crop_free,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      Text(
                        "点击修改头像",
                        style: TextStyle(fontSize: 18),
                      )
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _data.nickname = value;
                        });
                      },
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                            firstDate: DateTime(DateTime.now().year - 100),
                            lastDate: DateTime(DateTime.now().year + 100),
                            locale: Locale("zh"));
                        setState(() {
                          if(a != null) {
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
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        _data.motto = value;
                      },
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
                  onPressed: () {
                    print("------------------------");
                    print("-昵称: ${_data.nickname}-");
                    print("-性别: ${_data.sex}-");
                    print("-生日: ${_data.birthday}-");
                    print("-地理位置: ${_data.areaDetail}-");
                    print("-----------");
                  },
                  color: Color(0xfff3d72f),
                  child: Text("保存", style: TextStyle(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}

class FormData {
  String avatar;
  String nickname;
  String sex;
  String birthday;
  String areaDetail;
  String motto;
  FormData(
      {this.avatar, this.nickname, this.sex, this.areaDetail, this.birthday});
}
