import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(key);
    var decoded = json.decode(value);
    print("decoded[$key]: $value => $decoded");
    return decoded;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
    var jjson = prefs.getString(key);
    print("saved[$key]: $value => $jjson");
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}