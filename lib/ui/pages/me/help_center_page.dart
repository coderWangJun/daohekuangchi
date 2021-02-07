import 'package:dh/ui/pages/me/help_list_page.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class HelpCenterPage extends StatefulWidget {
  final int index;

  const HelpCenterPage({Key key, this.index}) : super(key: key);

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var currentPage = 0;
  var isPageCanChanged = true;
  PageController mPageController;

  @override
  void initState() {
    super.initState();
    this._tabController = new TabController(
        vsync: this,
        length: 3,
        initialIndex: widget.index == null ? 0 : widget.index);
    mPageController =
        PageController(initialPage: widget.index == null ? 0 : widget.index);
//    this._tabController.addListener(() {});
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
      appBar: CustomAppBar(
        isBack: true,
        backgroundColor: Color(0xff4989EB),
      ),
      body: DefaultTabController(
        length: 3,
        initialIndex: widget.index == null ? 0 : widget.index,
        child: Column(
          children: <Widget>[
            Container(
              width: 750.w,
              height: 210.h,
              padding: EdgeInsets.only(top: 40.h, bottom: 70.h, left: 34.w),
              decoration: BoxDecoration(
                  color: Color(0xff4989EB),
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/mine/help_bg.png",
                    ),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("帮助中心",
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text("随时随地为您提供帮助",
                      style: TextStyle(fontSize: 28.sp, color: Colors.white)),
                ],
              ),
            ),
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: 750.w,
                  height: 112.h,
                ),
                Positioned(
                  top: -20.h,
                  child: Container(
                    width: 750.w,
                    height: 112.h,
                    decoration: BoxDecoration(
                        color: Color(0xff1E2538),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.w),
                            topRight: Radius.circular(20.w))),
                    child: TabBar(
                      controller: _tabController,
                      unselectedLabelColor: Color(0xff999999),
                      labelColor: Color(0xff5591EF),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Color(0xff5591EF),
                      indicatorPadding: EdgeInsets.all(0),
                      labelStyle:
                          TextStyle(fontSize: 28.sp, color: Color(0xff5591EF)),
                      tabs: <Widget>[
                        Tab(text: "公告中心"),
                        Tab(text: "常见问题"),
                        Tab(text: "新手指南"),
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
                itemCount: 3,
                onPageChanged: (index) {
                  if (isPageCanChanged) {
                    //由于pageview切换是会回调这个方法,又会触发切换tabbar的操作,所以定义一个flag,控制pageview的回调
                    onPageChange(index);
                  }
                },
                controller: mPageController,
                itemBuilder: (BuildContext context, int index) {
                  var type = index + 1;
                  return HelpListPage(
                    type: type.toString(),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
