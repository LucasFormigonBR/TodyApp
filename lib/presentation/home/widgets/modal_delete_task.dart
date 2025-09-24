import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/common/bloc/task/task_cubit.dart';

import '../../../domain/entities/task.dart';

class ModalDeleteTask extends StatelessWidget {
  final TaskCubit taskCubit;
  final Task task;
  const ModalDeleteTask({
    required this.taskCubit,
    required this.task,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text("Excluindo Tarefa"),
                  subtitle: Text("Tem certeza que deseja excluir a tarefa?"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await taskCubit.removeTasks([task]);
                      if (context.mounted) context.pop();
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text("Excluir"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Cancelar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
