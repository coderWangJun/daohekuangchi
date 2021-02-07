import 'package:dh/entity/address_item_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/module/rich_router.dart';
import 'package:dh/ui/pages/rich/address_list_page.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/utils/index.dart';
import 'package:dh/view_model/addr_view_model.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  final int type;

  const AddressPage({Key key, this.type}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  var currentPage = 0;
  var isPageCanChanged = true;
  PageController mPageController;

  @override
  void initState() {
    super.initState();
    mPageController = PageController(initialPage: widget.type);
    this._tabController =
        new TabController(vsync: this, length: 2, initialIndex: widget.type);
    this._tabController.addListener(() {});
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

  AddressItemEntity address;

  AddrViewModel _viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          centerTitle: "选择地址",
          fontSize: 36.sp,
          fontWeight: FontWeight.bold,
          backgroundColor: Styles.colorBackgroundColor,
          isBack: true,
          actionName: "添加地址",
          onPressed: () {
            NavigatorUtil.pushResult(
                context,
                RichRouter.addAddress +
                    "?type=" +
                    _viewModel.addrType.toString(),
                (res) => {_viewModel.refresh()});
          },
          onBack: () {
            if (_viewModel != null) {
              address = _viewModel.list.length == 0
                  ? AddressItemEntity.fromJson({})
                  : _viewModel.list[_viewModel.index];
              NavigatorUtil.popResult(context, address);
            } else {
              NavigatorUtil.pop(context);
            }
          },
        ),
        body: DefaultTabController(
          length: 2, //项的数量
          initialIndex: 0, //默认选择第一项
          child: ProviderWidget<AddrViewModel>(
            model: AddrViewModel(widget.type),
            onModelReady: (model) {
              _viewModel = model;
              _viewModel.setAddrType(widget.type);
            },
            builder: (ctx, model, child) {
              return Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Styles.colorBackgroundColor,
                        border: Border(
                            bottom: BorderSide(
                                color: Styles.color2B3448, width: 2.h))),
                    child: TabBar(
                      controller: _tabController,
                      unselectedLabelColor: Styles.color999999,
                      labelColor: Styles.color5591EF,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Styles.color498FEA,
                      indicatorPadding: EdgeInsets.all(0),
                      labelStyle: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w500,
                          color: Styles.color5591EF),
                      tabs: <Widget>[
                        Tab(text: "USDT地址"),
                        Tab(text: "Fil地址"),
                      ],
                      onTap: (index) {
                        _viewModel.setAddrType(index);
                        mPageController.jumpToPage(index);
                      },
                    ),
                  ),
                  Container(
                    height: 62.h,
                    color: Styles.colorBackgroundColor,
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
                        return AddressListPage(
                          addrType: index,
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
