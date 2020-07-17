import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';

class UserAdoptAboutPage extends StatefulWidget {
  final String id;
  UserAdoptAboutPage({Key key, this.id}) : super(key: key);

  @override
  _UserAdoptAboutPageState createState() => _UserAdoptAboutPageState();
}

class _UserAdoptAboutPageState extends State<UserAdoptAboutPage> {

  UserAdoptAboutModal _data;

  Future getAdoptInfo() async {
    var data = await PxzRequest().get(
      "/adopt/item/${widget.id}"
    );
    print(data);
    if(data["status"] != "success") {
      BotToast.showText(text: data["msg"]);
    }
    _data = UserAdoptAboutModal.fromJson(data["data"]);
    print(_data.avatar);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAdoptInfo();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("领养人信息")),
      body: _data == null ? 
      Container(
        child: Center(
          child: Image.asset("assets/details/details_loading.gif"),
        ),
      ):
      Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        color: Color(0xffEFEFEF),
        child: SingleChildScrollView(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 45,
              backgroundImage:
                _data.avatar == null ? 
                AssetImage("assets/home/loading.png") :
                NetworkImage(_data.avatar),
            ),
            SizedBox(height: 10,),
            Text(_data.nickname, style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("所在城市: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.area.split(',')[1]),
                  Text(_data.pexp.area.split(',')[2]),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("性别: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.sex),
                  Text("年龄: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.age),
                  Text("职业: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.occupation),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("养宠经验: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.experience),
                  Text("养宠预算: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.budget),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("住房情况: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.liviEnvironment),
                  Text("婚姻情况: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.marriage),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("家人(朋友)是否同意养宠: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.familyConsent),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("家人(朋友)是否有过敏史: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.allergy),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("是同意有偿领养: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  Text(_data.pexp.paid),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("以下哪种原因会使你放弃养猫: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),),
                  SizedBox(height: 10,),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: <Widget>[
                      for (GiveUp item in _data.pexp.giveUp) 
                      Text(item.name),
                    ],
                  )
                ],
              ),
            ), 
          ],
        ), 
      ),
    ));
  }
}

class UserAdoptAboutModal {
  String id;
  String nickname;
  String avatar;
  Pexp pexp;
  Adopt adopt;
  Pet pet;

  UserAdoptAboutModal(
      {this.id, this.nickname, this.avatar, this.pexp, this.adopt, this.pet});

  UserAdoptAboutModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    pexp = json['pexp'] != null ? new Pexp.fromJson(json['pexp']) : null;
    adopt = json['adopt'] != null ? new Adopt.fromJson(json['adopt']) : null;
    pet = json['pet'] != null ? new Pet.fromJson(json['pet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    if (this.pexp != null) {
      data['pexp'] = this.pexp.toJson();
    }
    if (this.adopt != null) {
      data['adopt'] = this.adopt.toJson();
    }
    if (this.pet != null) {
      data['pet'] = this.pet.toJson();
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
  List<GiveUp> giveUp;

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
      this.updateTime,
      this.giveUp});

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
    if (json['give_up'] != null) {
      giveUp = new List<GiveUp>();
      json['give_up'].forEach((v) {
        giveUp.add(new GiveUp.fromJson(v));
      });
    }
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
    if (this.giveUp != null) {
      data['give_up'] = this.giveUp.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GiveUp {
  String id;
  String name;
  String status;
  String createTime;

  GiveUp({this.id, this.name, this.status, this.createTime});

  GiveUp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['create_time'] = this.createTime;
    return data;
  }
}

class Adopt {
  String id;
  String memberId;
  String petId;
  String auditStatus;
  String remark;
  String createTime;
  String updateTime;

  Adopt(
      {this.id,
      this.memberId,
      this.petId,
      this.auditStatus,
      this.remark,
      this.createTime,
      this.updateTime});

  Adopt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberId = json['member_id'];
    petId = json['pet_id'];
    auditStatus = json['audit_status'];
    remark = json['remark'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
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
    return data;
  }
}

class Pet {
  String id;
  String name;

  Pet({this.id, this.name});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}