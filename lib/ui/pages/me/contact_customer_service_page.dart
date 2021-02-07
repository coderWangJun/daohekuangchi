import 'package:dh/provider/provider_widget.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter/services.dart';

class ContactCustomerServicePage extends StatefulWidget {
  @override
  _ContactCustomerServicePageState createState() =>
      _ContactCustomerServicePageState();
}

class _ContactCustomerServicePageState
    extends State<ContactCustomerServicePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: "联系客服",
        isBack: true,
        backgroundColor: Color(0xff161D30),
      ),
      body: Container(
        width: 750.w,
        padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 30.h),
        child: ProviderWidget<ServiceViewModel>(
          model: ServiceViewModel(),
          onModelReady: (model) {
            model.initData();
          },
          builder: (ctx, model, child) {
            return Column(
              children: <Widget>[
                Container(
                  width: 686.w,
                  height: 104.h,
                  padding: EdgeInsets.only(left: 30.w, right: 20.w),
                  margin: EdgeInsets.only(top: 30.h),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2538),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("客服邮箱",
                          style:
                              TextStyle(fontSize: 30.sp, color: Colors.white)),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Text(model.contactPageEntity.email,
                                style: TextStyle(
                                    fontSize: 30.sp, color: Color(0xff999999))),
                          ),
                          InkWell(
                            onTap: () {
                              ClipboardData data = new ClipboardData(
                                  text: model.contactPageEntity.email);
                              Clipboard.setData(data);
                              ToastUtil.openToast('复制成功');
                            },
                            child: Image.asset(
                              "assets/images/mine/icon_copy.png",
                              width: 56.w,
                              height: 56.h,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: 686.w,
                  height: 104.h,
                  padding: EdgeInsets.only(left: 30.w, right: 20.w),
                  margin: EdgeInsets.only(top: 30.h),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2538),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("客服微信",
                          style:
                              TextStyle(fontSize: 30.sp, color: Colors.white)),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10.w),
                            child: Text(model.contactPageEntity.wechat,
                                style: TextStyle(
                                    fontSize: 30.sp, color: Color(0xff999999))),
                          ),
                          InkWell(
                            onTap: () {
                              ClipboardData data = new ClipboardData(
                                  text: model.contactPageEntity.wechat);
                              Clipboard.setData(data);
                              ToastUtil.openToast('复制成功');
                            },
                            child: Image.asset(
                              "assets/images/mine/icon_copy.png",
                              width: 56.w,
                              height: 56.h,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 76.h),
                  child: Image.network(
                    model.contactPageEntity.wxcode,
                    width: 328.w,
                    height: 328.h,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30.h),
                  child: Text("客服微信二维码",
                      style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                ),
                Container(
                  width: 686.w,
                  height: 1.h,
                  color: Color(0xff2B3448),
                  margin: EdgeInsets.only(top: 90.h),
                ),
                Container(
                  width: 686.w,
                  margin: EdgeInsets.only(top: 30.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("欢迎大家提出宝贵意见，您的建议对我们很有帮助！",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28.sp, color: Colors.white)),
                      Text("有任何问题可以发邮件或加客服微信。",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28.sp, color: Colors.white))
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
