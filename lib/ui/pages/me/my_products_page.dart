import 'package:dh/provider/provider_widget.dart';
import 'package:dh/ui/pages/me/products_item_page.dart';
import 'package:dh/view_model/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';

class MyProductsPage extends StatefulWidget {
  @override
  _MyProductsPageState createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> with SingleTickerProviderStateMixin {
  TabController _tabController;
  var currentPage = 0;
  var isPageCanChanged = true;
  PageController mPageController = PageController(initialPage: 0);
  int type = 0;

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
        title: Text("订单管理"),
        backgroundColor: Color(0xff4989EB),
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: ProviderWidget<ProductsViewModel>(
          model: ProductsViewModel(),
          builder: (ctx,model,child) {
            return Column(
              children: <Widget>[
                Container(
                    width: 750.w,
                    height: 288.h,
                    decoration: BoxDecoration(
                        color: Color(0xff4989EB)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(model.myAmount,style: TextStyle(fontSize: 40.sp,color: Colors.white,fontWeight: FontWeight.bold)),
                            Text("我的算力",style: TextStyle(fontSize: 26.sp,color: Colors.white)),
                            Text("(TB)",style: TextStyle(fontSize: 26.sp,color: Colors.white)),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(model.profit,style: TextStyle(fontSize: 40.sp,color: Colors.white,fontWeight: FontWeight.bold)),
                            Text("我的理财",style: TextStyle(fontSize: 26.sp,color: Colors.white)),
                            Text("(USDT)",style: TextStyle(fontSize: 26.sp,color: Colors.white)),
                          ],
                        ),
                      ],
                    )
                ),
                Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Container(
                      width: 750.w,
                      height: 112.h,
                      color: Color(0xff161D30),
                    ),
                    Positioned(
                      top: -60.h,
                      child: Container(
                        width: 686.w,
                        height: 112.h,
                        margin: EdgeInsets.only(left: 32.w,right: 32.w),
                        decoration: BoxDecoration(
                            color: Color(0xff1E2538),
                            borderRadius: BorderRadius.circular(20.w)
                        ),
                        child: TabBar(
                          controller: _tabController,
                          unselectedLabelColor: Color(0xff999999),
                          labelColor: Color(0xff5591EF),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor:Color(0xff5591EF),
                          indicatorPadding: EdgeInsets.all(0),
                          labelStyle: TextStyle(
                              fontSize: 28.sp,
                              color: Color(0xff5591EF)),
                          tabs: <Widget>[
                            Tab(text: "云算力订单"),
                            Tab(text: "理财订单"),
                          ],
                          onTap: (index){
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
                      var type = index+1;
                      return ProductsItemPage(index: type.toString(),viewModel: model,);
                    },
                  ),
                )
              ],
            );
          },
        ),
      )
    );
  }
}
