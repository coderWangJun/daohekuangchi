class CommunityListEntity {
  String name;
  String teamMill;

  CommunityListEntity({this.name, this.teamMill});

  CommunityListEntity.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    teamMill = json['team_mill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['team_mill'] = this.teamMill;
    return data;
  }
}