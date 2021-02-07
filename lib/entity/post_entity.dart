//公告
class PostEntity {
  //主键
  int id;

  //标题
  String title;

  //内容
  String content;

  //发布时间
  String time;

  String url;

  PostEntity({this.id,this.title,this.content,this.time,this.url});

  PostEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int ?? 0;
    title = json['title'] as String ?? "";
    content = json['content'] as String ?? "";
    url = json['url'] as String ?? "";
    time = json['senddate'] as String ?? "";
  }
}
