import 'package:shared_preferences/shared_preferences.dart';

class websites_names {
  static List<String> websiteList = [
    "Twitter",
    "Facebook",
    "Instagram",
    "Dribbble",
    "Netflix"
  ];
  
  // ✅ Load saved websites from SharedPreferences
  static Future<void> loadWebsites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedWebsites = prefs.getStringList('savedWebsites');

    if (savedWebsites != null && savedWebsites.isNotEmpty) {
      websiteList = savedWebsites; // ✅ Replace with saved list
    }
  }

  // ✅ Save websites to SharedPreferences
  static Future<void> saveWebsites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedWebsites', websiteList);
  }
}
