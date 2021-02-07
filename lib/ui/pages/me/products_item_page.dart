import 'package:dh/entity/products_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/view_model/products_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductsItemPage extends StatefulWidget {
  final String index;
  final ProductsViewModel viewModel;

  const ProductsItemPage({Key key, this.index, this.viewModel})
      : super(key: key);

  @override
  _ProductsItemPageState createState() => _ProductsItemPageState();
}

class _ProductsItemPageState extends State<ProductsItemPage> {
  @override
  void initState() {
    widget.viewModel.setType(widget.index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ProviderWidget<ProductsViewModel>(
          model: widget.viewModel,
          onModelReady: (model) {
            Future.delayed(Duration(milliseconds: 100), () {
              model.refresh();
            });
          },
          builder: (ctx, model, child) {
            return Container(
              color: Color(0xff161D30),
              child: widget.index == "1"
                  ? SmartRefresher(
                      controller: model.refreshController,
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      enablePullUp: true,
                      child: ListView.builder(
                          itemCount: model.list.length,
                          itemBuilder: (context, index) {
                            ProductsEntity item = model.list[index];
                            return ProductsListItemPage(
                                item: item, index: index);
                          }))
                  : Container(
                      alignment: Alignment.topCenter,
                      padding: EdgeInsets.only(top: 80.h),
                      child: Text("暂未开放",
                          style:
                              TextStyle(fontSize: 30.sp, color: Colors.white)),
                    ),
            );
          },
        ));
  }
}

class ProductsListItemPage extends StatelessWidget {
  final int index;
  final ProductsEntity item;

  const ProductsListItemPage({Key key, this.item, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 686.w,
      margin: EdgeInsets.only(
          left: 32.w, right: 32.w, top: index == 0 ? 0.h : 48.h),
      padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 30.h),
      decoration: BoxDecoration(
          color: Color(0xff1E2538), borderRadius: BorderRadius.circular(20.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 112.h,
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.w, color: Color(0xff2B3448)))),
            child: Text("订单编号${item.ordersn}",
                style: TextStyle(fontSize: 28.sp, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.h),
            child: Text(item.hashname,
                style: TextStyle(fontSize: 26.sp, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Text("单价：${item.hashnum.toString()}",
                style: TextStyle(fontSize: 26.sp, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Text("数量：${item.inveshu}",
                style: TextStyle(fontSize: 26.sp, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Text("下单时间：${item.createdAt}",
                style: TextStyle(fontSize: 26.sp, color: Colors.white)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.h),
            child: Text("支付金额：${item.expend}",
                style: TextStyle(fontSize: 26.sp, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
