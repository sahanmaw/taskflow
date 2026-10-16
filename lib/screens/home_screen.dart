import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';
import 'edit_task_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/task_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String filter = 'All';

  //changes the checkbox selection
  Future<void> toggleTask(Task task) async {
    TaskCubit taskCubit = context.read<TaskCubit>();

    await taskCubit.toggleTask(task);
  }

  //delete task from the list
  Future<void> deleteTask(Task task) async {
    TaskCubit taskCubit = context.read<TaskCubit>();

    await taskCubit.deleteTask(task);
  }

  //edit task title
  Future<void> editTask(Task task) async {
    final title = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(title: task.title),
      ),
    );

    if (!mounted || title == null || title.isEmpty) {
      return;
    }

    TaskCubit taskCubit = context.read<TaskCubit>();

    await taskCubit.editTask(task, title);
  }

  //add new task to the list
  Future<void> addTask() async {
    final title = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );

    if (!mounted || title == null || title.isEmpty) {
      return;
    }

    TaskCubit taskCubit = context.read<TaskCubit>();

    await taskCubit.addTask(title);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, List<Task>>(
      builder: (context, tasks) {
        List<Task> filteredTasks = tasks;

        if (filter == 'Active') {
          filteredTasks = tasks.where((task) => !task.isCompleted).toList();
        } else if (filter == 'Completed') {
          filteredTasks = tasks.where((task) => task.isCompleted).toList();
        }

        return Scaffold(
          appBar: AppBar(title: const Text('TaskFlow'), centerTitle: true),

          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Tasks',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                Text(
                  'You have ${tasks.length} tasks today',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 137, 136, 136),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    for (final name in ['All', 'Active', 'Completed'])
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(name),
                          selected: filter == name,
                          onSelected: (selected) {
                            setState(() {
                              filter = name;
                            });
                          },
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = filteredTasks[index];

                      return TaskTile(
                        task: task,
                        onTap: () {
                          toggleTask(task);
                        },
                        onDelete: () {
                          deleteTask(task);
                        },
                        onEdit: () {
                          editTask(task);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: addTask,
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
