import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todyapp/core/constants/images_app.dart';

import '../../../../core/constants/styles_app.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              RichText(
                text: TextSpan(
                  text: "Welcome to",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: StylesApp.colorDefaultText,
                  ),
                  children: [
                    TextSpan(
                      text: " Todyapp",
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: StylesApp.textButtonFontWeight,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              //SizedBox(height: 32.0),
              Image.asset(ImagesApp.phone3),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  onPressed: () => context.go('/login-email'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, size: 24.0),
                      SizedBox(width: 8.0),
                      Text("Continue with email"),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      height: 1.0,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                  ),
                  Text(
                    "or continue with",
                    style: TextStyle(color: StylesApp.greyText),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      height: 1.0,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagesApp.iconFacebook,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "Facebook",
                            style: TextStyle(color: StylesApp.colorDefaultText),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImagesApp.iconGoogle,
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            "Apple",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
