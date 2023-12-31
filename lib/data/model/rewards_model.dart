class Autogenerated {
  bool? success;
  RewardsModel? data;
  String? message;

  Autogenerated({this.success, this.data, this.message});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new RewardsModel.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class RewardsModel {
  int? total;
  int? today;
  int? completed;
  int? incomplete;
  int? totalTask;
  int? totalUser;
  List<Datalist>? datalist;

  RewardsModel(
      {this.total,
        this.today,
        this.completed,
        this.incomplete,
        this.totalTask,
        this.totalUser,
        this.datalist});

  RewardsModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    today = json['today'];
    completed = json['completed'];
    incomplete = json['incomplete'];
    totalTask = json['total_task'];
    totalUser = json['total_user'];
    if (json['datalist'] != null) {
      datalist = <Datalist>[];
      json['datalist'].forEach((v) {
        datalist!.add(new Datalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['today'] = this.today;
    data['completed'] = this.completed;
    data['incomplete'] = this.incomplete;
    data['total_task'] = this.totalTask;
    data['total_user'] = this.totalUser;
    if (this.datalist != null) {
      data['datalist'] = this.datalist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  int? userCount;
  int? amount;
  int? level;
  int? payoutPerTask;

  Datalist({this.userCount, this.amount, this.level, this.payoutPerTask});

  Datalist.fromJson(Map<String, dynamic> json) {
    userCount = json['user_count'];
    amount = json['amount'];
    level = json['level'];
    payoutPerTask = json['payout_per_task'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_count'] = this.userCount;
    data['amount'] = this.amount;
    data['level'] = this.level;
    data['payout_per_task'] = this.payoutPerTask;
    return data;
  }
}
