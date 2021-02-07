import 'package:dh/common/constants.dart';
import 'package:dh/entity/address_item_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/provider_widget.dart';
import 'package:dh/res/styles.dart';
import 'package:dh/routers/fluro_navigator.dart';
import 'package:dh/ui/widgets/alert.dart';
import 'package:dh/ui/widgets/custom_button.dart';
import 'package:dh/ui/widgets/custom_load_image.dart';
import 'package:dh/view_model/addr_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dh/utils/index.dart';

class AddressListPage extends StatefulWidget {
  //(0:USDT地址,1:Fil地址,)
  final int addrType;

  final AddrViewModel viewModel;

  const AddressListPage({Key key, this.addrType: 0, this.viewModel})
      : super(key: key);

  @override
  _TradeListPageState createState() => _TradeListPageState();
}

class _TradeListPageState extends State<AddressListPage> {
  String title = "USDT";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.addrType == 0 ? "USDT" : "Fil";
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<AddrViewModel>(
      model: widget.viewModel,
      onModelReady: (model) async {
        await Future.delayed(Duration(milliseconds: 100));
        if (mounted) {
          model.refresh();
        }
      },
      builder: (context, model, child) {
        return new Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                  color: Styles.colorBackgroundColor,
                  child: SmartRefresher(
                    controller: model.refreshController,
                    onRefresh: model.refresh,
                    onLoading: model.loadMore,
                    enablePullUp: true,
                    child: ListView.builder(
                        itemCount: model.list.length,
                        itemBuilder: (context, index) {
                          AddressItemEntity item = model.list[index];
                          return AddressItemPage(
                            item: item,
                            index: index,
                            recordType: widget.addrType,
                            viewModel: model,
                          );
                        }),
                  )),
              Positioned(
                  bottom: 68.h,
                  left: 32.w,
                  child: CustomButton(
                    "确定",
                    width: 686.w,
                    height: 98.h,
                    radius: 49.w,
                    fontSize: 32.ssp,
                    busy: model.busy,
                    onPressed: () async {
                      AddressItemEntity address = model.list.length == 0
                          ? AddressItemEntity.fromJson({})
                          : model.list[model.index];
                      NavigatorUtil.popResult(context, address);

//                      NavigatorUtil.pushResult(
//                          context,
//                          RichRouter.addAddress +
//                              "?type=" +
//                              widget.addrType.toString(),
//                          (res) => {model.refresh()});
                    },
                  ))
            ],
          ),
        );
      },
    );
  }
}

class AddressItemPage extends StatefulWidget {
  final int recordType;
  final AddressItemEntity item;
  final int index;
  final AddrViewModel viewModel;

  const AddressItemPage(
      {Key key, this.recordType, this.item, this.index, this.viewModel})
      : super(key: key);

  @override
  _AddressItemPageState createState() => _AddressItemPageState();
}

//地址列表
class _AddressItemPageState extends State<AddressItemPage> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    AddrViewModel model = Provider.of<AddrViewModel>(context);
    // TODO: implement build
    return InkWell(
      onTap: () {
        model.setSelected(widget.index);
        //NavigatorUtil.popResult(context, widget.item);
        setState(() {});
      },
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
          color: Styles.color1E2538,
          border:
              Border(bottom: BorderSide(color: Styles.color2B3448, width: 1.h)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              padding: EdgeInsets.only(left: 35.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          model.setSelected(widget.index);
//                        NavigatorUtil.popResult(context, widget.item);
                          setState(() {});
                        },
                        child: LoadAssetImage(
                          widget.item.checked
                              ? 'rich/using.png'
                              : 'rich/unuse.png',
                          width: 28.w,
                          height: 28.h,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.w),
                        child: Text(widget.item.name,
                            style: Styles.theme(
                                color: Styles.colorB1C6EA,
                                fontSize: 28.ssp,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 32.w),
                    child: InkWell(
                      onTap: () async {
                        Alert.show(context,
                            content: "确定删除该地址吗？",
                            isCancel: true, onOk: () async {
                          ResultData res =
                              await widget.viewModel.delAddress(widget.item.id);
                          if (res.code == Constants.successCode) {
                            widget.viewModel.refresh();
                          }
                        });
                      },
                      child: LoadAssetImage(
                        'common/exit.png',
                        width: 28.w,
                        height: 28.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(right: 40.w, left: 45.w),
              child: Text(widget.item.address,
                  style: Styles.theme(
                      fontWeight: FontWeight.w500,
                      color: Styles.colorWhite,
                      fontSize: 28.ssp)),
            )
          ],
        ),
      ),
    );
  }
}
