import 'package:flutter/material.dart';
import 'package:hello_world/components/IconFont.dart';

class PetHommingItem extends StatelessWidget {
  const PetHommingItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(1, 1),
          )
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: 120,
              height: 120,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1591584284&di=62825cf7298eca7d381065c195fc1f75&src=http://pic2.zhimg.com/50/4f98a5dd2bbd8b42d41e48331ded917e_hd.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
            Expanded(
                child: Container(
              height: 120,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[Text("小三花"), Text("猫小爪救助")],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        IconFont.woman,
                        color: Colors.pink,
                        size: 18,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.black12),
                        child: Text(
                          "成年",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.black12),
                        child: Text(
                          "三花",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.black12),
                        child: Text(
                          "嘉定新城",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "流浪猫脚掌都没了，也不知道发生了什么，明天我有笼子之后我会抓她去医院，救助组织的阿姨那里饱",
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff3d72f),
                          ),
                        ),
                        child: Text(
                          "已免疫",
                          style: TextStyle(
                            color: Color(0xfff3d72f),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff3d72f),
                          ),
                        ),
                        child: Text(
                          "已驱虫",
                          style: TextStyle(
                            color: Color(0xfff3d72f),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            width: 1,
                            color: Color(0xfff3d72f),
                          ),
                        ),
                        child: Text(
                          "已绝育",
                          style: TextStyle(
                            color: Color(0xfff3d72f),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ],
              ),
            )),
          ],
        ));
  }
}
