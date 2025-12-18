import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_translations.dart';

class LocalizationService extends Translations {
  static final LocalizationService _instance = LocalizationService._internal();

  factory LocalizationService() {
    return _instance;
  }

  LocalizationService._internal();

  static const fallbackLocale = Locale('en', 'US');
  static const supportedLocales = [
    Locale('id', 'ID'),
    Locale('en', 'US'),
  ];

  @override
  Map<String, Map<String, String>> get keys => translations;

  // Get translation string
  static String tr(String key) {
    return key.tr;
  }

  // Change locale
  static Future<void> changeLocale(String languageCode) async {
    final locale = _getLocale(languageCode);
    Get.updateLocale(locale);
  }

  // Get Locale from language code
  static Locale _getLocale(String languageCode) {
    switch (languageCode) {
      case 'id':
        return const Locale('id', 'ID');
      case 'en':
      default:
        return const Locale('en', 'US');
    }
  }

  // Get current language code
  static String getCurrentLanguageCode() {
    return Get.locale?.languageCode ?? 'en';
  }

  // Get list of supported languages
  static List<Map<String, String>> getSupportedLanguages() {
    return [
      {'code': 'id', 'name': 'Bahasa Indonesia'},
      {'code': 'en', 'name': 'English'},
    ];
  }
}
