import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // tela principal
        if (isLoading) ...[
          // camada semi-transparente
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // fundo escuro transparente
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ],
    );
  }
}
