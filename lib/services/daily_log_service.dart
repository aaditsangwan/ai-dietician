import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/daily_log.dart';

class DailyLogService {
  static String _logKey(String date) => 'log_$date';

  static Future<DailyLog> loadLog(String date) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_logKey(date));

    if (jsonString != null) {
      return DailyLog.fromJson(jsonDecode(jsonString));
    } else {
      return DailyLog.empty(date);
    }
  }

  static Future<void> saveLog(DailyLog log) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(log.toJson());
    await prefs.setString(_logKey(log.date), jsonString);
  }

  static Future<void> clearLog(String date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_logKey(date));
  }
}
