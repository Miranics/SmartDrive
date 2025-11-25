import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _darkModeKey = 'darkMode';
  static const String _notificationsKey = 'notifications';
  static const String _studyRemindersKey = 'studyReminders';
  static const String _soundEffectsKey = 'soundEffects';

  static Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  static Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }

  static Future<bool> getNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true;
  }

  static Future<void> setNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, value);
  }

  static Future<bool> getStudyReminders() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_studyRemindersKey) ?? true;
  }

  static Future<void> setStudyReminders(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_studyRemindersKey, value);
  }

  static Future<bool> getSoundEffects() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_soundEffectsKey) ?? true;
  }

  static Future<void> setSoundEffects(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_soundEffectsKey, value);
  }
}
