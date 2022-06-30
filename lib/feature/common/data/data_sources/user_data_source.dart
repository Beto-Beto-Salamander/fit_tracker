import 'dart:convert';

import 'package:fit_tracker/lib.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataSource {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<UserEntity?> get(String params) async {
    final SharedPreferences prefs = await _prefs;
    final result = prefs.get(params);
    final entity = UserEntity.fromMap(result as Map<String, dynamic>);

    return entity;
  }

  Future<void> store(UserEntity params) async {
    final SharedPreferences prefs = await _prefs;
    final map = params.toJson();
    await prefs.setString(params.email, jsonEncode(map));
  }

  Future<void> update(UserEntity params) async {
    await delete(params.email);
    await store(params);
  }

  Future deleteAll() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }

  Future delete(String params) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove(params);
  }
}
