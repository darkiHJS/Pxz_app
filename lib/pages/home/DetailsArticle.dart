import 'package:flutter/material.dart';
import 'package:hello_world/jsons/ContentDetailsData.dart';
import 'package:hello_world/utils/Request.dart';

///
/// 文章详情页
/// 接收一个 [id] 请求接口
///

class DetailsArticlePage extends StatefulWidget {
  final String id;
  DetailsArticlePage({Key key, this.id}) : super(key: key);

  @override
  _DetailsArticlePageState createState() => _DetailsArticlePageState(id);
}

class _DetailsArticlePageState extends State<DetailsArticlePage> {
  String id;
  _DetailsArticlePageState(this.id);

  Future<ContentDetailsData> getPageData() async {
    Map<String, dynamic> data = await PxzRequest().get("/rescue/detail/$id");
    return ContentDetailsData.fromJson(data["data"]);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          preferredSize: Size.fromHeight(0)), 
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.white),
        child: FutureBuilder(
          future: getPageData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              ContentDetailsData data = snapshot.data as ContentDetailsData;
              return Column(
                children: <Widget>[
                  AppBar(
                   title: Text(data.title), 
                   backgroundColor: Colors.white,
                  )
                ],   
              );
            } else {
              return Center(
                child: Image.asset("assets/details/details_loading.gif"),
              );
            }
          },
        ),
      ),
    );
  }
}
