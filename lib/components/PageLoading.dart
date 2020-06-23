import 'package:flutter/material.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Text("加载中"),
      ),
    );
  }
}