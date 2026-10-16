import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStorage {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  Future<void> saveTasks(List<Task> tasks) async {
    final data = tasks.map((task) => task.toJson()).toList();

    final text = jsonEncode(data);

    await prefs.setString('tasks', text);
  }

  Future<List<Task>> loadTasks() async {
    final text = await prefs.getString('tasks');

    if (text == null) {
      return [];
    }

    final List<dynamic> data = jsonDecode(text);

    return data.map((item) => Task.fromJson(item)).toList();
  }
}
