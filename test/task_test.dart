import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/models/task.dart';

void main() {
  test('Task is created with correct values', () {
    Task task = Task(id: '1', title: 'Learn Flutter');

    expect(task.id, '1');
    expect(task.title, 'Learn Flutter');
    expect(task.isCompleted, false);
  });

  test('Task converts to JSON correctly', () {
    Task task = Task(id: '2', title: 'Write Flutter blog', isCompleted: true);

    Map<String, dynamic> json = task.toJson();

    expect(json['id'], '2');
    expect(json['title'], 'Write Flutter blog');
    expect(json['isCompleted'], true);
  });

  test('Task is created from JSON correctly', () {
    Map<String, dynamic> json = {
      'id': '3',
      'title': 'Practice Flutter testing',
      'isCompleted': false,
    };

    Task task = Task.fromJson(json);

    expect(task.id, '3');
    expect(task.title, 'Practice Flutter testing');
    expect(task.isCompleted, false);
  });
}
