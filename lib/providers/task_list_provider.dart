import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';

class TaskListProvider extends ChangeNotifier {
  List<Task> taskList = [];

  void addTask(Task task) {
    taskList.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    int index = taskList.indexWhere((element) => element.id == task.id);
    taskList[index] = Task(
        id: task.id,
        description: task.description,
        title: task.title,
        date: task.date,
        time: task.time,
        lat: task.lat,
        lon: task.lon,
        edit: task.edit,
        cep: task.cep,
        num: task.num);
    notifyListeners();
  }
}
