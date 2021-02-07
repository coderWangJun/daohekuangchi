import 'package:dh/provider/provider_widget.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/help_center_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HelpDetailsPage extends StatefulWidget {
  final String id;
  final String type;

  const HelpDetailsPage({Key key, this.id, this.type}) : super(key: key);

  @override
  _HelpDetailsPageState createState() => _HelpDetailsPageState();
}

class _HelpDetailsPageState extends State<HelpDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        backgroundColor: Color(0xff161D30),
        isBack: true,
        centerTitle:
            widget.type == "1" ? "公告详情" : widget.type == "2" ? "常见问题" : "新手指南",
      ),
      body: Container(
        padding: EdgeInsets.all(32.w),
        child: ProviderWidget<HelpCenterListViewModel>(
          model: HelpCenterListViewModel(),
          onModelReady: (model) {
            model.initDetails(widget.id);
          },
          builder: (ctx, model, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30.h, bottom: 60.h),
                  child: Text(model.noticeDetailsEntity.title,
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                Container(
                  child: HtmlWidget(
                    model.noticeDetailsEntity.content,
                    webView: true,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 60.h),
                  child: Text(model.noticeDetailsEntity.senddate,
                      style: TextStyle(fontSize: 28.sp, color: Colors.white)),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
