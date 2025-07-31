import 'package:flutter/material.dart';

class ButtonAddTask extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonAddTask({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      shape: CircleBorder(),
      elevation: 4,
      borderOnForeground: false,
      child: IconButton(
        icon: Icon(Icons.add_task_rounded, color: Colors.white),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
