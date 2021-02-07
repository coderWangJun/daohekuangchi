class NoticeListEntity {
  int id;
  String title;
  String senddate;
  String url;

  NoticeListEntity({this.id, this.title, this.senddate, this.url});

  NoticeListEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    senddate = json['senddate'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['senddate'] = this.senddate;
    data['url'] = this.url;
    return data;
  }
}