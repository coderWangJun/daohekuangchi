class FlowItemEntity {
  String note;
  String payType;
  String source;
  String reformWa;
  String createdAt;

  FlowItemEntity(
      {this.note, this.payType, this.source, this.reformWa, this.createdAt});

  FlowItemEntity.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    payType = json['pay_type'];
    source = json['source'];
    reformWa = json['reform_wa'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['pay_type'] = this.payType;
    data['source'] = this.source;
    data['reform_wa'] = this.reformWa;
    data['created_at'] = this.createdAt;
    return data;
  }
}
