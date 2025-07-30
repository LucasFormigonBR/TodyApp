import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/features/home/domain/entities/task.dart';
import 'package:todyapp/features/home/presentation/cubit/mode_checkbox_cubit.dart';
import 'package:todyapp/features/home/presentation/cubit/mode_checkbox_state.dart';
import 'package:todyapp/features/home/presentation/widgets/checkbox_task.dart';
import 'package:todyapp/features/home/presentation/widgets/modal_task.dart';

import '../ui_models/ui_priority.dart';

import 'more_options.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  const TaskWidget({super.key, required this.task});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController titleTaskController = TextEditingController();
  final TextEditingController descriptionTaskController =
      TextEditingController();
  final List<UiPriority> priorities = UiPriority.values;

  @override
  void dispose() {
    titleTaskController.dispose();
    descriptionTaskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            color: widget.task.priority.color,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                spacing: 5,
                children: [
                  Icon(Icons.flag_outlined, color: Colors.white),
                  Text(
                    widget.task.priority.label,
                    style: TextStyle(color: Colors.white),
                  ),
                  Spacer(),
                  MoreOptions(
                    task: widget.task,
                    onPressed: () => showModalEditTask(widget.task),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      BlocBuilder<ModeCheckboxCubit, ModeCheckboxState>(
                        builder: (context, modeCheckbox) {
                          if (modeCheckbox is ModeCheckboxUpdate) {
                            return modeCheckbox.activate
                                ? CheckboxTask(task: widget.task)
                                : SizedBox.shrink();
                          }

                          return SizedBox.shrink();
                        },
                      ),

                      Text(
                        widget.task.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        size: 16,
                        color: Colors.red,
                      ),
                      Text(
                        widget.task.hours,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: Theme.of(
                            context,
                          ).textTheme.labelSmall?.fontSize,
                        ),
                      ),
                      Spacer(),
                      Text(
                        widget.task.date,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showModalOptionsTask(Task task) async {
    return await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Editar"),
                onTap: () {
                  Navigator.of(context).pop();
                  showModalEditTask(task);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showModalEditTask(Task task) async {
    titleTaskController.text = task.title;
    descriptionTaskController.text = task.description;

    showModalBottomSheet(
      context: context,
      builder: (contextModal) =>
          ModalTask(contextModal: contextModal, isNewTask: false, task: task),
    );
  }
}
