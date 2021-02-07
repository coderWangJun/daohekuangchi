class ShopEntity {
  Wallet wallet;
  Protocol protocol;
  SliList sliList;

  ShopEntity({this.wallet, this.protocol, this.sliList});

  ShopEntity.fromJson(Map<String, dynamic> json) {
    wallet =
    json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : Wallet.fromJson({});
    protocol = json['protocol'] != null
        ? new Protocol.fromJson(json['protocol'])
        : Protocol.fromJson({});
    sliList =
    json['list'] != null ? new SliList.fromJson(json['list']) : SliList.fromJson({});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wallet != null) {
      data['wallet'] = this.wallet.toJson();
    }
    if (this.protocol != null) {
      data['protocol'] = this.protocol.toJson();
    }
    if (this.sliList != null) {
      data['list'] = this.sliList.toJson();
    }
    return data;
  }
}

class Wallet {
  String fIL;
  String uSDT;
  String mill;
  String hash;

  Wallet({this.fIL, this.uSDT, this.mill, this.hash});

  Wallet.fromJson(Map<String, dynamic> json) {
    fIL = json['FIL'] ?? "";
    uSDT = json['USDT'] ?? "";
    mill = json['mill'] ?? "";
    hash = json['hash'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FIL'] = this.fIL;
    data['USDT'] = this.uSDT;
    data['mill'] = this.mill;
    data['hash'] = this.hash;
    return data;
  }
}

class Protocol {
  String title;
  String content;

  Protocol({this.title, this.content});

  Protocol.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    content = json['content'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class SliList {
  String total;
  List<Data> data = [];

  SliList({this.total, this.data});

  SliList.fromJson(Map<String, dynamic> json) {
    total = json['total'] ?? "";
    data = new List<Data>();
    if (json['data'] != null) {

      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String hashicon;
  String hashname;
  String cionType;
  String hashday;
  String hashcash;
  String hashnum;
  String period;
  String shownum;
  String ratio;
  String title;
  String trustcsah;
  int realNum;

  Data(
      {this.id,
        this.hashicon,
        this.hashname,
        this.cionType,
        this.hashday,
        this.hashcash,
        this.hashnum,
        this.period,
        this.shownum,
        this.ratio,
        this.title,
        this.trustcsah,this.realNum});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    hashicon = json['hashicon'] ?? "";
    hashname = json['hashname'] ?? "";
    cionType = json['cionType'] ?? "";
    hashday = json['hashday'] ?? "";
    hashcash = json['hashcash'] ?? "";
    hashnum = json['hashnum'] ?? "";
    period = json['period'] ?? "";
    shownum = json['shownum'] ?? "";
    ratio = json['ratio'] ?? "";
    title = json['title'] ?? "";
    trustcsah = json['trustcsah'] ?? "";
    realNum = int.parse(json['shownum']) ?? 0;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hashicon'] = this.hashicon;
    data['hashname'] = this.hashname;
    data['cionType'] = this.cionType;
    data['hashday'] = this.hashday;
    data['hashcash'] = this.hashcash;
    data['hashnum'] = this.hashnum;
    data['period'] = this.period;
    data['shownum'] = this.shownum;
    data['ratio'] = this.ratio;
    data['title'] = this.title;
    data['trustcsah'] = this.trustcsah;
    return data;
  }
}
