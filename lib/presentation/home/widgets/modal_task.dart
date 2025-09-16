import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:todyapp/common/bloc/task/task_cubit.dart';

import '../../../core/configs/theme/styles_app.dart';
import '../../../domain/entities/task.dart';
import '../cubit/button_cubit.dart';
import '../cubit/button_state.dart';
import '../ui_models/ui_priority.dart';

class ModalTask extends StatefulWidget {
  final Task task;
  final bool isNewTask;
  final BuildContext contextModal;

  const ModalTask({
    super.key,
    required this.task,
    required this.contextModal,
    required this.isNewTask,
  });

  @override
  State<ModalTask> createState() => _ModalTaskState();
}

class _ModalTaskState extends State<ModalTask> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();
  final List<UiPriority> priorities = UiPriority.values;
  late Task newTask;

  @override
  void initState() {
    super.initState();
    titleTaskController.clear();
    descriptionTaskController.clear();
    titleTaskController.text = widget.task.title;
    descriptionTaskController.text = widget.task.description;
    newTask = widget.task;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ButtonCubit(),
      child: Builder(
        builder: (builderContext) {
          final buttonCubit = BlocProvider.of<ButtonCubit>(builderContext);

          if (titleTaskController.text.isNotEmpty) {
            buttonCubit.updateToggleButtonSend(true);
          }

          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(widget.contextModal).viewInsets.bottom,
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: titleTaskController,
                    decoration: InputDecoration(
                      hintText: "Titulo da tarefa",
                      focusColor: Colors.red,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.trim().isEmpty) {
                        buttonCubit.updateToggleButtonSend(false);
                        return;
                      }
                      buttonCubit.updateToggleButtonSend(true);
                    },
                    validator: (value) =>
                        value!.isEmpty ? "O título não pode ser vazio" : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: descriptionTaskController,
                    decoration: InputDecoration(
                      hintText: "Descrição",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 5,
                    children: [
                      IconButton(
                        onPressed: () async => newTask = newTask.copyWith(
                          date: await chooseDate(newTask.date),
                        ),
                        icon: Icon(Icons.calendar_month_sharp),
                      ),
                      IconButton(
                        onPressed: () async => newTask = newTask.copyWith(
                          hours: await chooseHorary(newTask.hours),
                        ),
                        icon: Icon(Icons.access_time_filled_sharp),
                      ),
                      IconButton(
                        onPressed: () async => newTask = newTask.copyWith(
                          priority: await choosePriority(newTask.priority),
                        ),

                        icon: Icon(Icons.flag_rounded),
                      ),
                      Spacer(),
                      BlocBuilder<ButtonCubit, ButtonState>(
                        builder: (context, state) {
                          if (state is ButtonToggleSendTask) {
                            return IconButton(
                              icon: Icon(Icons.send),
                              color: Theme.of(context).colorScheme.primary,
                              onPressed: state.isActive
                                  ? () async {
                                      if (formKey.currentState!.validate()) {
                                        final taskCubit = context
                                            .read<TaskCubit>();

                                        newTask = newTask.copyWith(
                                          title: titleTaskController.text,
                                          description:
                                              descriptionTaskController.text,
                                        );

                                        if (widget.isNewTask) {
                                          await taskCubit.addTask(newTask);
                                          if (context.mounted) {
                                            context.pop();
                                            return;
                                          }
                                        }
                                        await taskCubit.editTask(newTask);
                                        if (context.mounted) context.pop();
                                      }
                                    }
                                  : null,
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<String> chooseDate(String dateTask) async {
    DateTime initialDate = DateTime.now();

    if (dateTask.isNotEmpty) {
      DateFormat dateFormat = DateFormat("dd/MM/yyyy");
      initialDate = dateFormat.parse(dateTask);
    }

    DateTime? chosenDate = await showDatePicker(
      confirmText: "Confirmar",
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (chosenDate == null) return dateTask;

    final date = DateFormat('dd/MM/yyyy').format(chosenDate);

    return date;
  }

  Future<String> chooseHorary(String hourTask) async {
    TimeOfDay initialTime = TimeOfDay.now();

    if (hourTask.isNotEmpty) {
      final parts = hourTask.split("h");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      initialTime = TimeOfDay(hour: hour, minute: minute);
    }

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: initialTime,
      helpText: "Escolha o horário",
      cancelText: "Cancelar",
      confirmText: "Confirmar",
    );

    if (time == null) return hourTask;

    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

    return "${hours}h$minutes";
  }

  Future<UiPriority> choosePriority(UiPriority priorityTask) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: priorities.length,
              itemBuilder: (context, index) {
                final priority = priorities[index];
                final selected = priorityTask.value == priority.value;
                return ListTile(
                  selected: selected,
                  selectedTileColor: StylesApp.greySelectedBackground,
                  leading: Text(priority.emoji, style: TextStyle(fontSize: 20)),
                  title: Text(
                    priority.label,
                    style: TextStyle(color: priority.color),
                  ),
                  onTap: () => context.pop(priority),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
