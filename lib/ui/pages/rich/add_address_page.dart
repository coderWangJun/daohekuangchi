import 'package:dh/common/constants.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/view_model/addr_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class AddAddressPage extends StatefulWidget {
  final int type;

  const AddAddressPage({Key key, this.type}) : super(key: key);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  String title = "USDT";

  TextEditingController nameController = TextEditingController();

  TextEditingController addressController = TextEditingController();

  FocusNode nameNode = FocusNode();
  FocusNode addressNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.type == 0 ? "USDT" : "Fil";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorBackgroundColor,
      appBar: CustomAppBar(
        backgroundColor: Styles.colorBackgroundColor,
        isBack: true,
        centerTitle: "添加地址",
        onBack: () {
          NavigatorUtil.popResult(context, "refresh");
        },
      ),
      body: Container(
        margin: EdgeInsets.only(left: 33.h, right: 33.h),
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(color: Styles.color2B3448, width: 2.h))),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 80.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("名称",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                          color: Styles.colorWhite)),
                ],
              ),
              height: 56.h,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Styles.color2B3448, width: 2.h))),
              child: TextFormField(
                  focusNode: nameNode,
                  textAlign: TextAlign.start,
                  controller: nameController,
                  onChanged: (text) {
                    //onChanged(text);
                  },
                  decoration: InputDecoration(
                    hintText: "请输入用于区分的名称",
                    hintStyle: Styles.theme(
                        color: Styles.color999999, fontSize: 32.sp),
                    border: InputBorder.none, //去掉下划线
                    //hintStyle: TextStyles.textGrayC14
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 80.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("地址链接",
                      style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w400,
                          color: Styles.colorWhite)),
                ],
              ),
              height: 56.h,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom:
                          BorderSide(color: Styles.color2B3448, width: 2.h))),
              child: TextFormField(
                  focusNode: addressNode,
                  textAlign: TextAlign.start,
                  controller: addressController,
                  onChanged: (text) {},
                  decoration: InputDecoration(
                    hintText: "请输入" + title + "地址链接",
                    hintStyle: Styles.theme(
                        color: Styles.color999999, fontSize: 32.sp),
                    border: InputBorder.none, //去掉下划线
                    //hintStyle: TextStyles.textGrayC14
                  )),
            ),
            Container(
                margin: EdgeInsets.only(top: 100.h),
                child: ProviderWidget<AddrViewModel>(
                  model: AddrViewModel(widget.type),
                  onModelReady: (model) {},
                  builder: (ctx, model, child) {
                    return CustomButton(
                      "添加",
                      width: 686.w,
                      height: 98.h,
                      radius: 49.w,
                      fontSize: 32.ssp,
                      busy: model.busy,
                      onPressed: () async {
                        String name = nameController.text;
                        String address = addressController.text;

                        if (name.isEmpty) {
                          ToastUtil.openToast("请输入用于区分的名称");
                          return;
                        }
                        if (address.isEmpty) {
                          ToastUtil.openToast("请输入" + title + "地址链接");
                          return;
                        }
                        ResultData res =
                            await model.addAddress(widget.type, name, address);
                        if (res.code == Constants.successCode) {
                          ToastUtil.openToast(res.message);

                          NavigatorUtil.popResult(context, "refresh");
                          nameController.text = "";
                          addressController.text = "";
                        } else {
                          ToastUtil.openToast(res.message);
                        }
                      },
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
