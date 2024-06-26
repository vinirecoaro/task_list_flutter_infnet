import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:task_app/components/default_app_bar.dart';
import 'package:task_app/components/input_field.dart';
import 'package:task_app/components/input_field_large.dart';
import 'package:task_app/models/task.dart';
import 'package:task_app/providers/task_list_provider.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  bool useMyLocation = false;
  bool defineAPlace = false;
  bool defineDateTime = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController numController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  bool editInitialState = true;
  bool initialState = true;
  bool view = false;
  double lat = 0;
  double lon = 0;

  @override
  void initState() {
    super.initState();
    dateController.text = formatDate(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    final Task task = ModalRoute.of(context)!.settings.arguments as Task;
    final taskProvider = context.watch<TaskListProvider>();
    final taskListLenght = taskProvider.taskList.length;

    if (initialState) {
      initialState = false;
      view = task.edit;
      titleController.text = task.title;
      descriptionController.text = task.description;
      cepController.text = task.cep;
      numController.text = task.num;
      timeController.text = task.time;
      dateController.text = task.date;
    }

    if (!view) {
      if (useMyLocation) {
        getPosition();
      }
    }

    if (view && editInitialState) {
      editInitialState = false;
      if (task.date == '') {
        defineDateTime = false;
      } else {
        defineDateTime = true;
      }
      if (task.lat == '' && task.cep == '') {
        defineAPlace = false;
      } else {
        if (task.cep != '') {
          useMyLocation = false;
          defineAPlace = true;
        }
        if (task.lat != '') {
          useMyLocation = true;
          defineAPlace = true;
        }
      }
    }

    return Scaffold(
        appBar: !view
            ? const DefaultAppBar(title: 'Adicionar Tarefa')
            : AppBar(
                title: const Text('Editar Tarefa'),
                backgroundColor: Colors.blueGrey,
                titleTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 24),
                actions: [
                  IconButton(
                      onPressed: () {
                        taskProvider.deleteTask(task);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
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
                            value: defineDateTime,
                            onChanged: (value) {
                              setState(() {
                                defineDateTime = value!;
                              });
                            }),
                        const Text("Definir hora e data")
                      ],
                    ),
                    if (defineDateTime)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  label: "Data",
                                  controller: dateController,
                                  readOnly: true,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 15, top: 8, bottom: 8),
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: InkWell(
                                    onTap: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: currentDate,
                                              firstDate: DateTime(2015, 8),
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        dateController.text =
                                            formatDate(pickedDate);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Icon(Icons.calendar_month)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  label: "Horário",
                                  controller: timeController,
                                  readOnly: true,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 15, top: 8, bottom: 8),
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: InkWell(
                                    onTap: () async {
                                      final TimeOfDay? pickedTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: currentTime);
                                      if (pickedTime != null) {
                                        timeController.text =
                                            formatTime(pickedTime);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Icon(Icons.access_time)),
                              )
                            ],
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Checkbox(
                            value: defineAPlace,
                            onChanged: (value) {
                              setState(() {
                                defineAPlace = value!;
                              });
                            }),
                        const Text("Definir um local")
                      ],
                    ),
                    if (defineAPlace)
                      Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: useMyLocation,
                                  onChanged: (value) {
                                    setState(() {
                                      useMyLocation = value!;
                                    });
                                  }),
                              const Text("Usar minha localização")
                            ],
                          ),
                          if (useMyLocation)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LAT: ${lat.toString()}',
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      'LON: ${lon.toString()}',
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                )
                              ],
                            ),
                          if (!useMyLocation)
                            Column(
                              children: [
                                InputField(
                                  label: "CEP",
                                  controller: cepController,
                                ),
                                InputField(
                                  label: "Número",
                                  controller: numController,
                                ),
                              ],
                            )
                        ],
                      ),
                    FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueGrey)),
                      onPressed: () async {
                        if (!defineDateTime && !defineAPlace) {
                          if (_checkControllers([
                            titleController,
                            descriptionController,
                          ])) {
                            Task addTask = Task(
                                id: taskListLenght,
                                title: titleController.text,
                                description: descriptionController.text);
                            Navigator.pop(context, addTask);
                          } else {
                            _showToast("Preencher todos os campos");
                          }
                        } else if (defineDateTime && !defineAPlace) {
                          if (_checkControllers([
                            titleController,
                            descriptionController,
                            dateController,
                            timeController
                          ])) {
                            Task addTask = Task(
                                id: taskListLenght,
                                title: titleController.text,
                                description: descriptionController.text,
                                date: dateController.text,
                                time: timeController.text);
                            Navigator.pop(context, addTask);
                          } else {
                            _showToast("Preencher todos os campos");
                          }
                        } else if (!defineDateTime && defineAPlace) {
                          if (useMyLocation) {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                            ])) {
                              Task addTask = Task(
                                  id: taskListLenght,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  lat: lat.toString(),
                                  lon: lon.toString());
                              Navigator.pop(context, addTask);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          } else {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                              cepController,
                              numController
                            ])) {
                              Task addTask = Task(
                                  id: taskListLenght,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  cep: cepController.text,
                                  num: numController.text);
                              Navigator.pop(context, addTask);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          }
                        } else {
                          if (useMyLocation) {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                              dateController,
                              timeController,
                            ])) {
                              Task addTask = Task(
                                id: taskListLenght,
                                title: titleController.text,
                                description: descriptionController.text,
                                date: dateController.text,
                                time: timeController.text,
                                lat: lat.toString(),
                                lon: lon.toString(),
                              );
                              Navigator.pop(context, addTask);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          } else {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                              dateController,
                              timeController,
                              cepController,
                              numController
                            ])) {
                              Task addTask = Task(
                                  id: taskListLenght,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  date: dateController.text,
                                  time: timeController.text,
                                  cep: cepController.text,
                                  num: numController.text);
                              Navigator.pop(context, addTask);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          }
                        }
                      },
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
                    Row(
                      children: [
                        Checkbox(
                            value: defineDateTime,
                            onChanged: (value) {
                              setState(() {
                                defineDateTime = value!;
                              });
                            }),
                        const Text("Definir hora e data")
                      ],
                    ),
                    if (defineDateTime)
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  label: "Data",
                                  controller: dateController,
                                  readOnly: true,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 15, top: 8, bottom: 8),
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: InkWell(
                                    onTap: () async {
                                      final DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: currentDate,
                                              firstDate: DateTime(2015, 8),
                                              lastDate: DateTime(2101));
                                      if (pickedDate != null) {
                                        dateController.text =
                                            formatDate(pickedDate);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Icon(Icons.calendar_month)),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InputField(
                                  label: "Horário",
                                  controller: timeController,
                                  readOnly: true,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    right: 15, top: 8, bottom: 8),
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: InkWell(
                                    onTap: () async {
                                      final TimeOfDay? pickedTime =
                                          await showTimePicker(
                                              context: context,
                                              initialTime: currentTime);
                                      if (pickedTime != null) {
                                        timeController.text =
                                            formatTime(pickedTime);
                                      }
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: const Icon(Icons.access_time)),
                              )
                            ],
                          ),
                        ],
                      ),
                    Row(
                      children: [
                        Checkbox(
                            value: defineAPlace,
                            onChanged: (value) {
                              setState(() {
                                defineAPlace = value!;
                              });
                            }),
                        const Text("Definir um local")
                      ],
                    ),
                    if (defineAPlace)
                      Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: useMyLocation,
                                  onChanged: (value) {
                                    setState(() {
                                      useMyLocation = value!;
                                    });
                                  }),
                              const Text("Usar minha localização")
                            ],
                          ),
                          if (useMyLocation)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'LAT: ${lat.toString()}',
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      'LON: ${lon.toString()}',
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                )
                              ],
                            ),
                          if (!useMyLocation)
                            Column(
                              children: [
                                InputField(
                                  label: "CEP",
                                  controller: cepController,
                                ),
                                InputField(
                                  label: "Número",
                                  controller: numController,
                                ),
                              ],
                            )
                        ],
                      ),
                    FilledButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueGrey)),
                      onPressed: () async {
                        if (!defineDateTime && !defineAPlace) {
                          if (_checkControllers([
                            titleController,
                            descriptionController,
                          ])) {
                            Task updateTask = Task(
                                id: task.id,
                                title: titleController.text,
                                description: descriptionController.text);
                            taskProvider.updateTask(updateTask);
                            Navigator.pop(context);
                          } else {
                            _showToast("Preencher todos os campos");
                          }
                        } else if (defineDateTime && !defineAPlace) {
                          if (_checkControllers([
                            titleController,
                            descriptionController,
                            dateController,
                            timeController
                          ])) {
                            Task updateTask = Task(
                                id: task.id,
                                title: titleController.text,
                                description: descriptionController.text,
                                date: dateController.text,
                                time: timeController.text);
                            taskProvider.updateTask(updateTask);
                            Navigator.pop(context);
                          } else {
                            _showToast("Preencher todos os campos");
                          }
                        } else if (!defineDateTime && defineAPlace) {
                          if (useMyLocation) {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                            ])) {
                              Task updateTask = Task(
                                id: task.id,
                                title: titleController.text,
                                description: descriptionController.text,
                                lat: lat.toString(),
                                lon: lon.toString(),
                              );
                              taskProvider.updateTask(updateTask);
                              Navigator.pop(context);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          } else {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                              cepController,
                              numController
                            ])) {
                              Task updateTask = Task(
                                  id: task.id,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  cep: cepController.text,
                                  num: numController.text);
                              taskProvider.updateTask(updateTask);
                              Navigator.pop(context);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          }
                        } else {
                          if (useMyLocation) {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                              dateController,
                              timeController,
                            ])) {
                              Task updateTask = Task(
                                id: task.id,
                                title: titleController.text,
                                description: descriptionController.text,
                                date: dateController.text,
                                time: timeController.text,
                                lat: lat.toString(),
                                lon: lon.toString(),
                              );
                              taskProvider.updateTask(updateTask);
                              Navigator.pop(context);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          } else {
                            if (_checkControllers([
                              titleController,
                              descriptionController,
                              dateController,
                              timeController,
                              cepController,
                              numController
                            ])) {
                              Task updateTask = Task(
                                  id: task.id,
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  date: dateController.text,
                                  time: timeController.text,
                                  cep: cepController.text,
                                  num: numController.text);
                              taskProvider.updateTask(updateTask);
                              Navigator.pop(context);
                            } else {
                              _showToast("Preencher todos os campos");
                            }
                          }
                        }
                      },
                      child: const Text("Salvar"),
                    ),
                  ],
                )
            ],
          ),
        ));
  }

  String formatDate(DateTime date) {
    String day = '';
    String month = '';
    String year = date.year.toString();
    int dayInt = date.day;
    int monthInt = date.month;
    if (dayInt < 10) {
      day = '0$dayInt';
    } else {
      day = dayInt.toString();
    }
    if (monthInt < 10) {
      month = '0$monthInt';
    } else {
      month = monthInt.toString();
    }
    return '$day/$month/$year';
  }

  String formatTime(TimeOfDay time) {
    String min = '';
    String hour = '';
    int minInt = time.minute;
    int hourInt = time.hour;
    if (minInt < 10) {
      min = '0$minInt';
    } else {
      min = minInt.toString();
    }
    if (hourInt < 10) {
      hour = '0$hourInt';
    } else {
      hour = hourInt.toString();
    }
    return '$hour:$min';
  }

  Future<Position> _getposition() async {
    LocationPermission permission;
    bool active = await Geolocator.isLocationServiceEnabled();

    if (!active) {
      return Future.error('Por favor, habilite a localização no samrtphone');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso a localização');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso a localização');
    }

    return await Geolocator.getCurrentPosition();
  }

  void getPosition() async {
    try {
      _showToast('Obtendo Localização');
      Position myPosition = await _getposition();
      setState(() {
        lat = myPosition.latitude;
        lon = myPosition.longitude;
      });
    } catch (e) {}
  }

  bool _checkControllers(List<TextEditingController> controllers) {
    for (TextEditingController controller in controllers) {
      if (controller.text.isEmpty) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
