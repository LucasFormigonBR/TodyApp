import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/task.dart';
import '../cubit/button_cubit.dart';
import '../cubit/task_selection_cubit.dart';
import '../cubit/task_selection_state.dart';

class CheckboxTask extends StatelessWidget {
  final Task task;
  const CheckboxTask({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskSelectionCubit, TaskSelectionState>(
      builder: (context, taskSelection) {
        if (taskSelection is TaskSelectionUpdate) {
          return Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            value: taskSelection.selectedTasks.contains(task),
            onChanged: (isChecked) {
              final taskSelectionCubit = context.read<TaskSelectionCubit>();
              final buttonCubit = context.read<ButtonCubit>();

              taskSelectionCubit.addOrRemoveCheck(task);
              buttonCubit.updateToggleButtonDeleteTasks(
                taskSelectionCubit.tasks.isNotEmpty,
              );
            },
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
