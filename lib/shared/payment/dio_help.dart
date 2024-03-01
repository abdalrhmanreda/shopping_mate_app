import 'package:dio/dio.dart';
import 'package:shop_app_first/shared/constant.dart';

class DioHelper2 {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
        }));
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    var respone = dio!.post(url, queryParameters: query, data: data);
    return respone;
  }

  static Future<Response>? getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return dio!.get(url, queryParameters: query);
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String lang = 'en',
    String? token,
  }) {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json'
    };
    return dio!.delete(url, queryParameters: query);
  }
}
