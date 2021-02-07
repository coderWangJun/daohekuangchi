import 'package:dh/common/constants.dart';
import 'package:dh/http/index.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/alert.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/view_model/collection_set_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

import 'package:dh/provider/provider_widget.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:image_pickers/Media.dart';
import 'package:dh/ui/widgets/camera_photo.dart';

class CertificationPage extends StatefulWidget {
  final String status;

  const CertificationPage({Key key, this.status}) : super(key: key);

  @override
  _CertificationPageState createState() => _CertificationPageState();
}

class _CertificationPageState extends State<CertificationPage> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  FocusNode _focusNode = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  File _imageFile;
  File _imageFile2;

  void _showDialog(type) {
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
                        _getPhototImage(type);
                      },
                      child: Image.asset(
                        "assets/images/mine/photo.png",
                        width: 268.w,
                        height: 268.h,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _getGalleryImage(type);
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

  void _getGalleryImage(type) async {
    try {
      _focusNode.unfocus();
      _focusNode2.unfocus();
      CameraPhotoUtil.selectImages(selectCount: 1).then((List<Media> vals) {
        String _imgPath = vals.last.path;
        File _file = new File(_imgPath);
        if (type == 0) {
          _imageFile = _file;
        } else if (type == 1) {
          _imageFile2 = _file;
        }
        if (_imgPath != null && _imgPath.isNotEmpty) {
          setState(() {});
          NavigatorUtil.pop(context);
        }
      });
      // ImagePicker.pickImage(
      //         source: ImageSource.gallery, maxWidth: 800, imageQuality: 95)
      //     .then((File file) {
      //   if (type == 0) {
      //     _imageFile = file;
      //   } else if (type == 1) {
      //     _imageFile2 = file;
      //   }
      //   setState(() {});
      //   NavigatorUtil.pop(context);
      // });
    } catch (e) {
      ToastUtil.openToast('没有权限，无法打开相册！');
    }
  }

  void _getPhototImage(type) {
    try {
      _focusNode.unfocus();
      _focusNode2.unfocus();
      CameraPhotoUtil.openCamera().then((List<Media> vals) {
        String _imgPath = vals.last.path;
        File _file = new File(_imgPath);
        if (type == 0) {
          _imageFile = _file;
        } else if (type == 1) {
          _imageFile2 = _file;
        }
        if (_imgPath != null && _imgPath.isNotEmpty) {
          setState(() {});
          NavigatorUtil.pop(context);
        }
      });
      // ImagePicker.pickImage(
      //         source: ImageSource.camera, maxWidth: 800, imageQuality: 95)
      //     .then((File file) {
      //   if (type == 0) {
      //     _imageFile = file;
      //   } else if (type == 1) {
      //     _imageFile2 = file;
      //   }
      //   setState(() {});
      //   NavigatorUtil.pop(context);
      // });
    } catch (e) {
      ToastUtil.openToast('没有权限，无法打开相机！');
    }
  }

  CollectionSetViewModel viewModel;

//  @override
//  void initState() {
//    viewModel.setType(widget.status);
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: widget.status == "1" ? "实名认证-已认证" : "实名认证",
        isBack: true,
        backgroundColor: Color(0xff161D30),
        onBack: () {
          NavigatorUtil.popResult(context, "refresh");
        },
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: ProviderWidget<CollectionSetViewModel>(
                model: CollectionSetViewModel(),
                onModelReady: (model) {
                  model.setType(widget.status);
                  model.authDetails();
                },
                builder: (ctx, model, child) {
                  return model.type == "0"
                      ? Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 40.h),
                                    child: Text("国家和地区",
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                      width: double.infinity,
                                      height: 88.h,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 20.w),
                                      margin: EdgeInsets.only(top: 15.h),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.w),
                                          border: Border.all(
                                              width: 1.w,
                                              color: Color(0xffB1C6EA))),
                                      child: Text("中国",
                                          style: TextStyle(
                                              fontSize: 28.sp,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500))),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: Text("真实姓名",
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                      width: 686.w,
                                      height: 88.h,
                                      margin: EdgeInsets.only(top: 15.h),
                                      child: TextField(
                                        controller: _controller,
                                        focusNode: _focusNode,
                                        textInputAction: TextInputAction.done,
                                        style: TextStyle(fontSize: 28.sp),
                                        decoration: InputDecoration(
                                          fillColor: Color(0xff161D30),
                                          filled: true,
                                          border: InputBorder.none,
                                          hintText: "请和身份证上姓名保持一致",
                                          hintStyle: TextStyle(
                                              fontSize: 28.sp,
                                              color: Color(0xff999999)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.w,
                                                  color: Color(0xffB1C6EA)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.w))),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 1.w,
                                                  color: Color(0xffB1C6EA)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.w))),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 25.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: Text("证件号码",
                                        style: TextStyle(
                                            fontSize: 28.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    width: 686.w,
                                    height: 88.h,
                                    margin: EdgeInsets.only(top: 15.h),
                                    child: TextField(
                                      controller: _controller2,
                                      focusNode: _focusNode2,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(fontSize: 28.sp),
                                      decoration: InputDecoration(
                                        fillColor: Color(0xff161D30),
                                        filled: true,
                                        border: InputBorder.none,
                                        hintText: "请输入身份证号",
                                        hintStyle: TextStyle(
                                            fontSize: 28.sp,
                                            color: Color(0xff999999)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.w,
                                                color: Color(0xffB1C6EA)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.w))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 1.w,
                                                color: Color(0xffB1C6EA)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.w))),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 750.w,
                              margin: EdgeInsets.only(top: 60.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          "身份证正面",
                                          style: TextStyle(
                                              fontSize: 28.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _showDialog(0);
                                        },
                                        child: _imageFile == null
                                            ? Container(
                                                width: 200.w,
                                                height: 200.w,
                                                margin:
                                                    EdgeInsets.only(top: 20.h),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff2B3448),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w)),
                                                child: Image.asset(
                                                  "assets/images/mine/update.png",
                                                  width: 64.w,
                                                  height: 64.h,
                                                ),
                                              )
                                            : Container(
                                                width: 200.w,
                                                height: 200.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.w),
                                                  image: DecorationImage(
                                                    image:
                                                        FileImage(_imageFile),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                          bottom: 10,
                                        ),
                                        child: Text(
                                          "身份证反面",
                                          style: TextStyle(
                                              fontSize: 28.sp,
                                              color: Colors.white),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _showDialog(1);
                                        },
                                        child: _imageFile2 == null
                                            ? Container(
                                                width: 200.w,
                                                height: 200.w,
                                                margin:
                                                    EdgeInsets.only(top: 20.h),
                                                decoration: BoxDecoration(
                                                    color: Color(0xff2B3448),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.w)),
                                                child: Image.asset(
                                                  "assets/images/mine/update.png",
                                                  width: 64.w,
                                                  height: 64.w,
                                                ),
                                              )
                                            : Container(
                                                width: 200.w,
                                                height: 200.w,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.w),
                                                  image: DecorationImage(
                                                    image:
                                                        FileImage(_imageFile2),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 32.w, right: 32.w, top: 60.h),
                              child: CustomButton(
                                "提交认证",
                                width: 686.w,
                                height: 98.w,
                                color: Color(0xff498FEA),
                                textColor: Colors.white,
                                fontSize: 32.sp,
                                radius: 49.w,
                                busy: model.busy,
                                onPressed: () async {
                                  ResultModel resultModel =
                                      await model.certification(
                                          _controller.text.trim(),
                                          _controller2.text.trim(),
                                          _imageFile,
                                          _imageFile2);
                                  if (resultModel.code ==
                                      Constants.successCode) {
                                    Alert.show(context,
                                        isBgPop: false,
                                        isPop: true,
                                        content: resultModel.message, onOk: () {
                                      NavigatorUtil.popResult(
                                          context, "refresh");
                                    });
                                  } else if (resultModel.code == "0002") {
                                    Alert.show(context,
                                        content: resultModel.message);
                                  } else {
                                    ToastUtil.openToast(resultModel.message);
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: 686.w,
                              margin: EdgeInsets.only(
                                  left: 32.w, right: 32.w, top: 100.h),
                              child: Text(
                                  "请上传清晰的证件照片，必须能看清证件号和姓名；仅支持PNG、JPG、JPEG格式，每张大小限制在2M以内",
                                  style: TextStyle(
                                      fontSize: 24.sp,
                                      color: Color(0xff999999))),
                            ),
                          ],
                        )
                      : model.type == "1"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 56.h),
                                  child: Text("实名信息",
                                      style: TextStyle(
                                          fontSize: 32.sp,
                                          color: Colors.white)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 40.h),
                                  child: Text("国籍：中国",
                                      style: TextStyle(
                                          fontSize: 30.sp,
                                          color: Colors.white)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 32.h),
                                  child: Text("姓名：${model.authEntity.name}",
                                      style: TextStyle(
                                          fontSize: 30.sp,
                                          color: Colors.white)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 32.h),
                                  child: Text("身份证：${model.authEntity.idcard}",
                                      style: TextStyle(
                                          fontSize: 30.sp,
                                          color: Colors.white)),
                                ),
                              ],
                            )
                          : model.type == "2"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 56.h),
                                      child: Text("实名信息",
                                          style: TextStyle(
                                              fontSize: 32.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 40.h),
                                      child: Text("国籍：中国",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 32.h),
                                      child: Text("姓名：${model.authEntity.name}",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 32.h),
                                      child: Text(
                                          "身份证：${model.authEntity.idcard}",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 70.h),
                                      child: Text("实名认证审核中",
                                          style: TextStyle(
                                              fontSize: 32.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 39.h),
                                      child: Text(model.authEntity.note,
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 56.h),
                                      child: Text("实名信息",
                                          style: TextStyle(
                                              fontSize: 32.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 40.h),
                                      child: Text("国籍：中国",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 32.h),
                                      child: Text("姓名：${model.authEntity.name}",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 32.h),
                                      child: Text(
                                          "身份证：${model.authEntity.idcard}",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 70.h),
                                      child: Text("实名认证失败",
                                          style: TextStyle(
                                              fontSize: 32.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 39.h),
                                      child: Text(
                                          "拒绝理由：${model.authEntity.note}",
                                          style: TextStyle(
                                              fontSize: 30.sp,
                                              color: Colors.white)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 148.h),
                                      child: CustomButton(
                                        "重新认证",
                                        width: 686.w,
                                        height: 98.h,
                                        color: Color(0xff3A8BF1),
                                        textColor: Colors.white,
                                        radius: 100.w,
                                        fontSize: 32.sp,
                                        onPressed: () {
//                            widget.status = "0";
                                          model.setType("0");
                                        },
                                      ),
                                    )
                                  ],
                                );
                })),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
