import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDownloadPage extends StatefulWidget {
  @override
  _AppDownloadPageState createState() => _AppDownloadPageState();
}

class _AppDownloadPageState extends State<AppDownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/mine/download_bg.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("下载",
              style: TextStyle(fontSize: 36.sp, color: Colors.white)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/mine/LOGO_B.png",
                width: 220.w,
                height: 290.h,
              ),
              Container(
                width: 321.w,
                height: 99.h,
                margin: EdgeInsets.only(top: 116.h),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(100.w),
                    border: Border.all(
                      width: 1.w,
                      color: Color(0xff5AC2FF),
                    )),
                child: FlatButton(
                  onPressed: () {
                    _launchInBrowser("https://v9app.xuedian.wang/LcwF");
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/mine/andrio.png",
                        width: 40.w,
                        height: 48.h,
                      ),
                      Text("立即下载",
                          style: TextStyle(
                              fontSize: 40.sp, color: Color(0xff5AC2FF))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }
}
