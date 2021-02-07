class NoticeDetailsEntity {
  String title;
  String senddate;
  String content;

  NoticeDetailsEntity({this.title, this.senddate, this.content});

  NoticeDetailsEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    senddate = json['senddate'] ?? "";
    content = json['content'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['senddate'] = this.senddate;
    data['content'] = this.content;
    return data;
  }
}