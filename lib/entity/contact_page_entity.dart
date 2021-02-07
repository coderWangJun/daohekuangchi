class ContactPageEntity {
  String email;
  String phone;
  String wechat;
  String qq;
  String wxcode;
  String lubcode;

  ContactPageEntity(
      {this.email = "",
        this.phone = "",
        this.wechat = "",
        this.qq = "",
        this.wxcode = "",
        this.lubcode = ""});

  ContactPageEntity.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? "";
    phone = json['phone'] ?? "";
    wechat = json['wechat'] ?? "";
    qq = json['qq'] ?? "";
    wxcode = json['wxcode'] ?? "";
    lubcode = json['lubcode'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['wechat'] = this.wechat;
    data['qq'] = this.qq;
    data['wxcode'] = this.wxcode;
    data['lubcode'] = this.lubcode;
    return data;
  }
}