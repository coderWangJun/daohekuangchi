import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/personal_center_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:image_picker/image_picker.dart';

class PersonalCenterPage extends StatefulWidget {
  @override
  _PersonalCenterPageState createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  File _imageFile;

  void _showDialog(PersonalCenterViewModel model) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.black.withOpacity(.5),
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {
                NavigatorUtil.pop(context);
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 750.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        _getPhotoImage(model);
                      },
                      child: Image.asset(
                        "assets/images/mine/photo.png",
                        width: 268.w,
                        height: 268.h,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _getGalleryImage(model);
                      },
                      child: Image.asset(
                        "assets/images/mine/glary.png",
                        width: 268.w,
                        height: 268.h,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _getGalleryImage(PersonalCenterViewModel model) async {
    try {
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      NavigatorUtil.pop(context);
      model.uploadAvatar(_imageFile).then((value) {
        model.initData();
      });
      setState(() {});
    } catch (e) {
      ToastUtil.openToast('没有权限，无法打开相册！');
    }
  }

  void _getPhotoImage(PersonalCenterViewModel model) async {
    try {
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 800, imageQuality: 95);
      NavigatorUtil.pop(context);
      model.uploadAvatar(_imageFile).then((value) {
        model.initData();
      });
      setState(() {});
    } catch (e) {
      ToastUtil.openToast('没有权限，无法打开相册！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161E30),
      appBar: CustomAppBar(
        centerTitle: "个人中心",
        isBack: true,
        backgroundColor: Color(0xff161E30),
        onBack: (){
          NavigatorUtil.popResult(context, "refresh");
        },
      ),
      body: ProviderWidget<PersonalCenterViewModel>(
        model: PersonalCenterViewModel(),
        onModelReady: (model) {
          model.initData();
        },
        builder: (ctx, model, child) {
          return Column(
            children: <Widget>[
              Container(
                width: 686.w,
                height: 104.h,
                margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                decoration: BoxDecoration(
                    color: Color(0xff1E2638),
                    borderRadius: BorderRadius.circular(10.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("UID",
                        style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                    Text(model.uid,
                        style: TextStyle(
                            fontSize: 30.sp, color: Color(0xff9a9a9a)))
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _showDialog(model);
                },
                child: Container(
                  width: 686.w,
                  height: 104.h,
                  margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  decoration: BoxDecoration(
                      color: Color(0xff1E2638),
                      borderRadius: BorderRadius.circular(10.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("头像",
                          style:
                              TextStyle(fontSize: 30.sp, color: Colors.white)),
                      Container(
                        width: 84.w,
                        height: 84.w,
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(model.head),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 686.w,
                height: 104.h,
                margin: EdgeInsets.only(left: 32.w, right: 32.w, top: 32.h),
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                decoration: BoxDecoration(
                    color: Color(0xff1E2638),
                    borderRadius: BorderRadius.circular(10.w)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("绑定手机",
                        style: TextStyle(fontSize: 30.sp, color: Colors.white)),
                    Text(model.phone,
                        style: TextStyle(
                            fontSize: 30.sp, color: Color(0xff9a9a9a)))
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
