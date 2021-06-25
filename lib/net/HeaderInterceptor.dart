import 'dart:async';

import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  Future<FutureOr> onRequest(RequestOptions options) async {
    options.headers.addAll(headMaps);
    return super.onRequest(options);
  }

  var headMaps = Map<String, String>();

  setHeaderMap(Map<String, String> params) {
    headMaps = params;
  }

  put(String key, String value) {
    headMaps[key] = value;
  }

  clearHeader() {
    headMaps?.clear();
  }
}
