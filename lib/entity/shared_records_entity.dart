class SharedRecordsEntity {
  String note;
  String reformWa;
  String createdAt;
  String username;

  SharedRecordsEntity({this.note, this.reformWa, this.createdAt,this.username});

  SharedRecordsEntity.fromJson(Map<String, dynamic> json) {
    note = json['note'] ?? "";
    reformWa = json['reform_wa'] ?? "";
    createdAt = json['created_at'] ?? "";
    username = json["username"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['reform_wa'] = this.reformWa;
    data['created_at'] = this.createdAt;
    data["username"] = this.username;
    return data;
  }
}