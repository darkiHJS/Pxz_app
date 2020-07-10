import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/jsons/AdoptPetItemModel.dart';
import 'package:hello_world/pages/user/UserAdoptPet.dart';
import 'package:hello_world/pages/user/components/PetHomingItem.dart';
import 'package:hello_world/utils/Request.dart';

class UserReleaseHomingPage extends StatefulWidget {
  UserReleaseHomingPage({Key key}) : super(key: key);

  @override
  _UserReleaseHomingPageState createState() => _UserReleaseHomingPageState();
}

class _UserReleaseHomingPageState extends State<UserReleaseHomingPage> {
  int _index = 1;
  List<PetItemData> _petItemDatas = []; // 数据列表
  bool _isMore = true;

  // 加载方法
  Future getMyPetList() async {
    var data = await PxzRequest().get("/pet/index", data: {
      "page": _index,
      "limit": 20,
    });
    if(data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }

    if(data["data"]["items"].length < 20) _isMore = false;
    data["data"]["items"].forEach((e) {
      _petItemDatas.add(PetItemData.fromJson(e));
    });
    setState(() {});
    // if (data["status"] == "success" && _isMore) {
    //   var datas = data["data"]["items"];
    //   print(datas);
    //   if (datas.length < 20) {
    //     _isMore = false;
    //   }
    //   for (var item in datas) {
    //     PetItemData d = PetItemData.fromJson(item);
    //     _petItemDatas.add(d);
    //   }
    // }
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
                    builder: (BuildContext context) => UserAdoptPetPage(id: _petItemDatas[index].id,)));
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