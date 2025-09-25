import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBarWidget extends AppBar {
  AppBarWidget({super.key, super.title})
    : super(
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return Visibility(
              visible: context.canPop(),
              child: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(Icons.arrow_back_ios_new),
              ),
            );
          },
        ),
      );
}
