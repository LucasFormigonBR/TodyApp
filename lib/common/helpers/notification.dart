import 'package:flashy_flushbar/flashy_flushbar_widget.dart';
import 'package:flutter/material.dart';

class NotificationHelper {
  static getAlertNotification(String message, {required Color color}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (message) {
        case "Usuário já autenticado.":
          color = Colors.orange;
          break;
        case "Link inválido ou expirado.":
          color = Colors.red;
        case "Autenticação realizada com sucesso.":
          color = Colors.green;
        default:
      }

      if (message.isNotEmpty) {
        FlashyFlushbar(
          backgroundColor: color,
          messageStyle: TextStyle(color: Colors.white, fontSize: 16),
          leadingWidget: const Icon(Icons.email, color: Colors.white, size: 24),
          message: message,
          duration: const Duration(seconds: 5),
          trailingWidget: IconButton(
            icon: const Icon(Icons.close, color: Colors.white, size: 24),
            onPressed: () => FlashyFlushbar.cancel(),
          ),
          isDismissible: false,
        ).show();
      }
    });
  }
}
