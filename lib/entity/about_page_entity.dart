class AboutPageEntity {
  String title;
  String content;
  String senddate;

  AboutPageEntity({this.title, this.content, this.senddate});

  AboutPageEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    senddate = json['senddate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['senddate'] = this.senddate;
    return data;
  }
}