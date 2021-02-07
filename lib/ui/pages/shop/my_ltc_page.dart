import 'package:dh/view_model/ltc_view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';

import 'package:dh/ui/widgets/cached_image.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_text.dart';



class MyLtcPage extends StatefulWidget {
  @override
  _MyLtcPageState createState() => _MyLtcPageState();
}
class _MyLtcPageState extends State<MyLtcPage>{
  ScrollController _scrollController =
  new ScrollController();
  int current = 1;

  List<int> carNums = [1,4,3];
  double padding = 0;
  ScrollController _recordScrollController;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {});
    _recordScrollController = new ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "我的矿机",
        fontSize: 36.sp,
        backgroundColor: Styles.colorWhite,


      ),
      backgroundColor: Styles.colorWhite,
      body: ProviderWidget<LtcViewModel>(
        model: LtcViewModel(2),
        onModelReady: (model) {
          //初始化页面
          model.refresh().then((res) {

          });
        },
        builder: (ctx, model, child) {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                //中间的两个导航
                Container(
                  margin: EdgeInsets.only(top: 24.h),
                  height: 172.h,
                  width: 684.w,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 686.w,
                        height: 172.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/shop/bg_p_b.png'
                                ),
                                fit: BoxFit.contain
                            )
                        ),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 23.h),
                          child: CustomText(model.ltcEntity.cash+'TB',fontSize: 36,color: Styles.colorWhite,),
                        ),
                      ),

                      Positioned(
                        left: 274.w,
                        top: 98.h,
                        child: CustomText('我的矿机',fontSize: 36,color: Styles.colorWhite,),
                      ),
                    ],
                  ),
                ),


                //云算力内容
                Container(
                  margin: EdgeInsets.only(top: 41.h),
                  height: 840.h,
                  width: 750.w,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: _refinedOil(model),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  //矿机
  Widget _refinedOil(LtcViewModel model) {
    return SmartRefresher(
        controller: model.refreshController,
        enablePullUp: true,
        onRefresh: model.refresh,
        onLoading: model.loadMore,
        child: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverPadding(
                  padding: EdgeInsets.only(left: 0.w, right: 0.w),
                  sliver: new SliverList(
                      delegate: SliverChildListDelegate(List.generate(
                          model.list.length,
                              (index) =>
                              LtcItemPage(item: model.list[index])))))
            ]));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController?.dispose();
    _recordScrollController?.dispose();
    super.dispose();
  }

}


//单例 运算力矿机
class LtcItemPage extends StatefulWidget{
  final item;
  const LtcItemPage({Key key, this.item}) : super(key: key);
  @override
  _LtcItemPageState createState() => _LtcItemPageState();
}

class _LtcItemPageState extends State<LtcItemPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32.w,right: 32.w),
      height: 298.h,
      width: 686.w,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Color.fromRGBO(244, 244, 244, 1),width: 1)
          ),
          color: Styles.colorWhite
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(//限量发售
            right: 0.w,
            top: 0,
            child: Container(
//              color: Color.fromRGBO(254, 167, 82, 1),
              width: 114.w,
              height: 32.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(4.0)
                  ),
                  color: Color.fromRGBO(254, 167, 82, 1)
              ),
              child: Text(
                '限量发售',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(//矿机图
            left: 0.w,
            top: 33.h,
            child: Container(
              width: 176.w,
              height: 176.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8)
                  ),
                  color: Styles.colorWhite

              ),
              child: CachedImage.network(
                  widget.item.hashicon,
                  fit: BoxFit.fill,
                  defaultImg: Image.network(
                    'https://lanhu.oss-cn-beijing.aliyuncs.com/pse05626996903b185-91fc-482d-863a-1e3a7dbf0b8b',
                    fit: BoxFit.cover,
                  )
              ),
            ),
          ),
          Positioned(//矿机名称
            left: 202.w,
            top: 44.h,
            child: CustomText(widget.item.hashname,fontSize: 32,),
          ),
          Positioned(
            left: 202.w,
            top: 98.h,
            child:
            Row(
              children: <Widget>[
                Container(
                  child:CustomText('挖矿币种',fontSize: 24,color: Color.fromRGBO(153, 153, 153, 1),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13.w),
                  width: 82.w,
                  child: CustomText(widget.item.cionType,fontSize: 24,color: Color.fromRGBO(52, 94, 147, 1),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 46.w),
                  child: CustomText('计算周期 ',fontSize: 24,color: Color.fromRGBO(153, 153, 153, 1),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13.w),
                  child: CustomText(widget.item.period,fontSize: 24,color: Color.fromRGBO(52, 94, 147, 1),),
                ),
              ],
            ),
          ),
          Positioned(
            left: 202.w,
            top: 140.h,
            child: Row(
              children: <Widget>[
                Container(
                  child: CustomText('合约期限',fontSize: 24,color: Color.fromRGBO(153, 153, 153, 1),),
                ),
                Container(
                  width: 82.w,
                  margin: EdgeInsets.only(left: 13.w),
                  child: CustomText(widget.item.hashday.toString()+'天',fontSize: 24,color: Color.fromRGBO(52, 94, 147, 1),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 46.w),
                  child: CustomText('技术服务费',fontSize: 24,color: Color.fromRGBO(153, 153, 153, 1),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13.w),
                  child: CustomText(widget.item.ratio,fontSize: 24,color: Color.fromRGBO(52, 94, 147, 1),),
                ),
              ],
            ),
          ),
          Positioned(
            left: 202.w,
            top: 182.h,
            child: Row(
              children: <Widget>[
                Container(
                  child: CustomText('购买数量',fontSize: 24,color: Color.fromRGBO(153, 153, 153, 1),),
                ),
                Container(
                  width: 82.w,
                  margin: EdgeInsets.only(left: 13.w),
                  child: CustomText(widget.item.inveshu,fontSize: 24,color: Color.fromRGBO(52, 94, 147, 1),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 46.w),
                  child: CustomText('消费金额',fontSize: 24,color: Color.fromRGBO(153, 153, 153, 1),),
                ),
                Container(
                  margin: EdgeInsets.only(left: 13.w),
                  child: CustomText(widget.item.expend+'U',fontSize: 24,color: Color.fromRGBO(52, 94, 147, 1),),
                ),
              ],
            ),
          ),
          Positioned(//购入时间
            left: 0.w,
            top: 234.h,
            child: CustomText(widget.item.createdAt+' 购入',fontSize: 24,color: Color.fromRGBO(52, 94, 147, 1),),
          ),
          Positioned(//底部粗的hr
            left: 0.w,
            top: 290.h,
            child: Container(
              width: 686.w,
              height: 8.h,
              color: Color.fromRGBO(244, 244, 244, 1),
            ),
          ),
        ],
      ),
    );
  }


}

