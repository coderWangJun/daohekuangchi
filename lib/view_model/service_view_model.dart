import 'package:dh/common/constants.dart';
import 'package:dh/common/mine_apis.dart';
import 'package:dh/entity/contact_page_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';

class ServiceViewModel extends ViewStateModel {
  ServiceViewModel();

  ContactPageEntity contactPageEntity = ContactPageEntity.fromJson({});
  
  
  initData() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.CONTACT);

    contactPageEntity = new ContactPageEntity.fromJson(resultData.data);

    setIdle();

  }

}