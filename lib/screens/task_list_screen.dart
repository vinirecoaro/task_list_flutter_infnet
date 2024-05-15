import 'package:flutter/material.dart';
import 'package:task_app/components/default_app_bar.dart';
import 'package:task_app/components/task_list_item.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/routes.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> taskList = [];

  void _addTask(Task task) {
    setState(() {
      taskList.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Lista de Tarefas'),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context, index) {
                    Task task = taskList[index];
                    return TaskListItem(task);
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.ADD_TASK,
                  arguments:
                      Task(title: '', description: '', date: '', time: ''))
              .then((task) {
            if (task != null) {
              _addTask(task as Task);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
