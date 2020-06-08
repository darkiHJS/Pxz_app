import 'package:flutter/material.dart';

class UserCertificatePage extends StatefulWidget {
  UserCertificatePage({Key key}) : super(key: key);

  @override
  _UserCertificatePageState createState() => _UserCertificatePageState();
}

class _UserCertificatePageState extends State<UserCertificatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("我的认证"),),
      body: Container(
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Image.asset("assets/user/user-certificate-ing.png"),
      )
    );
  }
}