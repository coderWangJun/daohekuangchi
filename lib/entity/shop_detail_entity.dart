class ShopDetailEntity {
  int id;
  String hashicon;
  String hashname;
  String cionType;
  String hashday;
  String hashcash;
  int hashnum;
  String period;
  int shownum;
  String ratio;
  String articleid;
  String artitle;
  String content;
  int realNum;
  String trustcsah;
  String wallet;
  String phone;

  ShopDetailEntity(
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
        this.articleid,
        this.artitle,
        this.content,this.realNum,this.trustcsah,this.wallet,this.phone});

  ShopDetailEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    hashicon = json['hashicon'] ?? "";
    hashname = json['hashname'] ?? "";
    cionType = json['cionType'] ?? "";
    hashday = json['hashday'] ?? "";
    hashcash = json['hashcash'] ?? "";
    hashnum = json['hashnum'] ?? 0;
    period = json['period'] ?? "";
    shownum = json['shownum'] ?? 0;
    ratio = json['ratio'] ?? "";
    articleid = json['articleid'] ?? "";
    artitle = json['artitle'] ?? "";
    content = json['content'] ?? "";
    realNum = json['shownum'] ?? 0;
    trustcsah = json['trustcsah'] ?? "";
    wallet = json['wallet'] ?? "";
    phone = json['phone'] ?? "";
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
    data['articleid'] = this.articleid;
    data['artitle'] = this.artitle;
    data['content'] = this.content;
    data['trustcsah'] = this.trustcsah;
    data['wallet'] = this.wallet;
    data['phone'] = this.phone;
    return data;
  }
}
