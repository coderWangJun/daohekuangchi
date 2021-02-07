import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/post_view_model.dart';
import 'package:flutter/material.dart';

import 'package:dh/utils/index.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

//公告详情
class PostDetailPage extends StatefulWidget {
  final String id;

  const PostDetailPage(
    this.id, {
    Key key,
  }) : super(key: key);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PostViewModel>(
        model: PostViewModel(), //此处引入新增的model
        onModelReady: (model) {
          //初始化页面数据
          model.getPostDetail(widget.id);
        },
        builder: (ctx, model, child) {
          return Scaffold(
              appBar: CustomAppBar(
                title: "公告详情",
                fontSize: 34.sp,
                backgroundColor:Styles.colorBackgroundColor
              ),
              backgroundColor: Styles.colorBackgroundColor,
              body: Builder(builder: (_) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 58.h),
                        child: CustomText(
                          model.detailEntity.title,
                          color: Color.fromRGBO(85, 100, 133, 1),
                          fontSize: 32,
                        ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: HtmlWidget(
                            model.detailEntity.content,
                            webView: true,
                          )),
                    ],
                  ),
                );
              }));
        });
  }
}
