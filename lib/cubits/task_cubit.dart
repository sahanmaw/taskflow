import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/task.dart';
import '../services/task_storage.dart';

class TaskCubit extends Cubit<List<Task>> {
  final TaskStorage storage = TaskStorage();

  TaskCubit() : super([]); //this sets the initial state to an empty task list

  //retrieves the tasks from local storage and updates the Cubit’s state
  Future<void> loadTasks() async {
    List<Task> savedTasks = await storage.loadTasks();
    emit(savedTasks); //changes the state and notifies listeners
  }

  Future<void> addTask(String title) async {
    Task newTask = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
    );

    List<Task> updatedTasks = List<Task>.from(
      state,
    ); //create a new list containing all the tasks from the current state

    updatedTasks.add(newTask); //adds the new task to that list
    emit(updatedTasks); //updates the Cubit’s state
    await storage.saveTasks(updatedTasks); //saves the updated list
  }

  Future<void> toggleTask(Task task) async {
    List<Task> updatedTasks = [];

    for (Task currentTask in state) {
      if (currentTask.id == task.id) {
        Task changedTask = Task(
          id: currentTask.id,
          title: currentTask.title,
          isCompleted: !currentTask.isCompleted,
        );

        updatedTasks.add(changedTask);
      } else {
        updatedTasks.add(currentTask);
      }
    }
    emit(updatedTasks);
    await storage.saveTasks(updatedTasks);
  }

  // Deletes a task from the list
  Future<void> deleteTask(Task task) async {
    List<Task> updatedTasks = [];

    for (Task currentTask in state) {
      if (currentTask.id != task.id) {
        updatedTasks.add(currentTask);
      }
    }

    emit(updatedTasks);

    await storage.saveTasks(updatedTasks);
  }

  // Updates the title of an existing task
  Future<void> editTask(Task task, String newTitle) async {
    List<Task> updatedTasks = [];

    for (Task currentTask in state) {
      if (currentTask.id == task.id) {
        Task changedTask = Task(
          id: currentTask.id,
          title: newTitle,
          isCompleted: currentTask.isCompleted,
        );

        updatedTasks.add(changedTask);
      } else {
        updatedTasks.add(currentTask);
      }
    }

    emit(updatedTasks);

    await storage.saveTasks(updatedTasks);
  }
}
