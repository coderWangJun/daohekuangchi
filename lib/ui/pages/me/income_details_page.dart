import 'package:dh/entity/income_details_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/income_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/utils/index.dart';

class IncomeDetailsPage extends StatefulWidget {
  final String type;

  const IncomeDetailsPage({Key key, this.type}) : super(key: key);

  @override
  _IncomeDetailsPageState createState() => _IncomeDetailsPageState();
}

class _IncomeDetailsPageState extends State<IncomeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161D30),
      appBar: CustomAppBar(
        centerTitle: widget.type == "1"
            ? "个人挖矿收益详情"
            : widget.type == "2" ? "团队挖矿收益详情" : "社区挖矿收益详情",
        backgroundColor: Color(0xff161D30),
      ),
      body: ProviderWidget<IncomeDetailsViewModel>(
        model: IncomeDetailsViewModel(widget.type),
        onModelReady: (model) {
          model.refresh();
        },
        builder: (ctx, model, child) {
          return SmartRefresher(
              controller: model.refreshController,
              onRefresh: model.refresh,
              onLoading: model.loadMore,
              enablePullUp: true,
              child: ListView.builder(
                  itemCount: model.list.length,
                  itemBuilder: (context, index) {
                    IncomeDetailsEntity item = model.list[index];
                    return IncomeDetailsItem(item: item);
                  }));
        },
      ),
    );
  }
}

class IncomeDetailsItem extends StatelessWidget {
  final IncomeDetailsEntity item;

  const IncomeDetailsItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 684.w,
      height: 136.h,
      margin: EdgeInsets.only(left: 33.w, right: 33.w),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.w, color: Color(0xff2B3448)))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(item.note,
                  style: TextStyle(fontSize: 28.sp, color: Colors.white)),
              Text("${item.payType} ${item.reformWa} Fil",
                  style: TextStyle(fontSize: 28.sp, color: Colors.white)),
            ],
          ),
          Text(item.createdAt,
              style: TextStyle(fontSize: 24.sp, color: Color(0xff999999))),
        ],
      ),
    );
  }
}
