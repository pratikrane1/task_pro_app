class Autogenerated {
  bool? success;
  ProfileModel? data;
  String? message;

  Autogenerated({this.success, this.data, this.message});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new ProfileModel.fromJson(json['data']) : null;
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

class ProfileModel {
  int? id;
  int? gainzProUserId;
  String? name;
  String? mobileNo;
  String? email;
  Null? emailVerifiedAt;
  String? recordPath;
  String? role;
  String? date;
  String? referBy;
  String? referName;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;
  Null? termCondition;
  Null? policy;

  ProfileModel(
      {this.id,
        this.name,
        this.gainzProUserId,
        this.mobileNo,
        this.email,
        this.emailVerifiedAt,
        this.recordPath,
        this.role,
        this.date,
        this.referBy,
        this.referName,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.termCondition,
        this.policy});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gainzProUserId = json['gainpro_user_id'];
    name = json['name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    recordPath = json['record_path'];
    role = json['role'];
    date = json['date'];
    referBy = json['refer_by'];
    referName = json['refer_name'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    termCondition = json['term_condition'];
    policy = json['policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gainpro_user_id'] = this.gainzProUserId;
    data['name'] = this.name;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['record_path'] = this.recordPath;
    data['role'] = this.role;
    data['date'] = this.date;
    data['refer_by'] = this.referBy;
    data['refer_name'] = this.referName;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['term_condition'] = this.termCondition;
    data['policy'] = this.policy;
    return data;
  }
}
