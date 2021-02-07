import 'package:dh/entity/shop_entity.dart';

class HomeEntity {
  List<ImageLoop> imageLoop=[];
  List<Nocitetitle> nocitetitle=[];
  Wallet wallet;
  List<Above> above=[];
  List<LtcList> ltcList=[];


  HomeEntity({this.imageLoop, this.nocitetitle, this.wallet,this.above, this.ltcList});

  HomeEntity.fromJson(Map<String, dynamic> json) {
    if (json['imageLoop'] != null) {
      imageLoop = new List<ImageLoop>();
      json['imageLoop'].forEach((v) {
        imageLoop.add(new ImageLoop.fromJson(v));
      });
    }
    if (json['nocitetitle'] != null) {
      nocitetitle = new List<Nocitetitle>();
      json['nocitetitle'].forEach((v) {
        nocitetitle.add(new Nocitetitle.fromJson(v));
      });
    }
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    if (json['above'] != null) {
      above = new List<Above>();
      json['above'].forEach((v) {
        above.add(new Above.fromJson(v));
      });
    }
    if (json['list'] != null) {
      ltcList = new List<LtcList>();
      json['list'].forEach((v) {
        ltcList.add(new LtcList.fromJson(v));
      });
    }

  }


}



class ImageLoop {
  String img;
  String url;

  ImageLoop({this.img, this.url});

  ImageLoop.fromJson(Map<String, dynamic> json) {
    img = json['Img'] ?? "";
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Img'] = this.img;
    data['url'] = this.url;
    return data;
  }
}

class Nocitetitle {
  String title;
  String url;

  Nocitetitle({this.title, this.url});

  Nocitetitle.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}

class Wallet {
  String fIL;
  String uSDT;
  String walletToken;

  Wallet({this.fIL, this.uSDT, this.walletToken});

  Wallet.fromJson(Map<String, dynamic> json) {
    fIL = json['FIL'] ?? "";
    uSDT = json['USDT'] ?? "";
    walletToken = json['wallet_token'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FIL'] = this.fIL;
    data['USDT'] = this.uSDT;
    data['wallet_token'] = this.walletToken;
    return data;
  }
}

class Above {
  String name;
  String ratiochange;
  String price;
  String tradeshu;
  String rMB;

  Above({this.name, this.ratiochange, this.price, this.tradeshu, this.rMB});

  Above.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    ratiochange = json['ratiochange'] ?? "";
    price = json['price'] ?? "";
    tradeshu = json['tradeshu'] ?? "";
    rMB = json['RMB'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ratiochange'] = this.ratiochange;
    data['price'] = this.price;
    data['tradeshu'] = this.tradeshu;
    data['RMB'] = this.rMB;
    return data;
  }
}

class LtcList {
  String name;
  String ratiochange;
  String price;
  String tradeshu;
  String rMB;

  LtcList({this.name, this.ratiochange, this.price, this.tradeshu, this.rMB});

  LtcList.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    ratiochange = json['ratiochange'] ?? "";
    price = json['price'] ?? "";
    tradeshu = json['tradeshu'] ?? "";
    rMB = json['RMB'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['ratiochange'] = this.ratiochange;
    data['price'] = this.price;
    data['tradeshu'] = this.tradeshu;
    data['RMB'] = this.rMB;
    return data;
  }
}

