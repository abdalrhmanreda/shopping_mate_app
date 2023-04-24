import 'package:dio/dio.dart';

class DioHelper {
  static Dio ? dio;

  static init() {
    dio = Dio(
        BaseOptions(
            baseUrl: 'https://student.valuxapps.com/api/',
            receiveDataWhenStatusError: true,
            headers: {
              'Content-Type': 'application/json',
            }
        )
    );
  }


  static Future<Response> PostData({
    required String url,
    Map<String, dynamic>?query,
    required Map<String, dynamic>data,
    String lang = 'en',
    String?token,
  }) {
    dio!.options.headers=
    {
      'lang':lang,
      'Authorization':token ,
      'Content-Type' : 'application/json'

    };
    var respone = dio!.post(url, queryParameters: query, data: data);
    return respone;
  }


static Future<Response>?GetData({
    required String url ,
     Map<String,dynamic>?query ,
  String lang = 'en',
  String?token,

})
{
  dio!.options.headers=
  {
    'lang':lang,
    'Authorization':token ,
    'Content-Type' : 'application/json'

  };
 return dio!.get(url , queryParameters: query) ;
}


  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>?query,
    Map<String, dynamic>?data,
    String lang = 'en',
    String?token,
  })
  {
    dio!.options.headers=
    {
      'lang':lang,
      'Authorization':token ,
      'Content-Type' : 'application/json'

    };
    return dio!.delete(url , queryParameters: query) ;

  }
}

