import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The user's theme choice. MaterialApp rebuilds when it changes.
final themeMode = ValueNotifier(ThemeMode.system);

const _key = 'themeMode';

/// Reads the saved choice. Call once, before runApp.
Future<void> loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString(_key);
  themeMode.value = ThemeMode.values.firstWhere(
    (mode) => mode.name == saved, // 'system', 'light' or 'dark'
    orElse: () => ThemeMode.system,
  );
}

/// Applies [mode] immediately and remembers it for next launches.
Future<void> saveThemeMode(ThemeMode mode) async {
  themeMode.value = mode;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_key, mode.name);
}
