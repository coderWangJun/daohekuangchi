import 'package:dh/entity/transfer_item_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/transfer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/utils/index.dart';

class TransferRecordPage extends StatefulWidget {
  final int type;
  final String name;

  const TransferRecordPage({Key key, this.type, this.name}) : super(key: key);

  @override
  _TransferRecordPageState createState() => _TransferRecordPageState();
}

class _TransferRecordPageState extends State<TransferRecordPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TransferViewModel>(
        model: TransferViewModel(widget.type),
        onModelReady: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return Scaffold(
              appBar: CustomAppBar(
                centerTitle: widget.name + "转账记录",
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
                                          (index) => TransferItemPage(
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

//转账记录
class TransferItemPage extends StatelessWidget {
  final TransferItemEntity item;

  const TransferItemPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool up = item.amount.indexOf("-")>=0? true :false;
    return InkWell(
      child: Container(
        height: 156.h,
        decoration: BoxDecoration(
            color: Styles.color161D30,
            border: Border(
              bottom: BorderSide(color: Styles.color2B3448, width: 2.h),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 33.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    //width: 405.w,
                    //alignment: Alignment.centerLeft,
                    child: CustomText(
                     item.note,
                      fontSize: 24,
                      color: Styles.colorWhite,
                      textAlign: TextAlign.start,
                      softWrap: true,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  CustomText(
                    item.createdAt,
                    fontSize: 24,
                    color: Styles.color9A9A9A,
                  ),
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
                    fontSize: 32,
                    color: up?Styles.colorFF6F6F:Styles.color73AAFF,
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
