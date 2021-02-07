import 'package:dh/provider/provider_widget.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/help_center_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class UserAgreeLegalPage extends StatefulWidget {
  final String type;

  const UserAgreeLegalPage({Key key, this.type}) : super(key: key);

  @override
  _UserAgreeLegalPageState createState() => _UserAgreeLegalPageState();
}

class _UserAgreeLegalPageState extends State<UserAgreeLegalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: widget.type == "2" ? "用户协议" : "法律声明",
        isBack: true,
        backgroundColor: Color(0xff161D30),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32.w),
        child: ProviderWidget<HelpCenterViewModel>(
          model: HelpCenterViewModel(),
          onModelReady: (model) {
            model.initUserLegal(widget.type);
          },
          builder: (ctx,model,child) {
            return Container(
              child: HtmlWidget(
                model.aboutPageEntity.content ?? "",
                webView: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
