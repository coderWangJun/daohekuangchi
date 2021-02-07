class PostDetailEntity {
  int id;
  String title;
  String content;
  String time;

  PostDetailEntity({this.id, this.title, this.content, this.time});

  PostDetailEntity.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    title = json['title']??"";
    content = json['content']??"";
    time = json['time']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['time'] = this.time;
    return data;
  }
}
