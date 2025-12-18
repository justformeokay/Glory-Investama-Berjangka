import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/system_ui_helper.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  final Rx<ThemeMode> _themeMode = ThemeMode.light.obs;

  ThemeMode get themeMode => _themeMode.value;
  bool get isDarkMode => _themeMode.value == ThemeMode.dark;

  @override
  void onInit() {
    super.onInit();
    // Load saved theme preference
    _loadThemePreference();
    // Set initial system UI overlay style
    _updateSystemUIOverlay();
  }

  void toggleTheme() {
    _themeMode.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    _saveThemePreference();
    _updateSystemUIOverlay();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode.value = mode;
    _saveThemePreference();
    _updateSystemUIOverlay();
  }

  void _updateSystemUIOverlay() {
    SystemUIHelper.setSystemUIOverlayStyle(_themeMode.value);
  }

  Future<void> _loadThemePreference() async {
    // TODO: Implement SharedPreferences to save theme preference
    // For now, we'll use light theme as default
    _themeMode.value = ThemeMode.light;
  }

  Future<void> _saveThemePreference() async {
    // TODO: Implement SharedPreferences to save theme preference
  }
}
