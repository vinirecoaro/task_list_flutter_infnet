import 'package:flutter/material.dart';

class TaskListItem extends StatelessWidget {
  const TaskListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Titulo"),
      subtitle: Text("Description"),
      trailing: Text("10/05/2024"),
    );
  }
}
