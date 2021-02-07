class RechargeItemEntity {
  String type;
  String note;
  String status;
  String address;
  String amount;
  String confirm;
  String createdAt;

  RechargeItemEntity(
      {this.type,
        this.note,
        this.status,
        this.address,
        this.amount,
        this.confirm,
        this.createdAt});

  RechargeItemEntity.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    note = json['note'];
    status = json['status'];
    address = json['address'];
    amount = json['amount'];
    confirm = json['confirm'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['note'] = this.note;
    data['status'] = this.status;
    data['address'] = this.address;
    data['amount'] = this.amount;
    data['confirm'] = this.confirm;
    data['created_at'] = this.createdAt;
    return data;
  }
}
