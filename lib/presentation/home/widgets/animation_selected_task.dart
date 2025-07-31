import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/task.dart';
import '../cubit/task_selection_cubit.dart';
import '../cubit/task_selection_state.dart';

class AnimationSelectedTask extends StatelessWidget {
  final Task task;
  final Widget widget;
  const AnimationSelectedTask({
    super.key,
    required this.task,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskSelectionCubit, TaskSelectionState>(
      builder: (context, taskSelection) {
        if (taskSelection is TaskSelectionUpdate) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              boxShadow: taskSelection.selectedTasks.contains(task)
                  ? [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.5),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
              border: Border.all(
                color: taskSelection.selectedTasks.contains(task)
                    ? Colors.red
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: widget,
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
