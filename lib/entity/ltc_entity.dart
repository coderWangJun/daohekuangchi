class LtcEntity {
  String cash;
  ComputingList computingList;

  LtcEntity({this.cash, this.computingList});

  LtcEntity.fromJson(Map<String, dynamic> json) {
    cash = json['cash'] ?? "0";
    computingList = json['list'] != null
        ? new ComputingList.fromJson(json['list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cash'] = this.cash;
    if (this.computingList != null) {
      data['list'] = this.computingList.toJson();
    }
    return data;
  }
}

class ComputingList {
  String total;
  List<Data> data=[];

  ComputingList({this.total, this.data});

  ComputingList.fromJson(Map<String, dynamic> json) {
    total = json['total'] ?? "";
    if (json['data'] != null) {
      data = new List<Data>();
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
  String period;
  int hashday;
  String inveshu;
  String expend;
  String ratio;
  String createdAt;
  String trustcsah;

  Data(
      {this.id,
        this.hashicon,
        this.hashname,
        this.cionType,
        this.period,
        this.hashday,
        this.inveshu,
        this.expend,
        this.ratio,
        this.createdAt,
        this.trustcsah});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    hashicon = json['hashicon'] ?? "";
    hashname = json['hashname'] ?? "";
    cionType = json['cionType'] ?? "";
    period = json['period'] ?? "";
    hashday = json['hashday'] ?? "";
    inveshu = json['inveshu'] ?? "";
    expend = json['expend'] ?? "";
    ratio = json['ratio'] ?? "";
    createdAt = json['created_at'] ?? "";
    trustcsah = json['trustcsah'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hashicon'] = this.hashicon;
    data['hashname'] = this.hashname;
    data['cionType'] = this.cionType;
    data['period'] = this.period;
    data['hashday'] = this.hashday;
    data['inveshu'] = this.inveshu;
    data['expend'] = this.expend;
    data['ratio'] = this.ratio;
    data['created_at'] = this.createdAt;
    data['trustcsah'] = this.trustcsah;
    return data;
  }
}
