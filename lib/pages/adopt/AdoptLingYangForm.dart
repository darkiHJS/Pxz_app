import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AdoptLingYangFormPage extends StatefulWidget {
  AdoptLingYangFormPage({Key key}) : super(key: key);

  @override
  _AdoptLingYangFormPageState createState() => _AdoptLingYangFormPageState();
}

class _AdoptLingYangFormPageState extends State<AdoptLingYangFormPage> {
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: 200,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                color: Color(0xfff6f5f5),
                child: Row(
                  children: <Widget>[
                    Text("         省"),
                    Text("         市"),
                    Text("         区"),
                  ],
                ),
              ),
              Text(
                "性别",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("男孩"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("女孩"),
                    ),
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
                  spacing: 10,
                  children: <Widget>[
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("18岁以下"),
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("18~25"),
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("26~30"),
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("31~40"),
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("41~50"),
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("51~60"),
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("60以上"),
                    ),
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
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("有"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    FlatButton(
                      color: Color(0xfff6f5f5),
                      onPressed: () {},
                      child: Text("无"),
                    ),
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("200~300"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("300~500"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("500~800"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("1000+"),
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("高中"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("大学"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("国企"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("私企"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("自由职业"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("创业"),
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("自己整租"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("合租单间"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("自有房"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("父母同住"),
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("已婚"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("未婚"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("离异"),
                      ),
                    ),
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
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("手机号"),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xfff6f5f5),
                                    borderRadius: BorderRadius.circular(3)),
                                width: 150,
                                child: TextField(
                                  decoration: null,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text("微信号"),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xfff6f5f5),
                                    borderRadius: BorderRadius.circular(3)),
                                width: 150,
                                child: TextField(
                                  decoration: null,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 30),
                          padding: EdgeInsets.all(10),
                          alignment: AlignmentDirectional.center,
                          decoration: BoxDecoration(
                              color: Color(0xfff6f5f5),
                              borderRadius: BorderRadius.circular(3)),
                          width: 90,
                          height: 90,
                          child: Text(
                            "请提交一张微信二维码",
                            style: TextStyle(fontSize: 12),
                          ))
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("同意"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("不同意"),
                      ),
                    ),
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("有"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("没有"),
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
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("同意"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        alignment: AlignmentDirectional.center,
                        color: Color(0xfff6f5f5),
                        width: 80,
                        child: Text("不同意"),
                      ),
                    ),
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
                    AdoptSongYangFormCheckBox(
                      value: false,
                      title: Text("离婚或分手"),
                    ),
                    AdoptSongYangFormCheckBox(
                      value: true,
                      title: Text("家人生病"),
                    ),
                    AdoptSongYangFormCheckBox(
                      value: false,
                      title: Text("搬家"),
                    ),
                    AdoptSongYangFormCheckBox(
                      value: false,
                      title: Text("怀孕"),
                    ),
                    AdoptSongYangFormCheckBox(
                      value: false,
                      title: Text("离职"),
                    ),
                    AdoptSongYangFormCheckBox(
                      value: false,
                      title: Text("猫咪破坏家具"),
                    ),
                    AdoptSongYangFormCheckBox(
                      value: false,
                      title: Text("猫咪具有破坏行为或有不友好表现"),
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
                        onPressed: () {},
                        child: Text("提交", style: TextStyle(fontSize: 20),)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class AdoptSongYangFormCheckBox extends StatefulWidget {
  bool value;
  Widget title;
  Function(bool) onChanged;

  AdoptSongYangFormCheckBox(
      {Key key, this.title, @required this.value, this.onChanged})
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
        setState(() {
          widget.value = !widget.value;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: 18,
              height: 18,
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: widget.value ? Color(0xfff4cd20) : Colors.transparent,
                  border: Border.all(color: Color(0xff626262), width: 1),
                  borderRadius: BorderRadius.circular(6))),
          SizedBox(
            width: 3,
          ),
          widget.title
        ],
      ),
    );
  }
}
