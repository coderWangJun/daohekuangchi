class TransferItemEntity {
  String type;
  String note;
  String amount;
  String confirm;
  String createdAt;

  String status;
  String phone;
  TransferItemEntity(
      {this.type, this.note, this.amount, this.confirm, this.createdAt});

  TransferItemEntity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    note = json['note'];
    amount = json['amount'];
    confirm = json['confirm'];
    createdAt = json['created_at'];
    status = json["status"]??"转账成功";
    phone = json["othername"]??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['note'] = this.note;
    data['amount'] = this.amount;
    data['confirm'] = this.confirm;
    data['created_at'] = this.createdAt;
    return data;
  }
}
