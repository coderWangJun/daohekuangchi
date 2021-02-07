import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/withdraw_record_view_model.dart';
import 'package:dh/entity/withdraw_item_entity.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/utils/index.dart';

class WithdrawRecordPage extends StatefulWidget {
  final int type;
  final String name;

  const WithdrawRecordPage({Key key, this.type, this.name}) : super(key: key);

  @override
  _WithdrawRecordPageState createState() => _WithdrawRecordPageState();
}

class _WithdrawRecordPageState extends State<WithdrawRecordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<WithdrawRecordViewModel>(
        model: WithdrawRecordViewModel(widget.type),
        onModelReady: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return Scaffold(
              appBar: CustomAppBar(
                centerTitle: widget.name + "提币记录",
                fontSize: 36.sp,
                fontWeight: FontWeight.bold,
                backgroundColor: Styles.colorBackgroundColor,
              ),
              backgroundColor: Styles.colorBackgroundColor,
              body: Builder(builder: (_) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: 1.h,
                      color: Styles.color2B3448,
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
                                  padding:
                                      EdgeInsets.only(left: 0.h, right: 0.h),
                                  sliver: new SliverList(
                                    delegate: SliverChildListDelegate(
                                      //返回组件集合
                                      List.generate(
                                          model.list.length,
                                          (index) => WithdrawItemPage(
                                              item: model.list[index])),
                                    ),
                                  ),
                                ),
                              ],
                            )))
                  ],
                );
              }));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

//充值记录
class WithdrawItemPage extends StatelessWidget {
  final WithdrawItemEntity item;

  const WithdrawItemPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool up = item.amount.indexOf("-") >= 0 ? true : false;
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
          children: <Widget>[
            Container(
              width: 338.w,
              padding: EdgeInsets.only(left: 33.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.note,
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: Styles.theme(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                      color: Styles.colorWhite,
                    ),
                  ),
                  Text(
                    item.createdAt,
                    style: Styles.theme(
                      fontSize: 24.sp,
                      color: Styles.color9A9A9A,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 33.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  CustomText(
                    item.amount,
                    fontSize: 24,
                    color: !up ? Styles.colorFF6F6F : Styles.color73AAFF,
                  ),
                  CustomText(
                    item.status,
                    fontSize: 28,
                    color: Styles.color9A9A9A,
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
