import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final String hintText;
  final bool readOnly;
  final bool canRequestFocus;
  const TextFieldWidget({
    this.labelText = "",
    required this.textEditingController,
    this.hintText = "",
    this.readOnly = false,
    this.canRequestFocus = true,
    super.key,
  });

  Widget withLabel() {
    return labelText.isEmpty
        ? SizedBox.shrink()
        : Builder(
            builder: (context) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      labelText,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              );
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        withLabel(),
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(hintText: hintText),
          readOnly: readOnly,
          canRequestFocus: canRequestFocus,
        ),
      ],
    );
  }
}
