import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/routes.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  var task = Task(
      title: 'Titulo',
      description: 'description',
      date: '11/05/2024',
      time: '19:15');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: Text(task.date),
      onTap: () {
        Navigator.pushNamed(context, Routes.ADD_TASK, arguments: task);
      },
    );
  }
}
