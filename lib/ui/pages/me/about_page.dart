import 'package:dh/provider/provider_widget.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/help_center_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: "关于我们",
        isBack: true,
        backgroundColor: Color(0xff367EEC),
      ),
      body: SingleChildScrollView(
          child: Container(
        child: ProviderWidget<HelpCenterViewModel>(
          model: HelpCenterViewModel(),
          onModelReady: (model) {
            model.initAbout();
          },
          builder: (ctx, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 750.w,
                  height: 400.h,
                  color: Color(0xff367EEC),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            left: 284.w, right: 284.w, top: 65.h,bottom: 20.h),
                        child: Image.asset(
                          "assets/images/mine/LOGO_S.png",
                          width: 182.w,
                          height: 240.h,
                        ),
                      ),
                      Text("布局当下，收获未来",
                          style:
                              TextStyle(fontSize: 32.sp, color: Colors.white)),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(32.w),
                  child: HtmlWidget(
                    model.aboutPageEntity.content ?? "",
                    webView: true,
                  ),
                ),
//                  Container(
//                    alignment: Alignment.centerRight,
//                    margin: EdgeInsets.only(top: 30.h),
//                    child: Text(model.aboutPageEntity.createdAt ?? "",style: TextStyle(fontSize: 24.sp,color: Color(0xff999999))),
//                  )
              ],
            );
          },
        ),
      )),
    );
  }
}
