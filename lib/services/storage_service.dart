import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/gpa_record.dart';

class StorageService {
  static const String _historyKey = 'gpa_history';
  
  Future<void> saveHistory(List<GPARecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> recordsJson = records.map((record) => jsonEncode(record.toJson())).toList();
    await prefs.setStringList(_historyKey, recordsJson);
  }
  
  Future<List<GPARecord>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? recordsJson = prefs.getStringList(_historyKey);
    
    if (recordsJson == null) return [];
    
    return recordsJson.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return GPARecord.fromJson(json);
    }).toList();
  }
  
  Future<void> deleteRecord(String id) async {
    final records = await loadHistory();
    records.removeWhere((record) => record.id == id);
    await saveHistory(records);
  }
  
  Future<void> clearAllHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
