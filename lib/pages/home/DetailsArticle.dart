import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
  ContentDetailsData _contentDetailsData;
  Extends _maxSwiper;
  _DetailsArticlePageState(this.id);

  Future<ContentDetailsData> getPageData() async {
    Map<String, dynamic> data = await PxzRequest().get("/rescue/detail/1");
    setState(() {
      double maxHight = 0;
      _contentDetailsData = ContentDetailsData.fromJson(data["data"]);
      _contentDetailsData.resources.forEach((element) {
        if(maxHight < double.parse(element.whextends.height)) {
          maxHight = double.parse(element.whextends.height);
          _maxSwiper = element.whextends;
        }
      });
      print(_maxSwiper.width);
    });
   
    // return null;
  }

  @override
  void initState() {
    super.initState();
    getPageData();
    
  }

  @override
  Widget build(BuildContext context) {
    print(double.parse(_maxSwiper.height) / (double.parse(_maxSwiper.width) / MediaQuery.of(context).size.width));
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          preferredSize: Size.fromHeight(0)),
      body: _contentDetailsData == null ? SizedBox.shrink() : CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Row(
              children: <Widget>[
                IconButton(
                  color: Colors.grey,
                  alignment: Alignment.centerLeft,
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1906469856,4113625838&fm=26&gp=0.jpg"),
                  ),
                ),
                Text(
                  "女王草莓",
                  style: TextStyle(fontSize: 14),
                ),
                Expanded(child: SizedBox.shrink()),
                SizedBox(
                  width: 50,
                  height: 22,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    borderSide: BorderSide(color: Colors.yellow),
                    padding: EdgeInsets.zero,
                    child: Text(
                      "关注",
                      style: TextStyle(fontSize: 12, color: Colors.yellow),
                    ),
                    onPressed: () {},
                  ),
                ),
                IconButton(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.all(0),
                  color: Colors.grey,
                  icon: Icon(Icons.open_in_new),
                  onPressed: () {},
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Container(
                height: double.parse(_maxSwiper.height) / (double.parse(_maxSwiper.width) / MediaQuery.of(context).size.width),
                child: Swiper(
                  itemCount: _contentDetailsData.resources.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CachedNetworkImage(
                        imageUrl: _contentDetailsData.resources[index].url,
                        fit: BoxFit.fitWidth,
                      );
                  },
                  // control: new SwiperControl(),
                ),
              )
            ]),
          )
        ],
      ),
      // Container(
      //   width: double.infinity,
      //   height: double.infinity,
      //   decoration: BoxDecoration(color: Colors.white),
      //   child: FutureBuilder(
      //     future: getPageData(),
      //     builder: (BuildContext context, AsyncSnapshot snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         ContentDetailsData data = snapshot.data as ContentDetailsData;
      //         return Column(
      //           children: <Widget>[
      //              Container(
      //               height: double.infinity,
      //               child: ListView(
      //                 children: <Widget>[
      //                   Swiper(
      //                     itemCount: 2,
      //                     itemBuilder: (BuildContext context, int index) {
      //                       return [
      //                         Image.network(
      //                           "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2364654808,1367649755&fm=26&gp=0.jpg",
      //                           fit: BoxFit.fitWidth,
      //                         ),
      //                         Image.network(
      //                           "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1589795536301&di=e65c12f32f0969f9337c309db95209cb&imgtype=0&src=http%3A%2F%2Fwww.chabeichong.com%2Fimages%2F2016%2F10%2F21-06155760.jpg",
      //                           fit: BoxFit.fitWidth,
      //                         )
      //                       ][index];
      //                     },
      //                     control: new SwiperControl(),
      //                   )
      //                 ],
      //               ),
      //             )
      //           ],
      //         );
      //       } else {
      //         return Center(
      //           child: Image.asset("assets/details/details_loading.gif"),
      //         );
      //       }
      //     },
      //   ),
      // ),
    );
  }
}
