import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/common/bloc/task/task_cubit.dart';
import 'package:todyapp/common/bloc/task/task_state.dart';
import 'package:todyapp/core/configs/constants/filters.dart';

class FilterModalWidget extends StatefulWidget {
  const FilterModalWidget({super.key});

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  FilterTask? filters;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Filtrar por",
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      content: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: RadioGroup(
              groupValue: filters,
              onChanged: (value) {
                filters = value ?? FilterTask.data;
                context.read<TaskCubit>().selectFilterTask(filters!);
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    title: Text("Titulo"),
                    value: FilterTask.titulo,
                  ),
                  RadioListTile(title: Text("Data"), value: FilterTask.data),
                  RadioListTile(title: Text("Hora"), value: FilterTask.hora),
                ],
              ),
            ),
          );
        },
      ),
      actions: [
        TextButton(
          child: Text("Confirmar", textAlign: TextAlign.start),
          onPressed: () {},
        ),
        TextButton(
          child: Text("Cancelar", textAlign: TextAlign.end),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}
