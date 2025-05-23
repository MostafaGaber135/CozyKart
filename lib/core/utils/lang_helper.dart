import 'package:flutter/material.dart';

String getLocalizedValue(Map<String, dynamic>? valueMap, BuildContext context) {
  if (valueMap == null) return '';
  final lang = Localizations.localeOf(context).languageCode;
  return valueMap[lang] ?? valueMap['en'] ?? '';
}
