class AuthEntity {
  String name;
  String idcard;
  String note;

  AuthEntity({this.name = "", this.idcard = "", this.note = ""});

  AuthEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    idcard = json['idcard'] ?? "";
    note = json['note'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['idcard'] = this.idcard;
    data['note'] = this.note;
    return data;
  }
}