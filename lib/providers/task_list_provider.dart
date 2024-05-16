import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> taskList = [];

  void addTask(Task task) {
    taskList.add(task);
    notifyListeners();
  }
}
