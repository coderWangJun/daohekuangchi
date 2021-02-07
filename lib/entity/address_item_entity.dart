class AddressItemEntity{
  String id;
  String name;
  String address;
  bool checked;
  AddressItemEntity(this.id,this.name,this.address,this.checked);

  AddressItemEntity.fromJson(Map<String, dynamic> json) {
    id=json["id"];
    name = json['title'];
    address = json['wallet_token'];
    checked = false;
  }

}