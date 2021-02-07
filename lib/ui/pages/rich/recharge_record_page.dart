import 'package:dh/entity/recharge_item_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/recharge_record_view_model.dart';
import 'package:flutter/material.dart';

import 'package:dh/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RechargeRecordPage extends StatefulWidget {
  final int type;
  final String name;

  const RechargeRecordPage({Key key, this.type, this.name}) : super(key: key);

  @override
  _RechargeRecordPageState createState() => _RechargeRecordPageState();
}

class _RechargeRecordPageState extends State<RechargeRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: widget.name + "充值记录",
        fontSize: 36.sp,
        fontWeight: FontWeight.bold,
        backgroundColor: Styles.colorBackgroundColor,
      ),
      backgroundColor: Styles.colorBackgroundColor,
      body: ProviderWidget<RechargeRecordViewModel>(
        model: RechargeRecordViewModel(widget.type),
        onModelReady: (model) {
          model.refresh();
        },
        builder: (ctx, model, child) {
          return SmartRefresher(
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
                                RechargeItemPage(item: model.list[index])),
                      ),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}

//充值记录
class RechargeItemPage extends StatelessWidget {
  final RechargeItemEntity item;

  const RechargeItemPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 156.h,
        decoration: BoxDecoration(
            color: Styles.colorBackgroundColor,
            border: Border(
              bottom: BorderSide(color: Styles.color2B3448, width: 2.h),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 33.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                    item.note,
                    fontSize: 24,
                    color: Styles.colorWhite,
                  ),
                  Text(
                    item.createdAt,
                    style: Styles.theme(
                      fontSize: 24.sp,
                      color: Styles.color9A9A9A,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CustomText(
                    item.amount,
                    fontSize: 32,
                    color: Styles.color73AAFF,
                  ),
                  CustomText(item.status,
                      fontSize: 28, color: Styles.color9A9A9A),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
