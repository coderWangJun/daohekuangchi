class ProductsEntity {
  String id;
  String hashname;
  String inveshu;
  String expend;
  String createdAt;
  int hashnum;
  String ordersn;

  ProductsEntity(
      {this.id,
        this.hashname,
        this.inveshu,
        this.expend,
        this.createdAt,
        this.hashnum,
        this.ordersn});

  ProductsEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    hashname = json['hashname'] ?? "";
    inveshu = json['inveshu'] ?? "";
    expend = json['expend'] ?? "";
    createdAt = json['created_at'] ?? "";
    hashnum = json['hashnum'] ?? 0;
    ordersn = json["ordersn"] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hashname'] = this.hashname;
    data['inveshu'] = this.inveshu;
    data['expend'] = this.expend;
    data['created_at'] = this.createdAt;
    data['hashnum'] = this.hashnum;
    data["ordersn"] = this.ordersn;
    return data;
  }
}