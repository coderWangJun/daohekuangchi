import 'package:dh/common/gapis.dart';
import 'package:dh/entity/home_entity.dart';
import 'package:dh/http/http_client.dart';
import 'package:dh/http/result_data.dart';
import 'package:dh/utils/logger_util.dart';

import '../provider/view_state_refresh_list_model.dart';

class HomeViewModel extends ViewStateRefreshListModel {
  int _index = 0;
  int get index => _index;

  HomeViewModel();

  setIndex(int index) {
    _index = index;
    notifyListeners();
  }

  HomeEntity homeEntity = HomeEntity.fromJson({});

  List<String> _bannerItems = [];

  List<String> get bannerItems => _bannerItems;

  List<String> _hotSearchTag = [];

  List<String> get hotSearchTag => _hotSearchTag;

  List<Above> _above = [];

  List<Above> get above => _above;

  List<LtcList> _ltcLists = [];

  List<LtcList> get ltcLists => _ltcLists;

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();
    _bannerItems.clear();
    _hotSearchTag.clear();
    _ltcLists.clear();
    _above.clear();
    ResultData resultData = await HttpClient.getInstance().post(GApis.HOMEINDEX);
    homeEntity = HomeEntity.fromJson(resultData.data);

    homeEntity.imageLoop.forEach((element) {
      _bannerItems.add(element.img);
    });

    homeEntity.nocitetitle.forEach((element) {
      _hotSearchTag.add(element.title);
    });

    for(var i=0;i<homeEntity.above.length;i++){
      _above.add(homeEntity.above[i]);

    }


    for(var i=0;i<homeEntity.ltcList.length;i++){
      _ltcLists.add(homeEntity.ltcList[i]);
    }




    setIdle();
//    return homeEntity.ltcList.data;
//      return null;
  }

//  Future<ResultData> goPayment(String id,String inveshu,String hashcash,int payType,bool isSelect) async {
//    setBusy();
//
//    ResultData resultData = await HttpClient.getInstance().post(GApis.SHOPPING,data: {
//      "id":id,
//      "inveshu":inveshu,
//      "hashcash":hashcash,
//      "payType":payType,//1为首页进入，2运算力，3矿机
//    });
//
//    setIdle();
//    return resultData;
//
//  }
}
