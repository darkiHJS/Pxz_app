import 'package:flutter/material.dart';
import 'package:hello_world/pages/user/UserChangePhome.dart';

class UserSafetyPage extends StatelessWidget {
  const UserSafetyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(title: Text("账户与安全")),
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffededed)
          ),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UserChangePhomePage()
                    ));
                },
                child: Container(
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: Text("修改手机号", style: TextStyle(color: Color(0xff606060)))),
                      Text("123****8908", style: TextStyle(color: Color(0xff606060))),
                      Icon(Icons.arrow_forward_ios, color:Color(0xff606060), size: 18,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              // GestureDetector(
              //   child: Container(
              //     height: 60,
              //     padding: EdgeInsets.symmetric(horizontal: 10),
              //     decoration: BoxDecoration(
              //       color: Colors.black12,
              //       borderRadius: BorderRadius.circular(4)
              //     ),
              //     child: Row(
              //       children: <Widget>[
              //         Expanded(child: Text("修改密码(未开放)", style: TextStyle(color: Color(0xff606060)))),
              //         Text("未设置", style: TextStyle(color: Color(0xff606060))),
              //         Icon(Icons.arrow_forward_ios, color:Color(0xff606060), size: 18,),
              //       ],
              //     ),
              //   ),
              // ),

            ], 
          ),
        ),
      ),
    );
  }
}
