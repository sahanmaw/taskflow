import 'package:flutter/material.dart';
import '../models/api_task.dart';
import '../services/task_api.dart';

class ApiTasksScreen extends StatefulWidget {
  const ApiTasksScreen({super.key});

  @override
  State<ApiTasksScreen> createState() => _ApiTasksScreenState();
}

class _ApiTasksScreenState extends State<ApiTasksScreen> {
  final TaskApi taskApi = TaskApi();

  List<ApiTask> tasks = [];

  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      List<ApiTask> fetchedTasks = await taskApi.fetchTasks();

      if (!mounted) {
        //mounted tells whether the widget is still part of the widget tree
        return;
      }

      setState(() {
        tasks = fetchedTasks;
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }

      setState(() {
        errorMessage = 'Failed to load tasks. Please try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Tasks'), centerTitle: true),

      body: buildBody(),
    );
  }

  Widget buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(errorMessage),

            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: loadTasks,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks found'));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        ApiTask task = tasks[index];

        return ListTile(
          title: Text(task.title),
          leading: Icon(
            task.completed ? Icons.check_circle : Icons.radio_button_unchecked,
          ),
        );
      },
    );
  }
}
