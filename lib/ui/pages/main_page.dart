import 'package:dh/res/styles.dart';
import 'package:dh/ui/pages/app/app_page.dart';
import 'package:dh/ui/widgets/custom_load_image.dart';
import 'package:flutter/material.dart';

import 'package:dh/utils/index.dart';

import 'home/home_page.dart';
import 'me/me_page.dart';
import 'shop//shop_page.dart';
import 'rich/rich_page.dart';

List<Widget> pages = <Widget>[
  HomePage(),
  AppPage(),
  ShopPage(),
  RichPage(),
  MePage()
//  DealPage(),
//  CouponPage(),
//  MePage()
];

class MainPage extends StatefulWidget {
  final int current;

  MainPage({Key key, this.current: 0}) : super(key: key);

  @override
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  var _pageController;
  int _selectedIndex = 0;

  var _appBarTitles = ['首页', '应用', 'IPFS算力', '资产', '我的'];
  List<BottomNavigationBarItem> _list;

  List<BottomNavigationBarItem> _buildBottomNavigationBarItem() {
    if (_list == null) {
      var _tabImages = [
        [
          LoadAssetImage(
            'tabbar/icon_home.png',
            width: 40.h,
            height: 40.h,
          ),
          LoadAssetImage('tabbar/icon_home_hl.png', width: 40.h, height: 40.h),
        ],
        [
          LoadAssetImage('tabbar/icon_ying.png', width: 40.h, height: 40.h),
          LoadAssetImage('tabbar/icon_ying_hl.png', width: 40.h, height: 40.h),
        ],
        [
          LoadAssetImage('tabbar/icon_suan.png', width: 40.h, height: 40.h),
          LoadAssetImage('tabbar/icon_suan_hl.png', width: 40.h, height: 40.h),
        ],
        [
          LoadAssetImage('tabbar/icon_rich.png', width: 40.h, height: 40.h),
          LoadAssetImage('tabbar/icon_rich_hl.png', width: 40.h, height: 40.h),
        ],
        [
          LoadAssetImage('tabbar/me.png', width: 40.h, height: 40.h),
          LoadAssetImage('tabbar/me_hl.png', width: 40.h, height: 40.h),
        ]
      ];
      _list = List.generate(5, (i) {
        return BottomNavigationBarItem(
            icon: _tabImages[i][0],
            activeIcon: _tabImages[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(_appBarTitles[i], key: Key(_appBarTitles[i])),
            ));
      });
    }
    return _list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //
    _selectedIndex = widget.current;
    setState(() {
      if (mounted)
        _pageController = PageController(initialPage: _selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
      body: PageView.builder(
        itemBuilder: (ctx, index) => pages[index],
        itemCount: pages.length,
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Styles.color1E2638,
        type: BottomNavigationBarType.fixed,
        items: _buildBottomNavigationBarItem(),
        selectedItemColor: Styles.color98C1FF,
        unselectedItemColor: Styles.color9A9A9A,
        // 选中字体颜色
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController?.dispose();
    super.dispose();
  }
}
