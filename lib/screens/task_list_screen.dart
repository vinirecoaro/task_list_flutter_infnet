import 'package:flutter/material.dart';
import 'package:task_app/components/task_list_item.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tarefas'),
          backgroundColor: Colors.blueGrey,
          titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24),
        ),
        body: Column(
          children: [
            TaskListItem(),
          ],
        ));
  }
}
