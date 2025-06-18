import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/time_tracking.dart';

class TimeTrackingRepository {
  static const _key = 'time_tracking_records';

  Future<List<TimeTracking>> getRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => TimeTracking.fromJson(json)).toList();
  }

  Future<void> addRecord(TimeTracking record) async {
    final records = await getRecords();
    records.add(record);
    await _saveRecords(records);
  }

  Future<void> updateRecordCheckOut(String recordId, DateTime checkOutTime) async {
    final records = await getRecords();
    final index = records.indexWhere((r) => r.id == recordId);
    if (index != -1) {
      final record = records[index];
      records[index] = TimeTracking(
        id: record.id,
        employeeId: record.employeeId,
        date: record.date,
        checkIn: record.checkIn,
        checkOut: checkOutTime,
      );
      await _saveRecords(records);
    }
  }

  Future<void> _saveRecords(List<TimeTracking> records) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = records.map((r) => r.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_key, jsonString);
  }
}
