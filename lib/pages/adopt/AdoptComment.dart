import 'package:flutter/material.dart';

class AdoptCommentPage extends StatefulWidget {
  AdoptCommentPage({Key key}) : super(key: key);

  @override
  _AdoptCommentPageState createState() => _AdoptCommentPageState();
}

class _AdoptCommentPageState extends State<AdoptCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("评论列表"),
      ),
    );
  }
}