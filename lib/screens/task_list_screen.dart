import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/components/default_app_bar.dart';
import 'package:task_app/components/task_list_item.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/providers/task_list_provider.dart';
import 'package:task_app/routes.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskListProvider>();
    final List<Task> taskList = taskProvider.taskList;

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
                  arguments: Task(
                      id: 0, title: '', description: '', date: '', time: ''))
              .then((task) {
            if (task != null) {
              taskProvider.addTask(task as Task);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
