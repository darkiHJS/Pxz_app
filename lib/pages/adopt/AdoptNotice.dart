import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdoptNoticePage extends StatelessWidget {
  const AdoptNoticePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: "http://www.paixiaozhua.com/other/adopt_read",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}