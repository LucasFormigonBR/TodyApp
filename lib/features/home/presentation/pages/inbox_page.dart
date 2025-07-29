import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/features/home/presentation/cubit/mode_checkbox_cubit.dart';
import 'package:todyapp/features/home/presentation/cubit/mode_checkbox_state.dart';
import 'package:todyapp/features/home/presentation/cubit/task_state.dart';
import 'package:todyapp/features/home/presentation/ui_models/ui_priority.dart';
import 'package:todyapp/features/home/presentation/widgets/animation_selected_task.dart';
import 'package:todyapp/features/home/presentation/widgets/modal_task.dart';
import 'package:todyapp/features/home/presentation/widgets/button_select_all.dart';
import 'package:todyapp/features/home/presentation/widgets/task_widget.dart';
import 'package:todyapp/features/widgets/padding_widget.dart';

import '../../domain/entities/task.dart';
import '../cubit/button_cubit.dart';
import '../cubit/list_task_cubit.dart';
import '../cubit/task_selection_cubit.dart';
import '../widgets/button_add_task.dart';
import '../widgets/button_delete.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ModeCheckboxCubit()),
        BlocProvider(create: (context) => TaskSelectionCubit()),
        BlocProvider(create: (context) => ButtonCubit()),
      ],
      child: Builder(
        builder: (context) {
          final listTaskCubit = context.read<ListTaskCubit>();
          final buttonCubit = context.read<ButtonCubit>();
          final taskSelectionCubit = context.read<TaskSelectionCubit>();
          final modeCheckboxCubit = context.read<ModeCheckboxCubit>();

          return SafeArea(
            child: PaddingWidget(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hoje", style: Theme.of(context).textTheme.titleLarge),
                  SizedBox(height: 8),
                  Text(
                    "Verifique as tarefas a fazer no momento",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: BlocBuilder<ModeCheckboxCubit, ModeCheckboxState>(
                      builder: (context, modeCheckboxState) {
                        if (modeCheckboxState is ModeCheckboxUpdate) {
                          if (modeCheckboxState.activate) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              spacing: 5,
                              children: [
                                ButtonSelectAll(
                                  onPressed: () {
                                    taskSelectionCubit.selectAllTasks(
                                      listTaskCubit.tasks,
                                    );
                                    buttonCubit.updateToggleButtonDeleteTasks(
                                      taskSelectionCubit.tasks.isNotEmpty,
                                    );
                                  },
                                ),
                                ButtonDelete(
                                  buttonCubit: buttonCubit,
                                  modeCheckboxCubit: modeCheckboxCubit,
                                  listTaskCubit: listTaskCubit,
                                  taskSelectionCubit: taskSelectionCubit,
                                ),
                              ],
                            );
                          }
                          taskSelectionCubit.clearSelectionList();
                          return ButtonAddTask(
                            onPressed: () async {
                              await showModalCreateNewTask();
                              titleTaskController.clear();
                              descriptionTaskController.clear();
                            },
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                  SizedBox(height: 40),
                  BlocBuilder<ListTaskCubit, TaskState>(
                    builder: (context, state) {
                      if (state is TasksInitial) {
                        return Expanded(
                          child: Center(
                            child: Text('Nenhuma tarefa para hoje!'),
                          ),
                        );
                      }

                      if (state is TasksLoading) {
                        return Expanded(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state is TasksLoaded) {
                        if (state.tasks.isEmpty) {
                          return Expanded(
                            child: Center(
                              child: Text('Nenhuma tarefa para hoje!'),
                            ),
                          );
                        }
                        return Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                            itemCount: state.tasks.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onLongPress: () =>
                                    modeCheckboxCubit.updateCheckboxMode(),
                                child: Ink(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: AnimationSelectedTask(
                                    task: state.tasks[index],
                                    widget: TaskWidget(
                                      task: state.tasks[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }

                      if (state is TasksError) {
                        return Expanded(
                          child: Center(
                            child: Text("Houve um erro: //${state.message}"),
                          ),
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> showModalCreateNewTask() async {
    Task newTask = Task();

    await showModalBottomSheet(
      context: context,
      builder: (contextModal) =>
          ModalTask(contextModal: contextModal, task: newTask, isNewTask: true),
    );
  }
}
