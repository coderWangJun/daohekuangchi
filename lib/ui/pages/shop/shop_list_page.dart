import 'package:dh/entity/shop_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/home_router.dart';

import 'package:dh/routers/module/shop_router.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/ui/widgets/custom_load_image.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/ui/widgets/popAlert.dart';

import 'package:dh/view_model/shop_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ShopListPage extends StatefulWidget {
  final String index;

  const ShopListPage({Key key, this.index}) : super(key: key);

  @override
  _ShopListPageState createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.colorBackgroundColor,
        body: ProviderWidget<ShopViewModel>(
          model: ShopViewModel(int.parse(widget.index)),
          onModelReady: (model) {
            model.refresh();
          },
          builder: (ctx, model, child) {
            return SmartRefresher(
                controller: model.refreshController,
                enablePullUp: true,
                onRefresh: model.refresh,
                onLoading: model.loadMore,
                child: CustomScrollView(shrinkWrap: true, slivers: <Widget>[
                  SliverPadding(
                      padding: EdgeInsets.only(left: 0.w, right: 0.w),
                      sliver: new SliverList(
                          delegate: SliverChildListDelegate(List.generate(
                              model.list.length,
                                  (index) => LtcItemPage(
                                item: model.list[index],
                                model: model,
                                currentType: 2,
                                index: widget.index,
                              )))))
                ]));
          },
        ));
  }
}

//单例 运算力矿机
class LtcItemPage extends StatefulWidget {
  final index;
  final item;
  final ShopViewModel model;
  final int currentType;

  const LtcItemPage(
      {Key key, this.item, this.model, this.currentType, this.index})
      : super(key: key);

  @override
  _LtcItemPageState createState() => _LtcItemPageState();
}

class _LtcItemPageState extends State<LtcItemPage> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32.w, right: 32.w,bottom: 48.h),
      height: 428.h,
      width: 686.w,
      decoration: BoxDecoration(
          color: Styles.color1E2638,
          borderRadius: BorderRadius.all(Radius.circular(16.w))
      ),
      child: InkWell(
        onTap: () {
          NavigatorUtil.push(
              context,
              ShopRouter.shopDetail +
                  "?id=" +
                  widget.item.id +
                  "&uSDT=" +
                  widget.model.shopEntity.wallet.uSDT +
                  "&currentType=" +
                  widget.currentType.toString() +
                  "&type=" +
                  widget.index);
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Positioned(
              //现货
              right: 0.w,
              top: 0,
              child: Container(
//              color: Color.fromRGBO(254, 167, 82, 1),
                width: 72.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16.w),bottomLeft: Radius.circular(16.w)),
                    color: Styles.color4D98F6),
                child: Text(
                  '现货',
                  style: TextStyle(
                    fontSize: 26.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Positioned(
              //矿机名称
              left: 33.w,
              top: 44.h,
              child: Row(
                children: <Widget>[
                  CustomText(
                    widget.item.hashname,
                    fontSize: 34,
                    color: Styles.colorFFFFFF,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 33.w,
              top: 112.h,
              child: Row(
                children: <Widget>[
                  Container(
                    width:120.w,
                    child: CustomText(
                      '挖矿币种:',
                      fontSize: 26,
                      color: Styles.color999999,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 17.w),
                    width: 100.w,
                    child: CustomText(
                      widget.item.cionType,
                      fontSize: 26,
                      color: Styles.colorFFFFFF,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 46.w),
                    width:120.w,
                    child: CustomText(
                      '结算周期:',
                      fontSize: 26,
                      color: Styles.color999999,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 17.w),
                    child: CustomText(
                      'T+1',
                      fontSize: 26,
                      color: Styles.colorFFFFFF,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 33.w,
              top: 154.h,
              child: Row(
                children: <Widget>[
                  Container(
                    width:120.w,
                    child: CustomText(
                      widget.index == "1" ? '合约期限:' : "托管费:",
                      fontSize: 26,
                      color: Styles.color999999,
                    ),
                  ),
                  Container(
                    width: widget.index == "1" ? 100.w : 150.w,
                    margin: EdgeInsets.only(left: 5.w),
                    child: CustomText(
                      widget.index == "1"
                          ? widget.item.hashday
                          : widget.item.trustcsah + "USDT",
                      fontSize: 26,
                      color: Styles.colorFFFFFF,
                    ),
                  ),
                  Container(
                    width:160.w,
                    margin: widget.index == "1"
                        ? EdgeInsets.only(left: 50.w)
                        : EdgeInsets.only(left: 11.w),
                    child: CustomText(
                      '技术服务费:',
                      fontSize: 26,
                      color: Styles.color999999,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.w),
                    child: CustomText(
                      widget.item.ratio,
                      fontSize: 26,
                      color: Styles.colorFFFFFF,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              //价格
              left: 33.w,
              top: 234.h,
              child: Container(
                width: 200.w,
                height: 44.h,
                child: Row(
                  children: <Widget>[
                    CustomText(
                      widget.item.hashcash,
                      fontSize: 44,
                      color: Styles.color73AAFF,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16.h),
                      child: CustomText(
                        ' USDT',
                        fontSize: 28,
                        color: Styles.color73AAFF,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              //加减按钮
              right: 32.w,
              top: 234.h,
              child: Row(
                children: <Widget>[
                  _reduceBtn(context),
                  _countArea(context,fontCol: Styles.colorB1C5E9),
                  _addBtn(context)
                ],
              ),
            ),

            Positioned(
              //立即购买按钮
              right: 32.w,
              top: 344.h,
              child: CustomButton(
                '立即购买',
                height: 56.h,
                width: 188.w,
                color: Color.fromRGBO(73, 143, 234, 1),
                textColor: Styles.colorWhite,
                radius: 28,
                fontSize: 28.sp,
                onPressed: () {
                  NavigatorUtil.push(
                      context,
                      ShopRouter.shopDetail +
                          "?id=" +
                          widget.item.id +
                          "&uSDT=" +
                          widget.model.shopEntity.wallet.uSDT +
                          "&currentType=" +
                          widget.currentType.toString() +
                          "&type=" +
                          widget.index);
//                  num = widget.item.realNum;
//                  PopAlert.show(context,
//                      child:
//                      LtcShowItemPage(item: widget.item, model: widget.model),
//
//                      isCancel: false,
////                    onOk: () {},
////                    isOk: true,
//                      isBgPop: false,
//                      alignment: Alignment.bottomCenter,
//                      contentHeight: 1046.h,
//                      padTop: 0.h,
//                      width: 750.w,
//                      height: 1046.h);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  //减少按钮
  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        if (widget.item.realNum <= int.parse(widget.item.shownum)) {
          return;
        }
        setState(() {
          num -= 1;
          widget.item.realNum -= 1;
          widget.item.hashcash =
              (int.parse(widget.item.hashcash) - int.parse(widget.item.hashnum))
                  .toString();
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(64),
        //是正方形的所以宽和高都是45
        height: ScreenUtil().setHeight(64),
        alignment: Alignment.center,
        //上下左右都居中
        decoration: BoxDecoration(
            color: widget.item.realNum > int.parse(widget.item.shownum)
                ? Styles.color21293C
                : Colors.black12, //按钮颜色大于1是白色，小于1是灰色
            border: Border.all(
              //外层已经有边框了所以这里只设置右边的边框
                width: 1.0,
                color: Styles.color2B3347)),
        child: LoadAssetImage(
          "home/del.png",
          width: 64.w,
          height: 64.h,
          color: Styles.colorFFFFFF,
        ), //数量小于1 什么都不显示
      ),
    );
  }

  //加号
  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        setState(() {
          num += 1;
          widget.item.realNum += 1;
          widget.item.hashcash =
              (int.parse(widget.item.hashcash) + int.parse(widget.item.hashnum))
                  .toString();
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(64),
        //是正方形的所以宽和高都是45
        height: ScreenUtil().setHeight(64),
        alignment: Alignment.center,
        //上下左右都居中
        decoration: BoxDecoration(
            color: Styles.color21293C,
            border: Border.all(
              //外层已经有边框了所以这里只设置右边的边框
                width: 1.0,
                color: Styles.color2B3347)),
        child: LoadAssetImage(
          "home/add.png",
          width: 64.w,
          height: 64.h,
          color: Styles.colorFFFFFF,
        ),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(context, {Color fontCol, isOpen: false}) {
    return Container(
      width: ScreenUtil().setWidth(114),
      //爬两个数字的这里显示不下就宽一点70
      height: ScreenUtil().setHeight(64),
      //高
      decoration: BoxDecoration(
          color: Styles.color21293C,
          border: Border(
            top: BorderSide(width: 1.0, color: Styles.color2B3347),
            bottom: BorderSide(width: 1.0, color:Styles.color2B3347),
          )),
      // 度和加减号保持一样的高度
      alignment: Alignment.center,
      //上下左右居中
      child: CustomText(
        widget.item.realNum.toString(),
        fontSize: 28,
        color: fontCol == null ? Color.fromRGBO(254, 167, 82, 1) : fontCol,
      ), //先默认设置为1 因为后续是动态的获取数字
    );
  }
}


class LtcShowItemPage extends StatefulWidget {
  final Data item;
  final ShopViewModel model;
//
  const LtcShowItemPage({Key key, this.item, this.model}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LtcShowItemPageState();
  }
}

class _LtcShowItemPageState extends State<LtcShowItemPage> {
  //减少按钮
  Widget _reduceBtn(context, {isOpen: true}) {
    return InkWell(
      onTap: () {
        if (widget.item.realNum <= int.parse(widget.item.shownum)) {
          return;
        }
        setState(() {
          widget.item.realNum -= 1;
          widget.item.hashcash =
              (int.parse(widget.item.hashcash) - int.parse(widget.item.hashnum))
                  .toString();
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(64),
        //是正方形的所以宽和高都是45
        height: ScreenUtil().setHeight(64),
        alignment: Alignment.center,
        //上下左右都居中
        decoration: BoxDecoration(
            color: widget.item.realNum > int.parse(widget.item.shownum)
                ? Styles.color21293C
                : Colors.black12, //按钮颜色大于1是白色，小于1是灰色
            border: Border.all(
              //外层已经有边框了所以这里只设置右边的边框
                width: 1.0,
                color: Styles.color2B3448)),
        child: LoadAssetImage(
          "home/del.png",
          width: 64.w,
          height: 64.h,
          color: Styles.colorFFFFFF,
        ), //数量小于1 什么都不显示
      ),
    );
  }

  //加号
  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.item.realNum += 1;
          widget.item.hashcash =
              (int.parse(widget.item.hashcash) + int.parse(widget.item.hashnum))
                  .toString();
        });
      },
      child: Container(
        width: ScreenUtil().setWidth(64),
        //是正方形的所以宽和高都是45
        height: ScreenUtil().setHeight(64),
        alignment: Alignment.center,
        //上下左右都居中
        decoration: BoxDecoration(
            color: Styles.color21293C,
            border: Border.all(
              //外层已经有边框了所以这里只设置右边的边框
                width: 1.0,
                color: Styles.color2B3448)),
        child: LoadAssetImage(
          "home/add.png",
          width: 64.w,
          height: 64.h,
          color: Styles.colorFFFFFF,
        ),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(context, {Color fontCol, isOpen: false}) {
    return Container(
      width: ScreenUtil().setWidth(114),
      //爬两个数字的这里显示不下就宽一点70
      height: ScreenUtil().setHeight(64),
      //高
      decoration: BoxDecoration(
          color: Styles.color2B3347,
          border: Border(
            top: BorderSide(width: 1.0, color: Styles.color2B3448),
            bottom: BorderSide(width: 1.0, color: Styles.color2B3448),
          )),
      // 度和加减号保持一样的高度
      alignment: Alignment.center,
      //上下左右居中
      child: CustomText(
        widget.item.realNum.toString(),

        fontSize: 28,
        color: fontCol == null ? Color.fromRGBO(254, 167, 82, 1) : fontCol,
      ), //先默认设置为1 因为后续是动态的获取数字
    );
  }

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          width: 750.w,
          height: 98.h,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 312.w,
                top: 30.h,
                child: CustomText(
                  '确认订单',
                  fontSize: 32,
                  color: Styles.colorFFFFFF,
                ),
              ),
              Positioned(
                right: 23.w,
                top: 25.w,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Image.asset(
                    "assets/images/home/exit.png",
                    width: 48.w,
                    height: 48.w,
                    color: Styles.colorFFFFFF,
                  ),
                ),
              ),
              Positioned(
                top: 96.h,
                left: 32.w,
                child: Container(
                  width: 686.w,
                  height: 1.h,
                  color: Styles.color2B3347,
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 37.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                '合约名称',
                color: Styles.colorB1C5E9,
                fontSize: 28,
              ),
              CustomText(
                widget.item.hashname,
                color: Styles.colorFFFFFF,
                fontSize: 28,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 37.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                '合约期限',
                color: Styles.colorB1C5E9,
                fontSize: 28,
              ),
              Container(
                width: 390.w,
                child: CustomText(widget.item.title,
                    color: Styles.colorFFFFFF,
                    fontSize: 28,
                    softWrap: true),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 37.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                '技术服务费',
                color: Styles.colorB1C5E9,
                fontSize: 28,
              ),
              CustomText(widget.item.ratio+
                  '  (从挖矿收益中直接扣除)',
                color: Styles.colorFFFFFF,
                fontSize: 28,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 37.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                '结算周期',
                color: Styles.colorB1C5E9,
                fontSize: 28,
              ),
              CustomText(
                widget.item.period,
                color: Styles.colorFFFFFF,
                fontSize: 28,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 37.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                '单价',
                color: Styles.colorB1C5E9,
                fontSize: 28,
              ),
              CustomText(
                '\$' + widget.item.hashnum + '/TB',
                color: Styles.colorFFFFFF,
                fontSize: 28,
              ),
            ],
          ),
        ),
        Container(
          height: 98.h,
          width: 750.w,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 36.w,
                top: 36.h,
                child: CustomText(
                  '购买数量',
                  color: Styles.colorB1C5E9,
                  fontSize: 28,
                ),
              ),
              Positioned(
                //加减按钮
                left: 475.w,
                top: 22.h,
                child: Row(
                  children: <Widget>[
                    _reduceBtn(context),
                    _countArea(context,
                        fontCol: Styles.colorB1C5E9, isOpen: true),
                    _addBtn(
                      context,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 56.h),
          width: 686.w,
          height: 8.h,
          color: Styles.color2B3347,
        ),
        Container(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 40.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                '总计金额',
                color: Styles.color999999,
                fontSize: 28,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CustomText(
                    widget.item.hashcash,
                    color: Styles.color73AAFF,
                    fontSize: 44,
                  ),
                  CustomText(
                    " USDT",
                    color: Styles.color73AAFF,
                    fontSize: 28,
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 98.h,
          width: 750.w,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 32.w,
                top: 43.h,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _value = !_value;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      width: 32.w,
                      height: 32.w,
                      child: _value
                          ? Image.asset("assets/images/common/gchoose.png",
                          fit: BoxFit.contain)
                          : Image.asset(
                        "assets/images/common/un_choose.png",
                        fit: BoxFit.contain,
                      )),
                ),
              ),
              Positioned(
                left: 77.w,
                top: 40.h,
                child: CustomText(
                  '我已经阅读并同意',
                  fontSize: 28,
                  color: Styles.colorFFFFFF,
                ),
              ),
              Positioned(
                top: 40.h,
                left: 307.w,
                child: InkWell(
                  onTap: () {
                    PopAlert.show(context,
                        child: SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 32.w,vertical: 54.h),
                                child: HtmlWidget(
                                  widget.model.shopEntity.protocol.content,
                                  webView: true,
                                  textStyle: TextStyle(color: Styles.colorFFFFFF),
                                ))),
                        isCancel: false,
                        contentHeight: 1046.h,
                        padTop: 0.h,
                        width: 750.w,
                        height: 1046.h,
                        alignment: Alignment.bottomCenter);
                  },
                  child: CustomText(
                    "《" + widget.model.shopEntity.protocol.title + "》",
                    fontSize: 28,
                    color: Color.fromRGBO(58, 134, 232, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 53.h),
          child: CustomButton(
            '立即购买',
            width: 480.w,
            height: 72.h,
            fontSize: 32.sp,
            radius: 36,
            onPressed: () {
              if (_value) {
                NavigatorUtil.push(
                    context,
                    HomeRouter.payment +
                        "?id=" +
                        widget.item.id +
                        "&realNum=" +
                        widget.item.realNum.toString() +
                        "&hashcash=" +
                        widget.item.hashcash +
                        "&payType=1&uSDTNum=" +
                        widget.model.shopEntity.wallet.uSDT);
              } else {
                ToastUtil.openToast('请先阅读协议并勾选同意！');
              }
//             Future<bool> isGoPayment = widget.model.goPayment(widget.item.id, widget.item.realNum.toString(),widget.item.hashcash,1,_value);
            },
          ),
        )
      ],
    );
  }
}

