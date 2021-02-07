import 'package:dh/entity/home_entity.dart';
import 'package:dh/routers/module/home_router.dart';
import 'package:dh/routers/module/me_router.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/view_model/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/routers.dart';
import 'package:dh/ui/widgets/MyNoticeVecAnimation.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  ScrollController _scrollController = new ScrollController();
  int current = 1;
  List<String> images = [];
  List<String> Notices = [];
  List<Above> aboves = [];
  List<LtcList> ltcLists = [];

  double padding = 0;

//  String USDTNum = "0";
  HomeEntity homePageEntity = new HomeEntity();
  var ltcListData;
  ScrollController _recordScrollController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {});
    _recordScrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var goUrl = "https://cn.etherscan.com";
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: " ",
        fontSize: 36.sp,
        backgroundColor: Styles.colorBackgroundColor,
        isBack: false,
        isLogo: true,
        logoImg: "assets/images/common/LOGOa.png",
        logoWidth: 220.w,
      ),
      backgroundColor: Styles.colorBackgroundColor,
      body: ProviderWidget<HomeViewModel>(
        model: HomeViewModel(),
        onModelReady: (model) {
          //初始化页面
          model.refresh().then((res) {
            images = model.bannerItems;
            Notices = model.hotSearchTag;
            aboves = model.above;
            ltcLists = model.ltcLists;

            homePageEntity = model.homeEntity;
          });
//          print(ltcList);
        },
        builder: (ctx, model, child) {
          return ListView(
            children: <Widget>[
              //banner
              Container(
                width: 694.w,
                height: 280.h,
                margin: EdgeInsets.only(top: 10.h, left: 32.w, right: 32.w),
                child: model.bannerItems.length == 0
                    ? Container()
                    : Swiper(
                  itemCount: model.bannerItems.length,
                  itemBuilder: _swiperBuilder,
                  pagination: SwiperPagination(
                      alignment: Alignment.bottomRight,
                      builder: DotSwiperPaginationBuilder(
                          color: Color.fromRGBO(255, 255, 255, 0.5),
                          size: 12.sp,
                          activeSize: 12.sp,
                          activeColor: Color.fromRGBO(255, 255, 255, 1))),
                  scrollDirection: Axis.horizontal,
                  autoplay: true,
                ),
              ),
              //公告
              Container(
                width: 700.w,
                height: 83.h,
                margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 15.h),
                decoration: BoxDecoration(),
                child: GestureDetector(
                  onTap: () {
                    NavigatorUtil.push(context, Routers.post);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Image.asset(
                          "assets/images/home/icon_news.png",
                          width: 32.w,
                          height: 32.h,
                        ),
                      ),
                      Expanded(
                        child: MyNoticeVecAnimation(
                          duration: const Duration(milliseconds: 6000),
                          messages: model.hotSearchTag,
                          color: Styles.colorFFFFFF,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: Image.asset(
                          "assets/images/home/read.png",
                          width: 32.w,
                          height: 32.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //中间的四个导航
              Container(
                height: 160.h,
                width: 750.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/home/icon_chongzhi.png",
                            width: 88.w,
                            height: 88.w,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18.h),
                            child: Text(
                              '充币',
                              style: TextStyle(color: Styles.colorFFFFFF,fontSize: 26.sp),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorUtil.push(
                            context, RichRouter.recharge + "?token="+model.homeEntity.wallet.walletToken);
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/home/icon-zhinan.png",
                            width: 88.w,
                            height: 88.w,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18.h),
                            child: Text(
                              '新手指南',
                              style: TextStyle(color: Styles.colorFFFFFF,fontSize: 26.sp),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorUtil.push(
                            context, MeRouter.helper + "?index=2");
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/home/icon_zhuanz.png",
                            width: 88.w,
                            height: 88.w,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18.h),
                            child: Text(
                              '联系客服',
                              style: TextStyle(color: Styles.colorFFFFFF,fontSize: 26.sp),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorUtil.push(context, MeRouter.service);
                      },
                    ),
                    InkWell(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/home/icon_oilcard.png",
                            width: 88.w,
                            height: 88.w,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 18.h),
                            child: Text(
                              '区块浏览器',
                              style: TextStyle(color: Styles.colorFFFFFF,fontSize: 26.sp),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        NavigatorUtil.push(
                            context,
                            Routers.web +
                                "?title="+
                                Uri.encodeComponent('区块浏览器')+"&url=" +
                                Uri.encodeComponent(goUrl));
                      },
                    ),
                  ],
                ),
              ),

              //资产数据
              Container(
                width: 750.w,
                height: 206.h,
                padding: EdgeInsets.only(
                  left: 35.w,
                  right: 35.w,
                ),
                color: Styles.colorBackgroundColor,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
//                    itemCount: model.usdtList.length,
                  itemCount: aboves.length,
                  itemBuilder: (BuildContext context, int index) {
                    Above item = aboves[index];

                    return InkWell(
                      onTap: () {},
                      child: Container(
                        color: Styles.color1D2537,
                        width: 220.w,
                        height: 206.h,
                        margin: EdgeInsets.only(right: 10.w),
                        padding: EdgeInsets.symmetric(vertical: 30.h),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(item.name,
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    color: Styles.colorFFFFFF)),
                            Text(item.price,
                                style: TextStyle(
                                    fontSize: 36.sp,
                                    color:
                                    double.parse(item.ratiochange) >= 0.00
                                        ? Styles.colorF75A5A
                                        : Styles.color60D487)),
                            Text(item.ratiochange + "%",
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color:
                                    double.parse(item.ratiochange) >= 0.00
                                        ? Styles.colorF75A5A
                                        : Styles.color60D487)),
                            Text(item.rMB + "CNY",
                                style: TextStyle(
                                    fontSize: 24.sp,
                                    color: Styles.colorB1C5E9)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //邀请广告
              Container(
                margin: EdgeInsets.only(top: 30.h, bottom: 10.h,left: 32.w,right: 32.w),
                height: 200.h,
                child: InkWell(
                  onTap: () {
                    NavigatorUtil.push(context, HomeRouter.invite);
                  },
                  child: Image.network(
                      'https://lanhu.oss-cn-beijing.aliyuncs.com/ps5f3404b9b21462b2-35a4-4d84-8623-46ba5ba1546e'),
                ),
                width: 686.w,
              ),
              Container(
                width: 750.w,
                height: 98.h,
                padding: EdgeInsets.only(left: 33.w),
                alignment: Alignment.centerLeft,
                child: Text("24H涨幅榜",
                    style:
                    TextStyle(fontSize: 34.sp, color: Styles.colorFFFFFF)),
              ),
//                24小时涨幅榜titile
              Container(
                width: 686.w,
                height: 48.h,
                margin: EdgeInsets.only(left: 32.w, right: 32.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      width: 228.w,
                      child: Text("名称",
                          style: TextStyle(
                              fontSize: 26.sp, color: Styles.colorFFFFFF)),
                    ),
                    Container(
                      width: 228.w,
                      child: Text("最新价",
                          style: TextStyle(
                              fontSize: 26.sp, color: Styles.colorFFFFFF)),
                    ),
                    Container(
                      width: 228.w,
                      alignment: Alignment.centerRight,
                      child: Text("涨跌幅",
                          style: TextStyle(
                              fontSize: 26.sp, color: Styles.colorFFFFFF)),
                    ),
                  ],
                ),
              ),
              //涨幅榜列表
              Container(
                width: 750.w,
                height: 400.h,
                child: SmartRefresher(
                  controller: model.refreshController,
                  enablePullUp: true,
                  onRefresh: model.refresh,
                  onLoading: model.loadMore,
                  child: CustomScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverPadding(
                        padding: EdgeInsets.only(left: 0, right: 0),
                        sliver: new SliverList(
                          delegate: SliverChildListDelegate(List.generate(
                              ltcLists.length,
                                  (index) => ItemDetails(
                                item: ltcLists[index],
                                index: index + 1,
                              ))),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  //轮播图
  Widget _swiperBuilder(BuildContext context, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: Image.network(images[index], fit: BoxFit.cover),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController?.dispose();
    _recordScrollController?.dispose();
    super.dispose();
  }
}

class ItemDetails extends StatelessWidget {
  final int index;

  final LtcList item;

  const ItemDetails({Key key, this.item, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 686.w,
        height: 101.h,
        margin: EdgeInsets.only(left: 32.w, right: 32.w),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Styles.color2B3347, width: 1.w))),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 14.w, bottom: 9.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.name,
                        style: TextStyle(
                            fontSize: 32.sp, color: Styles.colorFFFFFF)),
//                    Row(
//                      children: <Widget>[
//                        Text("PYC",
//                            style: TextStyle(
//                                fontSize: 32.sp, color: Styles.colorFFFFFF)),
//                        Text("/CNY",
//                            style: TextStyle(
//                                fontSize: 24.sp, color: Styles.colorA5A5A5)),
//                      ],
//                    ),
                    Text("24H量"+item.tradeshu,
                        style: TextStyle(
                            fontSize: 24.sp, color: Styles.colorA5A5A5))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 14.w, bottom: 9.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.price,
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: double.parse(item.ratiochange) >= 0.00
                              ? Styles.colorFF5F59
                              : Styles.color60D487,
                        )),
                    Text("≈￥"+item.rMB,
                        style: TextStyle(
                            fontSize: 24.sp, color: Styles.colorA5A5A5))
                  ],
                ),
              ),
            ),
            Container(
              width: 144.w,
              height: 64.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: double.parse(item.ratiochange) >= 0.00
                      ? Styles.colorFF5F59
                      : Styles.color60D487,
                  borderRadius: BorderRadius.circular(6)),
              child: Text(item.ratiochange+"%",
                  style: TextStyle(fontSize: 28.sp,
                      color: Styles.colorFFFFFF
                  )),
            )
          ],
        ),
      ),
    );
  }
}
