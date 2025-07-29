import 'package:flutter/material.dart';

class ButtonSelectAll extends StatelessWidget {
  final VoidCallback onPressed;
  const ButtonSelectAll({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "Selecionar todos",
      icon: Icon(Icons.done_all_rounded, color: Colors.white),
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      onPressed: onPressed,
    );
  }
}
