import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/components/IconFont.dart';
import 'package:hello_world/jsons/AdoptPetModel.dart';
import 'package:hello_world/pages/user/UserAdoptAbout.dart';
import 'package:hello_world/utils/Request.dart';

class UserAdoptPetPage extends StatefulWidget {
  final String id;
  UserAdoptPetPage({Key key, this.id}) : super(key: key);

  @override
  _UserAdoptPetPageState createState() => _UserAdoptPetPageState();
}

class _UserAdoptPetPageState extends State<UserAdoptPetPage> {
  AdoptPetModel _adoptPetData;
  Future getPetDetail() async {
    var data = await PxzRequest().get("/pet/detail/${widget.id}");

    setState(() {
      _adoptPetData = AdoptPetModel.fromJson(data["data"]);
      print(_adoptPetData.isCollect);
    });
  }

  /// 弹出领养申请人列表
  showProposerList() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: <Widget>[
                    TabBar(tabs: [
                      Tab(
                        text: "全部",
                      ),
                      Tab(
                        text: "待定",
                      ),
                      Tab(
                        text: "确认领养",
                      ),
                      Tab(
                        text: "已拒绝",
                      ),
                    ]),
                    Expanded(
                        child: TabBarView(
                      children: <Widget>[
                        AdoptMeberListComp(
                          id: widget.id,
                          type: null,
                        ),
                        AdoptMeberListComp(
                          id: widget.id,
                          type: "firaudit",
                        ),
                        AdoptMeberListComp(
                          id: widget.id,
                          type: "succ",
                        ),
                        AdoptMeberListComp(
                          id: widget.id,
                          type: "turndown",
                        ),
                      ],
                    ))
                  ],
                ),
              ));
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
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 4,
                                blurRadius: 1,
                                offset: Offset(0, 3))
                          ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {},
                                color: Color(0xfff3d72f),
                                child: Text("编辑"),
                              ),
                              FlatButton(
                                onPressed: () {
                                  showProposerList();
                                },
                                color: Color(0xfff3d72f),
                                child: Text("申请人"),
                              ),
                            ],
                          ),
                        )),
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

class AdoptMeberListComp extends StatefulWidget {
  final String id;
  final String type;
  const AdoptMeberListComp({Key key, this.type, this.id}) : super(key: key);

  @override
  _AdoptMeberListCompState createState() => _AdoptMeberListCompState();
}

class _AdoptMeberListCompState extends State<AdoptMeberListComp> {
  int _page = 1;
  bool _isMore = true;
  List<AdoptModel> _adoptItems = [];

  Future getAdoptMeber() async {
    var config = {"page": _page.toString(), "limit": 20.toString()};
    if (widget.type != null) config["audit_status"] = widget.type;
    var data =
        await PxzRequest().get("/adopt/index/" + widget.id, data: config);
    if (data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }
    print(data);
    if (data["data"]["items"].length < 20) _isMore = false;
    data["data"]["items"].forEach((e) {
      _adoptItems.add(AdoptModel.fromJson(e));
    });
    if (this.mounted) {
      setState(() {});
    }
  }

  reloadData() {
    _page = 1;
    _isMore = true;
    _adoptItems = [];
    getAdoptMeber();
  }

  @override
  void initState() {
    super.initState();
    getAdoptMeber();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _adoptItems.length,
        itemBuilder: (BuildContext context, int index) {
          if (index % 20 == 0 && _isMore) {
            getAdoptMeber();
            return Container();
          }
          return AdoptMeberListItem(
            data: _adoptItems[index],
            reloadData: reloadData,
          );
        });
  }
}

class AdoptMeberListItem extends StatefulWidget {
  final AdoptModel data;
  final Function reloadData;
  const AdoptMeberListItem({Key key, this.data, this.reloadData})
      : super(key: key);
  @override
  _AdoptMeberListItemState createState() => _AdoptMeberListItemState();
}

class _AdoptMeberListItemState extends State<AdoptMeberListItem> {
  bool _showMoreLine = false;
  final Map<String, dynamic> _type = {
    "ready": {"buttonTitle": "待定", "next": "firaudit"},
    "firaudit": {"buttonTitle": "确认领养", "next": "succ"},
  };

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserAdoptAboutPage(id: widget.data.id)))
                      .then((value) {
                    widget.reloadData();
                  });
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: widget.data.memberItem.avatar == null
                              ? AssetImage("assets/home/loading.png")
                              : NetworkImage(widget.data.memberItem.avatar),
                          fit: BoxFit.cover)),
                )),
            SizedBox(
              width: 15,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(),
                    ),
                    Text(widget.data.memberItem.nickname,
                        style: TextStyle(fontSize: 18)),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.room,
                      size: 14,
                      color: Colors.grey,
                    ),
                    Text(
                      "${widget.data.memberItem.pexp.area.split(',')[1]} ${widget.data.memberItem.pexp.area.split(',')[2]}",
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.data.memberItem.pexp.age + "岁",
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      widget.data.memberItem.pexp.experience,
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      widget.data.memberItem.pexp.occupation,
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    )
                  ],
                ),
                Text(
                  widget.data.remark,
                  overflow: TextOverflow.ellipsis,
                  maxLines: _showMoreLine ? 99 : 2,
                ),
                _showMoreLine
                    ? Container(
                        height: 20,
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMoreLine = true;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.more_horiz,
                            size: 30,
                            color: Colors.black12,
                          ),
                        ),
                      )
              ],
            )),
            SizedBox(
              width: 10,
            ),
            widget.data.auditStatus == "succ"
                ? Text("领养成功", style: TextStyle(color: Colors.green))
                : Container(),
            widget.data.auditStatus == "turndown"
                ? Text("已拒绝", style: TextStyle(color: Colors.red))
                : Container(),
            _type[widget.data.auditStatus] == null
                ? Container()
                : Column(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          var data =
                              await PxzRequest().post("/adopt/audit", data: {
                            "pet_id": widget.data.petId,
                            "member_id": widget.data.memberId,
                            "audit_status": _type[widget.data.auditStatus]
                                ["next"],
                            "id": widget.data.id
                          });
                          if (data["status"] == "error") {
                            BotToast.showText(text: data["msg"]);
                            return;
                          }
                          widget.reloadData();
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ]),
                          child: Text(
                              _type[widget.data.auditStatus]["buttonTitle"]),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xffea6161),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ]),
                          child:
                              Text("拒绝", style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
          ],
        ));
  }
}

class AdoptModel {
  String id;
  String memberId;
  String petId;
  String auditStatus;
  String remark;
  String createTime;
  String updateTime;
  MemberItem memberItem;

  AdoptModel(
      {this.id,
      this.memberId,
      this.petId,
      this.auditStatus,
      this.remark,
      this.createTime,
      this.updateTime,
      this.memberItem});

  AdoptModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    petId = json['pet_id'];
    auditStatus = json['audit_status'];
    remark = json['remark'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    memberItem = json['member_item'] != null
        ? new MemberItem.fromJson(json['member_item'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['pet_id'] = this.petId;
    data['audit_status'] = this.auditStatus;
    data['remark'] = this.remark;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.memberItem != null) {
      data['member_item'] = this.memberItem.toJson();
    }
    return data;
  }
}

class MemberItem {
  String id;
  String nickname;
  String avatar;
  Pexp pexp;

  MemberItem({this.id, this.nickname, this.avatar, this.pexp});

  MemberItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    pexp = json['pexp'] != null ? new Pexp.fromJson(json['pexp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    if (this.pexp != null) {
      data['pexp'] = this.pexp.toJson();
    }
    return data;
  }
}

class Pexp {
  String id;
  String memberId;
  String occupation;
  String contact;
  String wechat;
  String wechatImg;
  String sex;
  String area;
  String age;
  String experience;
  String liviEnvironment;
  String marriage;
  String familyConsent;
  String allergy;
  String paid;
  String budget;
  String createTime;
  String updateTime;

  Pexp(
      {this.id,
      this.memberId,
      this.occupation,
      this.contact,
      this.wechat,
      this.wechatImg,
      this.sex,
      this.area,
      this.age,
      this.experience,
      this.liviEnvironment,
      this.marriage,
      this.familyConsent,
      this.allergy,
      this.paid,
      this.budget,
      this.createTime,
      this.updateTime});

  Pexp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    occupation = json['occupation'];
    contact = json['contact'];
    wechat = json['wechat'];
    wechatImg = json['wechat_img'];
    sex = json['sex'];
    area = json['area'];
    age = json['age'];
    experience = json['experience'];
    liviEnvironment = json['livi_environment'];
    marriage = json['marriage'];
    familyConsent = json['family_consent'];
    allergy = json['allergy'];
    paid = json['paid'];
    budget = json['budget'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['member_id'] = this.memberId;
    data['occupation'] = this.occupation;
    data['contact'] = this.contact;
    data['wechat'] = this.wechat;
    data['wechat_img'] = this.wechatImg;
    data['sex'] = this.sex;
    data['area'] = this.area;
    data['age'] = this.age;
    data['experience'] = this.experience;
    data['livi_environment'] = this.liviEnvironment;
    data['marriage'] = this.marriage;
    data['family_consent'] = this.familyConsent;
    data['allergy'] = this.allergy;
    data['paid'] = this.paid;
    data['budget'] = this.budget;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    return data;
  }
}
