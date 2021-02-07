import 'package:dh/entity/products_entity.dart';
import 'package:dh/entity/shared_records_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/view_model/intite_record_view_model.dart';
import 'package:dh/view_model/products_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteRecordsItemPage extends StatefulWidget {
  final String index;
  final InviteRecordViewModel viewModel;

  const InviteRecordsItemPage({Key key, this.index, this.viewModel})
      : super(key: key);

  @override
  _InviteRecordsItemPageState createState() => _InviteRecordsItemPageState();
}

class _InviteRecordsItemPageState extends State<InviteRecordsItemPage> {
  @override
  void initState() {
    widget.viewModel.setType(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ProviderWidget<InviteRecordViewModel>(
          model: widget.viewModel,
          onModelReady: (model) {
            Future.delayed(Duration(milliseconds: 100), () {
              model.refresh();
            });
          },
          builder: (ctx, model, child) {
            return Container(
              color: Color(0xff161D30),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 686.w,
                    height: 111.w,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1.w, color: Color(0xff2B3448)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.index == "1" ? "用户信息" : "收益类型",
                            style: TextStyle(
                                fontSize: 28.sp, color: Colors.white)),
                        Text(widget.index == "1" ? "注册时间" : "金额",
                            style: TextStyle(
                                fontSize: 28.sp, color: Colors.white)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: SmartRefresher(
                          controller: model.refreshController,
                          onRefresh: model.refresh,
                          onLoading: model.loadMore,
                          enablePullUp: true,
                          child: ListView.builder(
                              itemCount: model.list.length,
                              itemBuilder: (context, index) {
                                SharedRecordsEntity item = model.list[index];
                                return ProductsListItemPage(
                                    item: item, index: widget.index);
                              })),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}

class ProductsListItemPage extends StatelessWidget {
  final String index;
  final SharedRecordsEntity item;

  const ProductsListItemPage({Key key, this.item, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 686.w,
      height: 111.w,
      margin: EdgeInsets.only(
        left: 32.w,
        right: 32.w,
      ),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.w, color: Color(0xff2B3448)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(index == "1" ? item.username : item.note,
                  style: TextStyle(fontSize: 28.sp, color: Colors.white)),
              Text(index == "2" ? item.createdAt : "",
                  style: TextStyle(fontSize: 24.sp, color: Color(0xff999999)))
            ],
          ),
          Text(index == "1" ? item.createdAt : item.reformWa,
              style: TextStyle(
                  fontSize: 28.sp,
                  color: index == "1" ? Color(0xff999999) : Colors.white))
        ],
      ),
    );
  }
}
