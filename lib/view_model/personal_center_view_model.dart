import 'package:dh/common/apis.dart';
import 'package:dh/common/constants.dart';
import 'package:dh/common/mine_apis.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';
import 'package:dh/utils/platform_util.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class PersonalCenterViewModel extends ViewStateModel {
  PersonalCenterViewModel();

  String uid = "";
  String head = "";
  String phone = "";

  initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.MINE);
    uid = resultData.data["userid"].toString();
    head = resultData.data["icon"];
    phone = resultData.data["phone"];
    setIdle();
  }

  Future<ResultData> uploadAvatar(File imageFIle) async {
    setBusy();
    String icon = "";
    String path = imageFIle.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var picture = await MultipartFile.fromFile(path,
        filename: name, contentType: MediaType('image', 'jpeg'));
    ResultData resultData = await HttpClient.getInstance()
        .upload(Apis.UPLOAD_IMG, data: {'file': picture});
    if (resultData.code == Constants.successCode) {
      icon = resultData.data['src'];
      resultData = await HttpClient.getInstance().post(MineApis.AVATAR, data: {
        'icon': icon,
      });
    }

    setIdle();
    return resultData;
  }



}