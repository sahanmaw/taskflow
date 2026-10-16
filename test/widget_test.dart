import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:taskflow/screens/add_task_screen.dart';

void main() {
  testWidgets('Add Task screen displays correctly', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddTaskScreen()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Add Task'), findsWidgets);
  });
}
