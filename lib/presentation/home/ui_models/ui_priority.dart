import 'package:flutter/material.dart';

enum UiPriority {
  high("Alta", Colors.red, "❗", 3),
  medium("Média", Colors.orange, "💪", 2),
  low("Baixa", Colors.blue, "👌", 1),
  none("Nenhuma", Colors.grey, "✌️", 0);

  final String label;
  final Color color;
  final String emoji;
  final int value;

  const UiPriority(this.label, this.color, this.emoji, this.value);
}
