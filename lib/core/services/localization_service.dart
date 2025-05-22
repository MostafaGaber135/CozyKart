import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService {
  final Dio _dio = Dio();
  Future<Map<String, String>> loadTranslation(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('translation_$langCode');
    if (cachedData != null) {
      log('Loaded translation from cache');
      final jsonMap = json.decode(cachedData);
      return Map<String, String>.from(jsonMap);
    }
    try {
      final response = await _dio.get(
        'https://your-api.com/localization/$langCode',
      );

      final data = Map<String, dynamic>.from(response.data);
      await prefs.setString('translation_$langCode', json.encode(data));

      return data.map((key, value) => MapEntry(key, value.toString()));
    } catch (e) {
      log("Failed to fetch translation: $e");
      return {};
    }
  }
}
