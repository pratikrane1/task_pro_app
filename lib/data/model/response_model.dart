class ResponseModel {
  bool _isSuccess;
  int? status;
  String _message;
  ResponseModel(this._isSuccess, this._message,this.status,);

  String get message => _message;
  bool get isSuccess => _isSuccess;
  int get isStatus => status ?? 0;
}