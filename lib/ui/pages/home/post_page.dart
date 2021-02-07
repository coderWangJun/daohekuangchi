import 'package:dh/entity/post_entity.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/routers/routers.dart';
import 'package:dh/ui/widgets/custom_app_bar.dart';
import 'package:dh/ui/widgets/custom_load_image.dart';
import 'package:dh/ui/widgets/custom_text.dart';
import 'package:dh/view_model/post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/utils/index.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => new _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<PostViewModel>(
        model: PostViewModel(type: 1),
        onModelReady: (model) {
          model.refresh();
        },
        builder: (context, model, child) {
          return Scaffold(
              appBar: CustomAppBar(
                centerTitle: "公告",
                color: Styles.colorFFFFFF,
                iconColor: Styles.colorFFFFFF,
                fontSize: 34.sp,
                backgroundColor: Styles.colorBackgroundColor,
              ),
              backgroundColor: Styles.colorWhite,
              body: Builder(builder: (_) {
                return Container(
                    padding: EdgeInsets.only(top: 20.h),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 1.h, color: Styles.color2B3347)),
                        color: Styles.colorBackgroundColor),
                    child: SmartRefresher(
                        controller: model.refreshController,
                        onRefresh: model.refresh,
                        onLoading: model.loadMore,
                        enablePullUp: true,
                        child: CustomScrollView(
                          //controller: model.scrollController,
                          slivers: <Widget>[
                            SliverPadding(
                              padding: EdgeInsets.only(left: 0.h, right: 0.h),
                              sliver: new SliverList(
                                delegate: SliverChildListDelegate(
                                  //返回组件集合
                                  List.generate(
                                      model.list.length,
                                      (index) => PostItemPage(
                                          item: model.list[index])),
                                ),
                              ),
                            ),
                          ],
                        )));
              }));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

//公告
class PostItemPage extends StatelessWidget {
  final PostEntity item;

  const PostItemPage({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: ScreenUtil().setHeight(120),
        decoration: BoxDecoration(
            color: Styles.colorBackgroundColor,
            border: Border(
              bottom: BorderSide(color: Styles.color2B3347, width: 1.h),
            )),
        margin: EdgeInsets.symmetric(horizontal: 33.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomText(
                  item.title,
                  fontSize: 30,
                  color: Styles.colorFFFFFF,
                ),
                CustomText(
                  item.time,
                  fontSize: 24,
                  color: Styles.colorFFFFFF,
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(right: 24.h),
                child: LoadAssetImage(
                  'home/more.png',
                  height: 40.h,
                  width: 40.h,
                  fit: BoxFit.contain,
                ))
          ],
        ),
      ),
      onTap: () {
        var url = Uri.encodeComponent(item.url);
        var title = Uri.encodeComponent('公告详情');
        NavigatorUtil.push(
            context, Routers.web + "?title=" + title + "&url=" + url);
      },
    );
  }
}
