import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hm_shop/constants/index.dart';

class Diorequest {
  final _dio = Dio();
  Diorequest() {
    _dio.options.baseUrl = GlobalConstants.BASE_URL;
    _dio.options.connectTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    
    // 在Flutter Web中，sendTimeout不能用于GET请求（无请求体）
    if (!kIsWeb) {
      _dio.options.sendTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    }
    
    _dio.options.receiveTimeout = Duration(seconds: GlobalConstants.TIME_OUT);
    _addIntercepter();

    //  _dio.options.headers = {
    //   'Access-Control-Allow-Origin': '*',
    //   'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    //   'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept, Authorization, X-Request-ID',
    // };
  }

  void _addIntercepter() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          handler.next(request);
        },
        onResponse: (response, handler) {
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            handler.next(response);
            return;
          }
          handler.reject(DioException(requestOptions: response.requestOptions));
        },
        onError: (error, handler) {
          handler.reject(error);
        },
      ),
    );
  }

  dynamic get(String url, {Map<String, dynamic>? params}) {
    return _hanleResponse(_dio.get(url, queryParameters: params));
  }

  Future<dynamic> _hanleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
        print("返回json结果:${data}");
      if (data["code"] == GlobalConstants.SUCCESS_CODE) {
        
        print("返回json结果:${data}");
        return data["result"];
      }
      throw Exception(data["msg"] ?? "加载数据异常");
    } catch (e) {
        print("a");
      throw Exception(e);
    }
  }
}

final diorequest = Diorequest();
