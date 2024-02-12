
class ValidityModel {
  String? isActive;
  String? endDate;
  String? validFor;

  ValidityModel({this.isActive, this.endDate, this.validFor});

  ValidityModel.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    endDate = json['end_date'];
    validFor = json['valid_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_active'] = this.isActive;
    data['end_date'] = this.endDate;
    data['valid_for'] = this.validFor;
    return data;
  }
}

class TaskProDashValidityModel {
  String? isActive;
  String? endDate;
  String? validFor;

  TaskProDashValidityModel({this.isActive, this.endDate, this.validFor});

  TaskProDashValidityModel.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    endDate = json['end_date'];
    validFor = json['valid_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_active'] = this.isActive;
    data['end_date'] = this.endDate;
    data['valid_for'] = this.validFor;
    return data;
  }
}


class TaskProValidityHistory {
  List<ActiveValidity>? activeValidity;
  List<ActiveValidity>? expiredValidity;

  TaskProValidityHistory({this.activeValidity, this.expiredValidity});

  TaskProValidityHistory.fromJson(Map<String, dynamic> json) {
    if (json['active_validity'] != null) {
      activeValidity = <ActiveValidity>[];
      json['active_validity'].forEach((v) {
        activeValidity!.add(new ActiveValidity.fromJson(v));
      });
    }
    if (json['expired_validity'] != null) {
      expiredValidity = <ActiveValidity>[];
      json['expired_validity'].forEach((v) {
        expiredValidity!.add(new ActiveValidity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activeValidity != null) {
      data['active_validity'] =
          this.activeValidity!.map((v) => v.toJson()).toList();
    }
    if (this.expiredValidity != null) {
      data['expired_validity'] =
          this.expiredValidity!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ActiveValidity {
  String? isActive;
  String? startDate;
  String? endDate;
  String? reason;

  ActiveValidity({this.isActive, this.startDate, this.endDate, this.reason});

  ActiveValidity.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_active'] = this.isActive;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['reason'] = this.reason;
    return data;
  }
}
