import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/task_cubit.dart';

void main() {
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TaskFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) {
          TaskCubit taskCubit = TaskCubit();
          taskCubit.loadTasks(); //load saved tasks
          return taskCubit; //return the Cubit so BlocProvider can provide it to HomeScreen
        },
        child: const HomeScreen(),
      ),
    );
  }
}
