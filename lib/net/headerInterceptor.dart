import 'dart:async';

import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll(headMaps);
    super.onRequest(options, handler);
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
