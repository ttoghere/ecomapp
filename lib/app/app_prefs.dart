import 'package:ecomapp/presentation/management/management_shelf.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefs_key_lang = "prefs key lang";

class AppPreferences {
  SharedPreferences sharedPreferences;
  AppPreferences({
    required this.sharedPreferences,
  });
  Future<String> getAppLanguage() async {
    String? language = sharedPreferences.getString(prefs_key_lang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.Turkish.getValue();
    }
  }
}
