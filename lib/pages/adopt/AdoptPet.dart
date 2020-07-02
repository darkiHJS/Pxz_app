import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hello_world/jsons/AdoptPetModel.dart';
import 'package:hello_world/utils/Request.dart';

class AdoptPetPage extends StatefulWidget {
  AdoptPetPage({Key key}) : super(key: key);

  @override
  _AdoptPetPageState createState() => _AdoptPetPageState();
}

class _AdoptPetPageState extends State<AdoptPetPage> {
  AdoptPetModel _adoptPetModel;
  Future getPetDetail() async{
    var data = await PxzRequest().get(
      "/pet/detail/2"
    );
    setState(() {
      _adoptPetModel = AdoptPetModel.fromJson(data["data"]);
    });
    print(_adoptPetModel.name);
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
      body: _adoptPetModel == null ?
      Container(child: Center(child: Text('加载中……'),),) :
      Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(_adoptPetModel.resources[index].url);
                },
                itemCount: _adoptPetModel.resources.length,
                scrollDirection: Axis.horizontal,
                loop: true,
                duration: 300,
              ))
            ],
          )
        )
    );
  }
}
