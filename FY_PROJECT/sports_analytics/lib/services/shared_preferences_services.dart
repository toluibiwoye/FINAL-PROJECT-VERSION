import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferencesService is a utility class for managing shared preferences.
class SharedPreferencesService {
  // Static instance of SharedPreferences for global access.
  static SharedPreferences? preferences;

  // Singleton instance of SharedPreferencesService.
  static final SharedPreferencesService instance = SharedPreferencesService();

  // Private constructor for the singleton pattern.
  SharedPreferencesService();

  // Asynchronous method to get the singleton instance of SharedPreferencesService.
  static Future<SharedPreferencesService> getInstance() async {
    // If preferences is null, initialize shared preferences.
    if (preferences == null) {
      await _initSharedPreferences();
    }
    return instance;
  }

  // Asynchronous method to initialize shared preferences.
  static Future<void> _initSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }

  // Asynchronous method to save an ID in shared preferences.
  Future<void> saveID(String value) async {
    try {
      await preferences!.setString('id', value);
      print('Saved id type: $value');
    } catch (e) {
      print('Error saving id type: $e');
    }
  }

  // Asynchronous method to save a boolean value in shared preferences.
  Future<bool?> putBool(String key, bool value) =>
      preferences!.setBool(key, value);

  // Synchronous method to get a boolean value from shared preferences.
  bool getBool(String key) => preferences?.getBool(key) ?? false;
}