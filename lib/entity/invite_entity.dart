class InviteEntity {
  String invitecode;
  String img;
  int referNum;
  String invest;
  String refercash;
  String totalcash;

  InviteEntity(
      {this.invitecode,
        this.img,
        this.referNum,
        this.invest,
        this.refercash,
        this.totalcash});

  InviteEntity.fromJson(Map<String, dynamic> json) {
    invitecode = json['invitecode'] ?? "";
    img = json['img'] ?? "";
    referNum = json['referNum'] ?? 0;
    invest = json['invest'] ?? "";
    refercash = json['refercash'] ?? "";
    totalcash = json['totalcash'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invitecode'] = this.invitecode;
    data['img'] = this.img;
    data['referNum'] = this.referNum;
    data['invest'] = this.invest;
    data['refercash'] = this.refercash;
    data['totalcash'] = this.totalcash;
    return data;
  }
}
