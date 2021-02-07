import 'package:dh/common/apis.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/entity/post_detail_entity.dart';
import 'package:dh/entity/post_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_refresh_list_model.dart';

class PostViewModel extends ViewStateRefreshListModel {
  // 1 公告 2常见问题 3新手指南
  final int type;
  int _index = 0;

  int get index => _index;

  PostViewModel({this.type = 1});

  //公告类型
  List<PostEntity> _postList = new List();

  List<PostEntity> get postList => _postList;

  @override
  Future<List> loadData({int pageNum}) async {
    setBusy();

    ResultData resultData = new ResultData(Constants.successCode, "请求成功", null);
    try {
      var page = 1;
      if (pageNum != null && pageNum != 0) page = pageNum;

      resultData = await HttpClient.getInstance()
          .post(Apis.POST_HOME, data: {"page": page, 'type': type});
      if (resultData.code == Constants.successCode) {
        _postList.clear();
        (resultData.data["data"] as List).forEach((element) {
          _postList.add(PostEntity.fromJson(element));
        });
      }

      setIdle();
      return _postList;
    } catch (e) {
      resultData.code = Constants.successCode;
      setIdle();
    }
    return _postList;
  }

  PostDetailEntity detailEntity = PostDetailEntity.fromJson({});

  //获取公告详情
  getPostDetail(String id) async {
    setBusy();
//    ResultData resultData =
//    await HttpClient.getInstance().post(GApis.AGREEMENTDETAIL,
//        data: {'r_id':id});
//    detailEntity = PostDetailEntity.fromJson(resultData.data ?? {});
    setIdle();
  }
}
