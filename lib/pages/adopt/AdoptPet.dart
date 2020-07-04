import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/components/IconFont.dart';
import 'package:hello_world/jsons/AdoptPetModel.dart';
import 'package:hello_world/utils/Request.dart';

class AdoptPetPage extends StatefulWidget {
  final String id;
  AdoptPetPage({Key key, this.id}) : super(key: key);

  @override
  _AdoptPetPageState createState() => _AdoptPetPageState();
}

class _AdoptPetPageState extends State<AdoptPetPage> {
  AdoptPetModel _adoptPetData;
  bool _isEditLingYangState = false;
  String _lingYangRemark = "";
  Future getPetDetail() async {
    var data = await PxzRequest().get("/pet/detail/${widget.id}");

    setState(() {
      _adoptPetData = AdoptPetModel.fromJson(data["data"]);
      print(_adoptPetData.isCollect);
    });
  }

  // 弹出领养界面
  showLingYangFrom() async {
    // var data = await PxzRequest().get("/member_pexp/detail");
    // if (data["status"] == "error") {
    //   BotToast.showText(text: "没有进行领养人资格注册。");
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (BuildContext context) => AdoptLingYangFormPage()));
    //   return;
    // }
    setState(() {
      _isEditLingYangState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getPetDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              actions: [Container()],
            ),
            preferredSize: Size.fromHeight(0)),
        body: _adoptPetData == null
            ? Container(
                child: Center(
                  child: Text('加载中……'),
                ),
              )
            : Container(
                color: Colors.white,
                child: Stack(
                  children: <Widget>[
                    Expanded(
                      child: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                            expandedHeight: 300,
                            backgroundColor: Colors.white,
                            pinned: true,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Stack(
                                children: <Widget>[
                                  Container(
                                      color: Colors.black12,
                                      height: 300,
                                      child: Swiper(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Image.network(
                                            _adoptPetData.resources[index].url,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                        itemCount:
                                            _adoptPetData.resources.length,
                                        pagination: SwiperPagination(),
                                        scrollDirection: Axis.horizontal,
                                        loop: true,
                                        duration: 300,
                                      )),
                                  Positioned(
                                      bottom: 0,
                                      right: 20,
                                      child: GestureDetector(
                                          child: Container(
                                              width: 60,
                                              child: Column(
                                                children: <Widget>[
                                                  Text("让跟多人知道它",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 14)),
                                                  Image.asset(
                                                    "assets/adopt/share_claw.png",
                                                    width: 40,
                                                  ),
                                                ],
                                              ))))
                                ],
                              ),
                            ),
                            title: Text("领养详情"),
                          ),
                          SliverToBoxAdapter(
                              child: Container(
                            padding: EdgeInsets.fromLTRB(15, 25, 15, 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        _adoptPetData.name,
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "已有${_adoptPetData.adoptCount}位用户申请领养",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black26),
                                          ))
                                    ]),
                                SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: <Widget>[
                                    _adoptPetData.sex == "女孩"
                                        ? Icon(
                                            IconFont.woman,
                                            color: Colors.pink,
                                            size: 18,
                                          )
                                        : Icon(
                                            IconFont.man,
                                            color: Colors.blue,
                                            size: 18,
                                          ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(_adoptPetData.age),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    for (var i = 0;
                                        i < _adoptPetData.tagList.length;
                                        i++)
                                      Text(
                                        i == 0
                                            ? "${_adoptPetData.tagList[i].name} "
                                            : "| ${_adoptPetData.tagList[i].name}",
                                        style: TextStyle(color: Colors.black54),
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xffeb5c5b),
                                        ),
                                      ),
                                      child: Text(
                                        _adoptPetData.deworming,
                                        style: TextStyle(
                                          color: Color(0xffeb5c5b),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xffeb5c5b),
                                        ),
                                      ),
                                      child: Text(
                                        _adoptPetData.sterilization,
                                        style: TextStyle(
                                          color: Color(0xffeb5c5b),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xffeb5c5b),
                                        ),
                                      ),
                                      child: Text(
                                        _adoptPetData.vaccine,
                                        style: TextStyle(
                                          color: Color(0xffeb5c5b),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xfff3d72f),
                                        ),
                                      ),
                                      child: Text(
                                        _adoptPetData.bodyType,
                                        style: TextStyle(
                                          color: Color(0xfff3d72f),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xfff3d72f),
                                        ),
                                      ),
                                      child: Text(
                                        _adoptPetData.hair,
                                        style: TextStyle(
                                          color: Color(0xfff3d72f),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1, horizontal: 4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                          width: 1,
                                          color: Color(0xfff3d72f),
                                        ),
                                      ),
                                      child: Text(
                                        _adoptPetData.origin,
                                        style: TextStyle(
                                          color: Color(0xfff3d72f),
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Wrap(
                                  children: <Widget>[
                                    for (var item
                                        in _adoptPetData.adoptionNeeds)
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2),
                                            decoration: BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            width: 5,
                                            height: 5,
                                          ),
                                          Text(
                                            item.name,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Icon(Icons.location_on,
                                            size: 20, color: Colors.black26),
                                        Text(
                                          _adoptPetData.area.split(",").join(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black26),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text("浏览数 ${_adoptPetData.readCount}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black26)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "更新: ${DateTime.fromMillisecondsSinceEpoch(int.parse(_adoptPetData.update) * 1000).year}-${DateTime.fromMillisecondsSinceEpoch(int.parse(_adoptPetData.update) * 1000).month}-${DateTime.fromMillisecondsSinceEpoch(int.parse(_adoptPetData.update) * 1000).day}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black26),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "TA的故事",
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  _adoptPetData.intro,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black87),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    // footbar
                    _isEditLingYangState
                        ? Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              child: Stack(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isEditLingYangState = false;
                                      });
                                    },
                                    child: Container(
                                      color: Colors.black26,
                                      height: double.infinity,
                                      width: double.infinity,  
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        color: Colors.white,
                                        height: 240,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text("对救助人说的话:"),
                                            Expanded(
                                                child: Container(
                                                    margin: EdgeInsets.symmetric(vertical: 10),
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    color: Colors.grey
                                                        .withOpacity(.1),
                                                    child: TextField(
                                                      controller: TextEditingController()
                                                         ..text = _lingYangRemark,
                                                      onChanged: (v) {
                                                        _lingYangRemark = v;
                                                      },
                                                      style: TextStyle(fontSize: 12),
                                                      decoration: InputDecoration(
                                                          hintText: "请认真填写,提交后请耐心等待送养人回复.....",
                                                          isDense: true,
                                                          hintStyle: TextStyle(
                                                            color: Color(0xffaaaaaa),
                                                            fontSize: 12
                                                          ),
                                                          border:
                                                              InputBorder.none),
                                                    ))),
                                            Container(
                                              alignment: Alignment.center,
                                              child: FlatButton(
                                                onPressed: () async{
                                                  if(_lingYangRemark.length < 10) {
                                                    BotToast.showText(text: "多说一点, 会更容易获得青睐！");
                                                    return;
                                                  }
                                                  var data = await PxzRequest().post(
                                                    "/adopt/receive",
                                                    data: {
                                                      "pet_id": _adoptPetData.id,
                                                      "remark": _lingYangRemark 
                                                    }
                                                  );
                                                  if(data["status"] == "error") {
                                                    BotToast.showText(text: data["msg"]);
                                                    return;
                                                  }
                                                  setState(() {
                                                    _isEditLingYangState = false;
                                                  });
                                                },
                                                color: Color(0xfff3d72f),
                                                child: Text(
                                                  "提交",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ))
                        : Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                                height: 60,
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ]),
                                child: Row(
                                  children: <Widget>[
                                    FlatButton.icon(
                                        onPressed: () async {
                                          var data = await PxzRequest().post(
                                              "/pet/collect",
                                              data: {"id": _adoptPetData.id});
                                          print(data);
                                          if (data["status"] == "success") {
                                            setState(() {
                                              _adoptPetData.isCollect =
                                                  !_adoptPetData.isCollect;
                                            });
                                          }
                                        },
                                        icon: _adoptPetData.isCollect
                                            ? Icon(
                                                Icons.star,
                                                color: Color(0xfff3d72f),
                                              )
                                            : Icon(
                                                Icons.star_border,
                                                color: Color(0xff8d8d8d),
                                              ),
                                        label: Text(
                                          _adoptPetData.isCollect
                                              ? "已收藏"
                                              : "收藏",
                                          style: TextStyle(
                                              color: Color(0xff8d8d8d)),
                                        )),
                                    FlatButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.chat_bubble_outline,
                                            color: Color(0xff8d8d8d)),
                                        label: Text("评论",
                                            style: TextStyle(
                                                color: Color(0xff8d8d8d)))),
                                    Expanded(child: Container()),
                                    FlatButton(
                                      color: Color(0xfff3d72f),
                                      onPressed: () {
                                        showLingYangFrom();
                                      },
                                      child: Text(
                                        "领养TA",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                    _adoptPetData.status == "true"
                        ? Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    padding: EdgeInsets.all(30),
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Center(
                                      child: Image.asset(
                                          "assets/adopt/packout.png"),
                                    ))))
                        : Container()
                  ],
                ),
              ));
  }
}

class AdoptLongYangFormPage {}
