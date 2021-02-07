import 'package:dh/entity/flow_item_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/flow_view_model.dart';
import 'package:flutter/material.dart';

import 'package:dh/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FlowPage extends StatefulWidget {
  final int type;
  final String name;

  const FlowPage({Key key, this.type, this.name}) : super(key: key);

  @override
  _FlowPageState createState() => _FlowPageState();
}

class _FlowPageState extends State<FlowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: "",
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        backgroundColor: Styles.colorBackgroundColor,
      ),
      backgroundColor: Styles.colorBackgroundColor,
      body: ProviderWidget<FlowViewModel>(
        model: FlowViewModel(widget.type),
        onModelReady: (model) {
          model.refresh();
        },
        builder: (ctx, model, child) {
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 30.w),
                height: 244.h,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 112.h,
                      child: Text(
                        widget.name + "资产",
                        style: Styles.theme(
                            fontSize: 56.sp,
                            fontWeight: FontWeight.w500,
                            color: Styles.color73AAFF),
                      ),
                    ),
                    Container(
                      height: 132.h,
                      padding: EdgeInsets.only(left: 10.w),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Styles.color2B3448, width: 1.w))),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 122.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("可用",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24.sp,
                                        color: Styles.colorE1E1E1)),
                                Text(model.usable,
                                    style: Styles.theme(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          ),
                          Container(
                            height: 122.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("冻结",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24.sp,
                                        color: Styles.colorE1E1E1)),
                                Text(model.freeze,
                                    style: Styles.theme(
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          ),
                          Container(
                            height: 122.h,
                            width: 228.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("折合(CNY)",
                                    style: Styles.theme(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 24.sp,
                                        color: Styles.colorE1E1E1)),
                                Text(model.cny,
                                    style: Styles.theme(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28.sp,
                                        color: Styles.colorWhite)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 12.h,
                color: Styles.color0D1220,
              ),
              Expanded(
                  child: SmartRefresher(
                      controller: model.refreshController,
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      enablePullUp: true,
                      child: CustomScrollView(
                        //controller: model.scrollController,
                        slivers: <Widget>[
                          SliverPadding(
                            padding: EdgeInsets.only(left: 0.h, right: 0.h),
                            sliver: new SliverList(
                              delegate: SliverChildListDelegate(
                                //返回组件集合
                                List.generate(
                                    model.list.length,
                                    (index) =>
                                        FlowItemPage(item: model.list[index])),
                              ),
                            ),
                          ),
                        ],
                      )))
            ],
          );
        },
      ),
    );
  }
}

//流水记录
class FlowItemPage extends StatelessWidget {
  final FlowItemEntity item;

  const FlowItemPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool up = item.payType == "+" ? true : false;
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 33.w),
        decoration: BoxDecoration(
            color: Styles.colorBackgroundColor,
            border: Border(
                bottom: BorderSide(
                    color: Styles.color2B3448, width: 1.h),
                top: BorderSide(
                    color: Styles.color2B3448, width: 1.h))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CustomText(
                    item.note,
                    fontSize: 28,
                    color: Styles.colorWhite,
                  ),
                  CustomText(
                    item.payType + item.reformWa,
                    fontSize: 28,
                    color: Styles.colorWhite,
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
//                  Expanded(
//                    child: Container(
//                      padding: EdgeInsets.only(top: 15.h),
//                      alignment: Alignment.centerLeft,
//                      child: Text(
//                        item.note,
//                        style: TextStyle(
//                          fontSize: 24.sp,
//                          color: Styles.color999999,
//                        ),
//                        softWrap: true,
//                      ),
//                    ),
//                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15.h),
                    child: CustomText(
                      item.createdAt,
                      width: 250.w,
                      fontSize: 24,
                      color: Styles.color9A9A9A,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
