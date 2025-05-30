import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';

class DioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://furniture-nodejs-production-665a.up.railway.app/',
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status != null && status < 500,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
  }

  static Future<void> setTokenHeader() async {
    final token = await SharedPrefsHelper.getToken();
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      log("Header token set: Bearer $token");
    } else {
      log("Token is missing!");
    }
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
      options: Options(headers: headers),
    );
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.post(url, data: data, options: Options(headers: headers));
  }

  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.delete(url, options: Options(headers: headers));
  }

  static Future<Response> putData({
    required String url,
    required dynamic data,
    Map<String, String>? extraHeaders,
  }) async {
    await setTokenHeader();

    final headers = Map<String, dynamic>.from(dio.options.headers);
    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }

    return await dio.put(url, data: data, options: Options(headers: headers));
  }

  static Future<Response> patchData({
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.patch(url, data: data, options: Options(headers: headers));
  }
}
