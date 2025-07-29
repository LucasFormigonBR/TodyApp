import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todyapp/features/home/presentation/cubit/mode_checkbox_cubit.dart';
import 'package:todyapp/features/home/presentation/cubit/mode_checkbox_state.dart';

import '../../domain/entities/task.dart';

class MoreOptions extends StatelessWidget {
  final Task task;
  final VoidCallback onPressed;
  const MoreOptions({super.key, required this.task, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModeCheckboxCubit, ModeCheckboxState>(
      builder: (context, state) {
        if (state is ModeCheckboxUpdate) {
          return IconButton(
            icon: Icon(
              Icons.more_horiz_outlined,
              color: state.activate ? Colors.transparent : Colors.white,
            ),
            onPressed: state.activate ? null : onPressed,
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}
