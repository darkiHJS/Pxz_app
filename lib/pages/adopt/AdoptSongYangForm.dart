import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';

class AdoptSongYangFormPage extends StatefulWidget {
  AdoptSongYangFormPage({Key key}) : super(key: key);

  @override
  _AdoptSongYangFormPageState createState() => _AdoptSongYangFormPageState();
}

class _AdoptSongYangFormPageState extends State<AdoptSongYangFormPage> {

  // 用 接口加载 form item 去加载表单

  // 获取服务器传回的from item
  Future getFromModel() async{
    var res = await PxzRequest().get("/pet/edit");
    print(res);
  }

  @override
  void initState() {
    super.initState();
    print(1);
    getFromModel();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("发布送养"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 80,
                  color: Colors.black54,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: Text(
                "宠物信息",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        decoration: InputDecoration(
                            hintText: "请输入昵称",
                            hintStyle: TextStyle(
                                color: Color(0xffdfdfdf), fontSize: 14),
                            border: InputBorder.none),
                      )),
                  Expanded(flex: 1, child: Text("年龄")),
                  Expanded(
                      flex: 2,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "请选择年龄",
                            hintStyle: TextStyle(
                                color: Color(0xffdfdfdf), fontSize: 14),
                            border: InputBorder.none),
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                      FlatButton(
                          onPressed: () {},
                          color: Color(0xfff5f2f3),
                          child: Text("狗狗")),
                      FlatButton(
                          onPressed: () {},
                          color: Color(0xfffcf4cc),
                          child: Text(
                            "猫咪",
                            style: TextStyle(color: Color(0xfff4cd20)),
                          )),
                      FlatButton(
                          onPressed: () {},
                          color: Color(0xfff5f2f3),
                          child: Text("其他")),
                    ]))
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                      FlatButton(
                          onPressed: () {},
                          color: Color(0xfff5f2f3),
                          child: Text("男孩")),
                      FlatButton(
                          onPressed: () {},
                          color: Color(0xfffcf4cc),
                          child: Text(
                            "女孩",
                            style: TextStyle(color: Color(0xfff4cd20)),
                          )),
                      FlatButton(
                          onPressed: () {},
                          color: Color(0xfff5f2f3),
                          child: Text("未知")),
                    ]))
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
                    child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: <Widget>[
                      SizedBox(
                        width: 80,
                        child: FlatButton(
                            onPressed: () {},
                            color: Color(0xfff5f2f3),
                            child: Text("黑白")),
                      ),
                      SizedBox(
                        width: 80,
                        child: FlatButton(
                            onPressed: () {},
                            color: Color(0xfff5f2f3),
                            child: Text("纯白")),
                      ),
                      SizedBox(
                        width: 80,
                        child: FlatButton(
                            onPressed: () {},
                            color: Color(0xfff5f2f3),
                            child: Text("纯黑")),
                      ),
                      SizedBox(
                        width: 80,
                        child: FlatButton(
                            onPressed: () {},
                            color: Color(0xfff5f2f3),
                            child: Text("橘白")),
                      ),
                      SizedBox(
                        width: 80,
                        child: FlatButton(
                            onPressed: () {},
                            color: Color(0xfff5f2f3),
                            child: Text("未知")),
                      ),
                    ]))
              ],
            ),

            /// 宠物现状
            ///
            ///
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
              child: Text(
                "宠物现状",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xfffcf4cc),
                              child: Text(
                                "已接种",
                                style: TextStyle(
                                    color: Color(0xfff4cd20), fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "接种中",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "未接种",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "不详",
                                style: TextStyle(fontSize: 12),
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
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xfffcf4cc),
                              child: Text(
                                "已绝育",
                                style: TextStyle(
                                    color: Color(0xfff4cd20), fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "未绝育",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "不详",
                                style: TextStyle(fontSize: 12),
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
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xfffcf4cc),
                              child: Text(
                                "已驱虫",
                                style: TextStyle(
                                    color: Color(0xfff4cd20), fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "未驱虫",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "不详",
                                style: TextStyle(fontSize: 12),
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
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xfffcf4cc),
                              child: Text(
                                "个人救助",
                                style: TextStyle(
                                    color: Color(0xfff4cd20), fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "救助站",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "家养",
                                style: TextStyle(fontSize: 12),
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
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xfffcf4cc),
                              child: Text(
                                "大型",
                                style: TextStyle(
                                    color: Color(0xfff4cd20), fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "中型",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "小型",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "迷你",
                                style: TextStyle(fontSize: 12),
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
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xfffcf4cc),
                              child: Text(
                                "长毛",
                                style: TextStyle(
                                    color: Color(0xfff4cd20), fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "短毛",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "卷毛",
                                style: TextStyle(fontSize: 12),
                              )),
                        ),
                        SizedBox(
                          width: 80,
                          height: 32,
                          child: FlatButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                "无毛",
                                style: TextStyle(fontSize: 12),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                    onPressed: () {},
                    color: Color(0xfff5f2f3),
                    child: Text("健康")),
                FlatButton(
                    onPressed: () {},
                    color: Color(0xfffcf4cc),
                    child: Text(
                      "患病中",
                      style: TextStyle(color: Color(0xfff4cd20)),
                    )),
                FlatButton(
                    onPressed: () {},
                    color: Color(0xfff5f2f3),
                    child: Text("患病已痊愈")),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Color(0xfff4cd20)),
                    ),
                    child: Text(
                      "稳重",
                      style: TextStyle(color: Color(0xfff4cd20)),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "调皮",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "运动量大",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "不挑食",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "聪明",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "活泼",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "会看家",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "无攻击性",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "健康",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "胆小",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "高冷",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "不乱叫",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(color: Colors.black54),
                    ),
                    child: Text(
                      "亲人",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              decoration: BoxDecoration(
                color: Color(0xffeae8e9),
              ),
              child: TextField(
                  style: TextStyle(fontSize: 14),
                  minLines: 8,
                  maxLines: 10086,
                  decoration: InputDecoration(
                      hintText: "它的故事……",
                      hintStyle:
                          TextStyle(color: Color(0xff626262), fontSize: 14),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                runSpacing: 10,
                children: <Widget>[
                  AdoptSongYangFormCheckBox(
                    value: false,
                    title: Text("仅限同城"),
                  ),
                  AdoptSongYangFormCheckBox(
                    value: true,
                    title: Text("办理狗证"),
                  ),
                  AdoptSongYangFormCheckBox(
                    value: false,
                    title: Text("接收回访"),
                  ),
                  AdoptSongYangFormCheckBox(
                    value: false,
                    title: Text("绝育"),
                  ),
                  AdoptSongYangFormCheckBox(
                    value: false,
                    title: Text("安装纱窗"),
                  ),
                  AdoptSongYangFormCheckBox(
                    value: false,
                    title: Text("出门牵绳"),
                  ),
                  AdoptSongYangFormCheckBox(
                    value: false,
                    title: Text("签署协议"),
                  ),
                ],
              ),
            ),
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
                  onPressed: () {},
                  child: Text("发布", style: TextStyle(color: Colors.white, fontSize: 20),)),
            )
            ),
           
          ],
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
