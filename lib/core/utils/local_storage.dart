import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  static late SharedPreferences _prefs;
  static const String _keyUserToken = 'user_token';
  static const String _keyUserRole = 'user_role';
  static const String _keyUserId = 'user_id';
  static const String _keyLanguage = 'app_language';

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Theme related methods
  /// Retrieves the user's preferred theme from local storage.
  ///
  /// If no theme preference is found, the method returns 'light' as the default theme.
  ///
  /// Returns:
  ///   The user's preferred theme as a string, either 'light' or 'dark'.
  String getThemeData() {
    return _prefs.getString('theme') ?? 'light'; // Default to light theme
  }

  Future<bool> setThemeData(String theme) {
    return _prefs.setString('theme', theme);
  }

  // Add other preference methods as needed
  Future<bool> setOnboardingCompleted(bool value) {
    return _prefs.setBool('onboarding_completed', value);
  }

  bool isOnboardingCompleted() {
    return _prefs.getBool('onboarding_completed') ?? false;
  }

  // set user token

  /// Save user token
  static Future<void> saveUserToken(String token) async {
    await _prefs.setString(_keyUserToken, token);
  }

  static Future<void> saveUserId(String userId) async {
    await _prefs.setString(_keyUserId, userId);
  }

  static Future<void> saveUserRole(String userRole) async {
    await _prefs.setString(_keyUserRole, userRole);
  }

  static String? getUserRole() {
    return _prefs.getString(_keyUserRole);
  }

  static Future<void> clearUserRole() async {
    await _prefs.remove(_keyUserRole);
  }

  /// Get user token
  static String? getUserToken() {
    return _prefs.getString(_keyUserToken);
  }

  static String? getUserId() {
    return _prefs.getString(_keyUserId);
  }

  /// Remove user token
  static Future<void> clearUserToken() async {
    await _prefs.remove(_keyUserToken);
  }

  static Future<void> clearUserId() async {
    await _prefs.remove(_keyUserId);
  }

  /// Clear all saved data (if needed)
  static Future<void> clearAll() async {
    await _prefs.clear();
  }

  static Future<bool> setLanguage(String languageCode) async {
    return await _prefs.setString(_keyLanguage, languageCode);
  }

  static String getLanguage() {
    return _prefs.getString(_keyLanguage) ?? 'en'; // Default to English
  }
}
