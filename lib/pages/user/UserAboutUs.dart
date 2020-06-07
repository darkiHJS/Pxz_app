import 'package:flutter/material.dart';

class UserAboutUsPage extends StatelessWidget {
  const UserAboutUsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("关于我们")),
      backgroundColor: Color(0xffededed),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          Container(
           alignment: Alignment.center,
           child: Image.asset("assets/user/user-about-us-icons.png", width: 100, height: 100,), 
          ),
          SizedBox(height: 80,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text("微信公众号")
                ),
                Text("Love-every-pet"),
                MaterialButton(
                  onPressed: (){},
                  minWidth: 0,
                  height: 0,
                  shape: null,
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 3),
                  color: Color(0xfff3d72f),
                  child: Text("复制"),
                )
              ],
            ),  
          ),
          Divider(color: Color(0xFFD2D2D2),)
        ],
      ),
    );
  }
}
