import 'package:dh/entity/notice_list_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/view_model/help_center_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/utils/index.dart';

class HelpListPage extends StatefulWidget {
  final String type;

  const HelpListPage({Key key, this.type}) : super(key: key);

  @override
  _HelpListPageState createState() => _HelpListPageState();
}

class _HelpListPageState extends State<HelpListPage> {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HelpCenterListViewModel>(
      model: HelpCenterListViewModel(type: widget.type),
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
                  NoticeListEntity item = model.list[index];
                  return NoticeListItem(
                    item: item,
                    type: widget.type,
                  );
                }));
      },
    );
  }
}

class NoticeListItem extends StatelessWidget {
  final NoticeListEntity item;
  final String type;

  const NoticeListItem({Key key, this.item, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        NavigatorUtil.push(
            context, MeRouter.helpDetails + "?id=${item.id}" + "&type=$type");
      },
      child: Container(
        width: 684.w,
        height: 136.h,
        margin: EdgeInsets.only(left: 33.w, right: 33.w),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.w, color: Color(0xff2B3448)))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 334.w,
                  child: Text(item.title,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 28.sp, color: Colors.white)),
                ),
                Image.asset(
                  "assets/images/mine/more.png",
                  width: 48.w,
                  height: 48.h,
                )
              ],
            ),
            Text(item.senddate,
                style: TextStyle(fontSize: 24.sp, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
