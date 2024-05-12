import 'package:flutter/material.dart';
import 'package:task_app/components/default_app_bar.dart';
import 'package:task_app/components/input_field.dart';
import 'package:task_app/components/input_field_large.dart';
import 'package:task_app/models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool isChecked = true;

  @override
  Widget build(BuildContext context) {
    bool view;
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    // final TextEditingController dateController = TextEditingController();
    // final TextEditingController timeController = TextEditingController();

    view = task.edit;
    titleController.text = task.title;
    descriptionController.text = task.description;

    return Scaffold(
        appBar: const DefaultAppBar(title: 'Adicionar Tarefa'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (!view)
                Column(
                  children: [
                    InputField(
                      label: "Título",
                      controller: titleController,
                    ),
                    InputFieldLarge(
                      label: "Descrição",
                      controller: descriptionController,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                        const Text("Usar minha localização")
                      ],
                    ),
                    // if (!isChecked)
                    //   Column(
                    //     children: [
                    //       InputField(
                    //         label: "CEP",
                    //         controller: cepController,
                    //       ),
                    //       InputField(
                    //         label: "Número",
                    //         controller: numController,
                    //       ),
                    //     ],
                    //   ),
                    FilledButton(
                      onPressed: () {},
                      child: const Text("Enviar"),
                    ),
                  ],
                ),
              if (view)
                Column(
                  children: [
                    InputField(
                      label: "Título",
                      controller: titleController,
                    ),
                    InputFieldLarge(
                      label: "Descrição",
                      controller: descriptionController,
                    ),
                  ],
                )
            ],
          ),
        ));
  }
}
