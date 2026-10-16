import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_task.dart';

class TaskApi {
  Future<List<ApiTask>> fetchTasks() async {
    Uri url = Uri.parse(
      //the address of the API
      'https://jsonplaceholder.typicode.com/todos',
    ); //converts a URL string into a URI

    http.Response response = await http.get(
      url,
    ); //sends a GET request and waits for the server's response

    // Check whether the request was successful
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(
        response.body,
      ); //convert the JSON response into Dart data

      List<ApiTask> tasks = []; //create an empty list to store ApiTask objects

      for (dynamic item in data) {
        //loop through the list of tasks and convert each one into an ApiTask object
        ApiTask task = ApiTask.fromJson(item as Map<String, dynamic>);

        tasks.add(task);
      }
      return tasks; // Return the list of ApiTask objects
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
