import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/widgets/task_tile.dart';

void main() {
  testWidgets('TaskTile displays the task title', (tester) async {
    Task task = Task(id: '1', title: 'Learn Flutter');

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskTile(
            task: task,
            onTap: () {},
            onDelete: () {},
            onEdit: () {},
          ),
        ),
      ),
    );

    expect(find.text('Learn Flutter'), findsOneWidget);
  });
}
