// baseurl: https://newsapi.org/
// method:  v2/top-headlines?
// queries: country=eg&category=business&apiKey=55bd1aaa716d4d3c84776e12fd0f663f

// https://newsapi.org/v2/everything?q=tesla&apiKey=55bd1aaa716d4d3c84776e12fd0f663f


import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: 'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic>? query,
    // String lang = 'ar',
    // String? token,
  }) async {
    // dio.options.headers = {
    //   'lang': lang,
    //   'Authorization': token,
    // };

    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };

    return dio.post(url, data: data);
  }
}
