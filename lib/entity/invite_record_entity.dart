class InviteRecordEntity {
  String total;
  List<Data> data = [];

  InviteRecordEntity({this.total, this.data});

  InviteRecordEntity.fromJson(Map<String, dynamic> json) {
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
  String note;
  String reformWa;
  String createdAt;

  Data({this.note, this.reformWa, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    note = json['note'] ?? "";
    reformWa = json['reform_wa'] ?? "";
    createdAt = json['created_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['reform_wa'] = this.reformWa;
    data['created_at'] = this.createdAt;
    return data;
  }
}
