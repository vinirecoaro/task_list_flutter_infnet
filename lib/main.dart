import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/providers/task_list_provider.dart';
import 'package:task_app/routes.dart';
import 'package:task_app/screens/add_task_screen.dart';
import 'package:task_app/screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskListProvider>(
            create: (context) => TaskListProvider())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        routes: {
          Routes.TASK_LIST: (context) => TaskListScreen(),
          Routes.ADD_TASK: (context) => AddTaskScreen()
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
