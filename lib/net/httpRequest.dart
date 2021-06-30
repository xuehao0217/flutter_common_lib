import 'package:dio/dio.dart';
import 'package:flutter_common_lib/helper/logUtils.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'dart:convert';
import 'globalConfig.dart';
import 'headerInterceptor.dart';
import 'resultCode.dart';

/*
 * 网络请求管理类
 */
class HttpRequest {
  static HttpRequest _instance = HttpRequest._internal();
  static HeaderInterceptor _headerInterceptor = HeaderInterceptor();

  Dio dio;

  HttpRequest._internal({String baseUrl}) {
    if (null == dio) {
      dio = new Dio(new BaseOptions(
          baseUrl: baseUrl ?? GlobalConfig.BASE_URL, connectTimeout: 15000));
      dio.interceptors.add(_headerInterceptor);
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ));
    }
  }

  static HttpRequest getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  HttpRequest _baseUrl(String baseUrl) {
    if (dio != null) {
      dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpRequest _normal() {
    if (dio != null) {
      if (dio.options.baseUrl != GlobalConfig.BASE_URL) {
        dio.options.baseUrl = GlobalConfig.BASE_URL;
      }
    }
    return this;
  }

  reset() {
    _instance = null;
    _headerInterceptor?.clearHeader();
  }

  addHeader(Map<String, String> params) {
    _headerInterceptor?.setHeaderMap(params);
  }

  putHeadr(String key, String value) {
    _headerInterceptor?.put(key, value);
  }

  //get请求
  get(String url, params, Function successCallBack,
      {Function errorCallBack, Function finallyCallBack}) async {
    _requstHttp(
        url, successCallBack, 'get', params, errorCallBack, finallyCallBack);
  }

  //post请求
  post(String url, params, Function successCallBack,
      {Function errorCallBack, Function finallyCallBack}) async {
    _requstHttp(
        url, successCallBack, "post", params, errorCallBack, finallyCallBack);
  }

  _requstHttp(String url, Function successCallBack,
      [String method,
      Map<String, dynamic> params,
      Function errorCallBack,
      Function finallyCallBack]) async {
    Response response;
    try {
      if (method == 'get') {
        response = await dio.get(url, queryParameters: params);
      } else if (method == 'post') {
        response = await dio.post(url, data: params);
      }
    } on DioError catch (error) {
      // 请求错误处理
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      // 请求超时
      if (error.type == DioErrorType.connectTimeout) {
        errorResponse.statusCode = ResultCode.CONNECT_TIMEOUT;
      }
      // 一般服务器错误
      else if (error.type == DioErrorType.receiveTimeout) {
        errorResponse.statusCode = ResultCode.RECEIVE_TIMEOUT;
      }
      _error(errorCallBack, error.message);
      return '';
    } finally {
      finallyCallBack?.call();
    }

    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['state'] == 0) {
      _error(
          errorCallBack,
          '错误码：' +
              dataMap['errorCode'].toString() +
              '，' +
              response.data.toString());
    }
    successCallBack?.call(dataMap);
  }

  _error(Function errorCallBack, String error) {
    errorCallBack?.call(error);
  }
}
