import 'package:flutter/material.dart';
import 'package:todyapp/common/widgets/padding_widget.dart';
import 'package:todyapp/common/widgets/textfield_widget.dart';
import 'package:todyapp/core/configs/app_config.dart';

import '../../../common/widgets/appbar_widget.dart';
import '../../../core/service_locator.dart';

class AccountPage extends StatelessWidget {
  AccountPage({super.key});

  final appConfig = sl<AppConfig>();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: appConfig.name);
    final emailController = TextEditingController(text: appConfig.uid);

    return Scaffold(
      appBar: AppBarWidget(title: Text('Conta')),
      body: PaddingWidget(
        child: Column(
          children: [
            TextFieldWidget(
              labelText: "UID",
              textEditingController: emailController,
              canRequestFocus: false,
              readOnly: true,
            ),
            SizedBox(height: 16),
            TextFieldWidget(
              labelText: "Nome",
              textEditingController: nameController,
              canRequestFocus: false,
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }
}
