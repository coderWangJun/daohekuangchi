import 'package:dh/entity/shared_records_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/ui/pages/home/invite_records_item_page.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/intite_record_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InviteRecordPage extends StatefulWidget {
  @override
  _InviteRecordPageState createState() => _InviteRecordPageState();
}

class _InviteRecordPageState extends State<InviteRecordPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var currentPage = 0;
  var isPageCanChanged = true;
  PageController mPageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(vsync: this, length: 2);
    this._tabController.addListener(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  onPageChange(int index, {PageController p, TabController t}) async {
    if (p != null) {
      //判断是哪一个切换
      isPageCanChanged = false;
      await mPageController.animateToPage(index,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease); //等待pageview切换完毕,再释放pageivew监听
      isPageCanChanged = true;
    } else {
      _tabController.animateTo(index); //切换Tabbar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff161D30),
        appBar: AppBar(
          title: Text("我的奖励"),
          backgroundColor: Color(0xff4989EB),
          elevation: 0,
        ),
        body: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: ProviderWidget<InviteRecordViewModel>(
            model: InviteRecordViewModel(),
            builder: (ctx, model, child) {
              return Column(
                children: <Widget>[
                  Container(
                      width: 750.w,
                      height: 380.h,
                      decoration: BoxDecoration(color: Color(0xff4989EB)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 50.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.teamNum,
                                        style: TextStyle(
                                            fontSize: 40.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("累计邀请人数",
                                        style: TextStyle(
                                            fontSize: 26.sp,
                                            color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.inviteNum,
                                        style: TextStyle(
                                            fontSize: 40.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("累计购买人数",
                                        style: TextStyle(
                                            fontSize: 26.sp,
                                            color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 50.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.referNum,
                                        style: TextStyle(
                                            fontSize: 40.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("累计推广算力",
                                        style: TextStyle(
                                            fontSize: 26.sp,
                                            color: Colors.white)),
                                    Text("(TB)",
                                        style: TextStyle(
                                            fontSize: 26.sp,
                                            color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(model.totalAmount,
                                        style: TextStyle(
                                            fontSize: 40.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text("累计获得佣金",
                                        style: TextStyle(
                                            fontSize: 26.sp,
                                            color: Colors.white)),
                                    Text("(USDT)",
                                        style: TextStyle(
                                            fontSize: 26.sp,
                                            color: Colors.white)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Container(
                        width: 750.w,
                        height: 80.h,
                        color: Color(0xff161D30),
                      ),
                      Positioned(
                        top: -60.h,
                        child: Container(
                          width: 686.w,
                          height: 112.h,
                          margin: EdgeInsets.only(left: 32.w, right: 32.w),
                          decoration: BoxDecoration(
                              color: Color(0xff1E2538),
                              borderRadius: BorderRadius.circular(20.w)),
                          child: TabBar(
                            controller: _tabController,
                            unselectedLabelColor: Color(0xff999999),
                            labelColor: Color(0xff5591EF),
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Color(0xff5591EF),
                            indicatorPadding: EdgeInsets.all(0),
                            labelStyle: TextStyle(
                                fontSize: 28.sp, color: Color(0xff5591EF)),
                            tabs: <Widget>[
                              Tab(text: "邀请记录"),
                              Tab(text: "返佣记录"),
                            ],
                            onTap: (index) {
                              mPageController.jumpToPage(index);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: PageView.builder(
                      itemCount: 2,
                      onPageChanged: (index) {
                        if (isPageCanChanged) {
                          //由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                          onPageChange(index);
                        }
                      },
                      controller: mPageController,
                      itemBuilder: (BuildContext context, int index) {
                        var type = index + 1;
                        return InviteRecordsItemPage(
                          index: type.toString(),
                          viewModel: model,
                        );
                      },
                    ),
                  )
                ],
              );
            },
          ),
        ));
  }
}

class SingleRecord extends StatelessWidget {
  final SharedRecordsEntity item;

  const SingleRecord({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      height: 136.h,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 32.w,
            top: 39.h,
            child: CustomText(
              item.note,
              fontSize: 28,
              color: Color.fromRGBO(51, 51, 51, 1),
            ),
          ),
          Positioned(
            left: 33.w,
            top: 82.h,
            child: CustomText(
              item.createdAt,
              fontSize: 24,
              color: Color.fromRGBO(153, 153, 153, 1),
            ),
          ),
          Positioned(
            right: 30.w,
            top: 67.h,
            child: CustomText(
              item.reformWa,
              fontSize: 24,
              color: Color.fromRGBO(250, 150, 69, 1),
            ),
          ),
          Positioned(
              left: 32.w,
              top: 134.h,
              child: Container(
                  width: 686.w,
                  height: 2.h,
                  color: Color.fromRGBO(244, 244, 244, 1))),
        ],
      ),
    );
  }
}
