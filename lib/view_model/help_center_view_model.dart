import 'package:dh/common/mine_apis.dart';
import 'package:dh/entity/about_page_entity.dart';
import 'package:dh/entity/contact_page_entity.dart';
import 'package:dh/http/index.dart';
import 'package:dh/provider/view_state_model.dart';

class HelpCenterViewModel extends ViewStateModel {
  HelpCenterViewModel();

  AboutPageEntity aboutPageEntity = AboutPageEntity();
  ContactPageEntity contactPageEntity = ContactPageEntity();

  initAbout() async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.ABOUT,data: {
      "type": "1"
    });
    aboutPageEntity = new AboutPageEntity.fromJson(resultData.data);
    setIdle();
  }

  initUserLegal(String type) async {
    setBusy();
    ResultData resultData = await HttpClient.getInstance().post(MineApis.ABOUT,data: {
      "type": type
    });
    aboutPageEntity = new AboutPageEntity.fromJson(resultData.data);
    setIdle();
  }

//  initContact() async {
//    setBusy();
//    ResultData resultData = await HttpClient.getInstance().post(MineApis.CONTACT);
//    contactPageEntity = new ContactPageEntity.fromJson(resultData.data);
//    setIdle();
//  }

}