import 'dart:convert';

import 'package:fridge_cook/src/app/SharedPreferencesKeys.dart';
import 'package:fridge_cook/src/domain/entities/performance.dart';
import 'package:fridge_cook/src/domain/repositories/performance_repository.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    // final prefs = await SharedPreferences.getInstance();
    // var value = prefs.getString(key);
    // var decoded = json.decode(value);
    // return decoded;
    return false;
  }

  save(String key, value) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.setString(key, json.encode(value));
    // var jjson = prefs.getString(key);
    // print("saved: $jjson");
  }

  remove(String key) async {
    // final prefs = await SharedPreferences.getInstance();
    // prefs.remove(key);
  }
}

class SharedPreferencesPerformanceRepository extends PerformanceRepository {

  final SharedPref _sharedPref = SharedPref();

  @override
  Future<bool> add(Performance performance) async {
    int performanceCount;
    try {
      performanceCount = await _sharedPref.read(SharedPreferencesKeys.performanceCount);
    } catch (e) {
      performanceCount = 0;
    }
    performanceCount++;
    await _sharedPref.save(SharedPreferencesKeys.performanceCount, performanceCount);

    var key = _makePerformanceKey(performanceCount);
    await _sharedPref.save(key, performance);

    return true;
  }

  @override
  Future<List<Performance>> all() async {
    var perfs = <Performance>[];
    int performanceCount;
    try {
      performanceCount = await _sharedPref.read(SharedPreferencesKeys.performanceCount);
    } catch (e) {
      return [];
    }

    for (var i = 1 ; i < (performanceCount + 1) ; i++) {
      var key = _makePerformanceKey(i);
      try {
        var perfJson = await _sharedPref.read(key);
        var perf = Performance.fromJson(perfJson);
        perfs.add(perf);
      } catch (e) {
        print("error: ${e.toString()}");
      }
    }

    return perfs;
  }

  String _makePerformanceKey(int count) {
    return SharedPreferencesKeys.performance + count.toString();
  }

}

class InMemoryPerformanceRepository extends PerformanceRepository {
  List<Performance> _perfs;

  InMemoryPerformanceRepository(this._perfs);

  @override
  Future<bool> add(Performance performance) async {
    this._perfs.add(performance);
    return true;
  }

  @override
  Future<List<Performance>> all() async {
    return _perfs;
  }

}