import 'package:dh/res/styles.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;
  final String actionJS;

  WebViewPage({Key key, this.title, this.url, this.actionJS}) : super(key: key);

  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: widget.title,
        backgroundColor: Styles.colorBackgroundColor,
      ),
      body: Container(
        color: Styles.colorBackgroundColor,
        child: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) {
          },
          initialUrl: widget.url,
        ),
      ),
    );
  }
}
