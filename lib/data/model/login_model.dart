class LoginModel {
  bool? status;
  int? id;
  String? message;
  String? userToken;

  LoginModel(
    this.status,
    this.id,
    this.message,this.userToken
  );
  // LoginModel({this.status, this.message});

  bool get isStatus => status ?? false;
  int get isId => id ?? 0;
  String get isSuccess => message ?? '';
  String get isUserToken => userToken ?? '';
}
