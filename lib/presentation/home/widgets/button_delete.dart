import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/common/bloc/task/task_cubit.dart';
import 'package:todyapp/presentation/home/cubit/mode_checkbox_cubit.dart';
import 'package:todyapp/presentation/home/cubit/task_selection_cubit.dart';

import '../cubit/button_cubit.dart';
import '../cubit/button_state.dart';

class ButtonDelete extends StatelessWidget {
  final TaskCubit taskCubit;
  final ButtonCubit buttonCubit;
  final TaskSelectionCubit taskSelectionCubit;
  final ModeCheckboxCubit modeCheckboxCubit;
  const ButtonDelete({
    super.key,
    required this.taskCubit,
    required this.buttonCubit,
    required this.taskSelectionCubit,
    required this.modeCheckboxCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonCubit, ButtonState>(
      builder: (context, buttonState) {
        if (buttonState is ButtonInitial) {
          return IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            style: IconButton.styleFrom(
              backgroundColor: Colors.red.withValues(alpha: 0.3),
            ),
            onPressed: () {},
          );
        }

        if (buttonState is ButtonToggleDeleteTasks) {
          return IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            style: buttonState.isActive
                ? IconButton.styleFrom(backgroundColor: Colors.red)
                : IconButton.styleFrom(
                    backgroundColor: Colors.red.withValues(alpha: 0.3),
                  ),
            onPressed: buttonState.isActive
                ? () async {
                    await taskCubit.removeTasks(taskSelectionCubit.tasks);
                    taskSelectionCubit.clearSelectionList();
                    buttonCubit.updateToggleButtonDeleteTasks(
                      taskSelectionCubit.tasks.isNotEmpty,
                    );

                    modeCheckboxCubit.updateCheckboxMode();
                  }
                : () {},
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
