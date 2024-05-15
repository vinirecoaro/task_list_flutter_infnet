import 'package:flutter/material.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/routes.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem(this.task, {super.key});

  final Task task;

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      subtitle: Text(widget.task.description),
      trailing: Text(widget.task.date),
      onTap: () {
        widget.task.edit = true;
        Navigator.pushNamed(context, Routes.ADD_TASK, arguments: widget.task);
      },
    );
  }
}
