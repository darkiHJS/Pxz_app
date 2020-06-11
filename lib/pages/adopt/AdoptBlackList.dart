import 'package:flutter/material.dart';

class AdoptBlackListPage extends StatelessWidget {
  const AdoptBlackListPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("黑名单查询"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text("官方", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  Container(
                    margin: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      color: Color(0xfff4bc61),
                      borderRadius: BorderRadius.circular(4)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text("提醒", style: TextStyle(color: Colors.white, fontSize: 16)),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("以下只能查询已经收录到失信人名单的数据,正在审核中的数据，以及不符符合搜索条件的数据、不在查询范围内"),
              Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffcbcbcb), width: 1),
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10), 
                      hintText: "输入信息",
                      hintStyle: TextStyle(color: Color(0xffdfdfdf)),
                      border: InputBorder.none),
                  )
                ),
              ),
              Text("输入关于查询人的相关信息，例如手机号，微信号，微信昵称，QQ号，查询此人是否在黑名单"),
              SizedBox(height: 40,),
              FlatButton(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: (){},
                color: Color(0xfff4bc61),
                child: Text("查询", style: TextStyle(color:Colors.white, fontSize: 20),),
              )
            ],
          ),
        ));
  }
}
