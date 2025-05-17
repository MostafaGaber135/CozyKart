import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
class DioHelper {
  static late Dio dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://furniture-backend-production-8726.up.railway.app/',
        headers: {'Content-Type': 'application/json'},
        validateStatus: (status) => status! < 500,
      ),
    );
  }

  static Future<void> setTokenHeader() async {
    final token = await SharedPrefsHelper.getToken();

    log("Saved token: $token");
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  static Future<Response> getData({required String url}) async {
    await setTokenHeader();
    return await dio.get(url);
  }

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
  }) async {
    await setTokenHeader();
    return await dio.post(url, data: data);
  }
}
