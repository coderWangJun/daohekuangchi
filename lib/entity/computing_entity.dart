class ComputingEntity {
  Upperhalf upperhalf;
  Lowerhalf lowerhalf;

  ComputingEntity({this.upperhalf, this.lowerhalf});

  ComputingEntity.fromJson(Map<String, dynamic> json) {
    upperhalf = json['Upperhalf'] != null
        ? new Upperhalf.fromJson(json['Upperhalf'])
        : new Upperhalf.fromJson({});
    lowerhalf = json['Lowerhalf'] != null
        ? new Lowerhalf.fromJson(json['Lowerhalf'])
        : Lowerhalf.fromJson({});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.upperhalf != null) {
      data['Upperhalf'] = this.upperhalf.toJson();
    }
    if (this.lowerhalf != null) {
      data['Lowerhalf'] = this.lowerhalf.toJson();
    }
    return data;
  }
}

class Upperhalf {
  String levelname;
  String revenue;
  String hash;
  String team;
  String club;
  String total;

  Upperhalf(
      {this.levelname,
        this.revenue,
        this.hash,
        this.team,
        this.club,
        this.total});

  Upperhalf.fromJson(Map<String, dynamic> json) {
    levelname = json['levelname']??"";
    revenue = json['revenue']??"";
    hash = json['hash']??"";
    team = json['team']??"";
    club = json['club']??"";
    total = json['total']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['levelname'] = this.levelname;
    data['revenue'] = this.revenue;
    data['hash'] = this.hash;
    data['team'] = this.team;
    data['club'] = this.club;
    data['total'] = this.total;
    return data;
  }
}

class Lowerhalf {
  String myester;
  String myTotal;
  String millteam;
  String millincome;
  String millareaDays;
  String millareaIncome;

  Lowerhalf(
      {this.myester,
        this.myTotal,
        this.millteam,
        this.millincome,
        this.millareaDays,
        this.millareaIncome});

  Lowerhalf.fromJson(Map<String, dynamic> json) {
    myester = json['Myester']??"";
    myTotal = json['MyTotal']??"";
    millteam = json['millteam']??"";
    millincome = json['millincome']??"";
    millareaDays = json['millarea_days']??"";
    millareaIncome = json['millarea_income']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Myester'] = this.myester;
    data['MyTotal'] = this.myTotal;
    data['millteam'] = this.millteam;
    data['millincome'] = this.millincome;
    data['millarea_days'] = this.millareaDays;
    data['millarea_income'] = this.millareaIncome;
    return data;
  }
}