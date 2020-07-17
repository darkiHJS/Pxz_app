import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/jsons/AdoptPetItemModel.dart';
import 'package:hello_world/utils/Request.dart';

class UserAdoptPage extends StatefulWidget {
  UserAdoptPage({Key key}) : super(key: key);

  @override
  _UserAdoptPageState createState() => _UserAdoptPageState();
}

class _UserAdoptPageState extends State<UserAdoptPage> {
  int _page = 1;
  List<PetItemData> _petItemDatas = []; // 数据列表
  bool _isMore = true;

  Future getMyPetList() async {
    var data = await PxzRequest().get(
      "/member/pet_orders",
      data: {
        "page": _page,
        "limit": 20
      }
    );
    if(data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }
    print(data);
    if(data["data"]["items"].length < 20) _isMore = false;
    data["data"]["items"].forEach((e) {
      _petItemDatas.add(PetItemData.fromJson(e));
    });
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
    getMyPetList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的领养"),),
      body: ListView.builder(
        itemCount: _petItemDatas.length,
        itemBuilder: (BuildContext context, int index) {
          // return PetHommingItem();
          return Container();
        }
      ),
    );
  }
}