import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/jsons/AdoptPetItemModel.dart';
import 'package:hello_world/pages/adopt/AdoptPet.dart';
import 'package:hello_world/pages/user/components/PetHomingItem.dart';
import 'package:hello_world/utils/Request.dart';

class UserCollectionHomingPage extends StatefulWidget {
  UserCollectionHomingPage({Key key}) : super(key: key);

  @override
  _UserCollectionHomingPageState createState() => _UserCollectionHomingPageState();
}

class _UserCollectionHomingPageState extends State<UserCollectionHomingPage> {
  int _index = 1;
  List<PetItemData> _petItemDatas = []; // 数据列表
  bool _isMore = true;

  // 加载方法
  Future getMyPetList() async {
    var data = await PxzRequest().get("/member/collect_pet", data: {
      "page": _index,
      "limit": 20,
    });
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

  reloadData() {
    _isMore = true;
    _index = 1;
    _petItemDatas = [];
    getMyPetList();
  }

  @override
  void initState() {
    super.initState();
    getMyPetList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          Widget child;
          if (index == _petItemDatas.length) {
            if (_isMore) {
              _index++;
              getMyPetList();
            } else {
              child = null;
            }
          } else {
            child = GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => AdoptPetPage(id: _petItemDatas[index].id,))).then((value){
                      reloadData();
                    });
              },
              child: PetHommingItem(
                itemData: _petItemDatas[index],
              ),
            );
          }
          return child;
        }
      ),
    );
  }
}