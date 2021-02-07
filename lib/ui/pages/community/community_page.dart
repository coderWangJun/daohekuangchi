import 'package:dh/entity/community_list_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/view_model/community_view_model.dart';
import 'package:flutter/material.dart';
import 'package:dh/utils/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      appBar: CustomAppBar(
        isBack: false,
        centerTitle: "我的社区",
        backgroundColor: Colors.white,
      ),
      body: ProviderWidget<CommunityViewModel>(
        model: CommunityViewModel(),
        onModelReady: (model) {
          model.refresh();
        },
        builder: (ctx,model,child) {
          return Column(
            children: <Widget>[
              Container(
                width: 692.w,
                height: 327.h,
                padding: EdgeInsets.only(left: 3.w,right: 4.w,top: 20.h,bottom: 26.h),
                margin: EdgeInsets.symmetric(horizontal: 29.w),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            "assets/images/community/img_bg_blue.png"
                        ),
                        fit: BoxFit.cover
                    )
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 140.h,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        width: 1.w,
                                        color: Color(0xfff4f4f4)
                                    ),
                                    bottom: BorderSide(
                                        width: 1.w,
                                        color: Color(0xfff4f4f4)
                                    )
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(model.myCompu,style: TextStyle(fontSize: 40.sp,color: Colors.white)),
                                Text("我的算力（T）",style: TextStyle(fontSize: 26.sp,color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 140.h,
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        width: 1.w,
                                        color: Color(0xfff4f4f4)
                                    ),
                                    bottom: BorderSide(
                                        width: 1.w,
                                        color: Color(0xfff4f4f4)
                                    )
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(model.myTeamCompu,style: TextStyle(fontSize: 40.sp,color: Colors.white)),
                                Text("团队总算力（T）",style: TextStyle(fontSize: 26.sp,color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 140.h,
                            decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      width: 1.w,
                                      color: Color(0xfff4f4f4)
                                  ),
                                  top: BorderSide(
                                      width: 1.w,
                                      color: Color(0xfff4f4f4)
                                  ),
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(model.myrecom,style: TextStyle(fontSize: 40.sp,color: Colors.white)),
                                Text("直推人数",style: TextStyle(fontSize: 26.sp,color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 140.h,
                            decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      width: 1.w,
                                      color: Color(0xfff4f4f4)
                                  ),
                                  top: BorderSide(
                                      width: 1.w,
                                      color: Color(0xfff4f4f4)
                                  ),
                                )
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(model.myteam,style: TextStyle(fontSize: 40.sp,color: Colors.white)),
                                Text("团队人数",style: TextStyle(fontSize: 26.sp,color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 750.w,
                padding: EdgeInsets.symmetric(horizontal: 32.w,vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("我的直推",style: TextStyle(fontSize: 28.sp,color: Color(0xff999999))),
                    Text("总业绩",style: TextStyle(fontSize: 28.sp,color: Color(0xff999999)))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: SmartRefresher(
                      controller: model.refreshController,
                      onRefresh: model.refresh,
                      onLoading: model.loadMore,
                      enablePullUp: true,
                      child:ListView.builder(
                          itemCount: model.list.length,
                          itemBuilder: (context, index) {
                            CommunityListEntity item = model.list[index];
                            return RecordsListItem(
                              item: item,
                            );
                          })
                  )
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class RecordsListItem extends StatelessWidget {
  final CommunityListEntity item;

  const RecordsListItem({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 750.w,
      height: 111.h,
      padding: EdgeInsets.symmetric(horizontal: 32.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 1.w,
          color: Color.fromRGBO(255,255,255,1)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(item.name,style: TextStyle(fontSize: 28.sp)),
          Text(item.teamMill,style: TextStyle(fontSize: 28.sp))
        ],
      ),
    );
  }
}


