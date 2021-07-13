import 'package:flutter_common_lib/generated/json/base/json_convert_content.dart';

class BaseResult<T> {
  T data;
  int errorCode;
  String errorMsg;

  @override
  String toString() {
    return 'BaseResult{data: $data, errorCode: $errorCode, errorMsg: $errorMsg}';
  }

  bool get success => errorCode == 0;

  BaseResult({this.data, this.errorCode, this.errorMsg});

  BaseResult.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null && json['data'] != 'null') {
      data = JsonConvert.fromJsonAsT<T>(json['data']);
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data;
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class HttpError {
  int errorCode;
  String errorMsg;

  @override
  String toString() {
    return 'HttpError{errorCode: $errorCode, errorMsg: $errorMsg}';
  }
  HttpError({this.errorCode, this.errorMsg});
}
