import 'package:deart/controllers/login_controller.dart';
import 'package:deart/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TokenLoginScreen extends GetView<LoginController> {
  const TokenLoginScreen({Key? key}) : super(key: key);

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "This is required.";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GetX<LoginController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            controller.loginWithTokenTitle.value,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Paste your tokens here. We'
                    'll refresh them for you whenever needed',
                    style: Get.theme.textTheme.bodyText1,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      suffix: ElevatedButton(
                        child: const Text('Paste'),
                        onPressed: () async {
                          ClipboardData? data =
                              await Clipboard.getData('text/plain');
                          if (data != null) {
                            controller.accessTokenController.text =
                                data.text.toString();
                          }
                        },
                      ),
                      labelText: 'Access Token',
                      hintText: 'Paste your access token here.',
                    ),
                    controller: controller.accessTokenController,
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Access Token is required!';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      suffix: ElevatedButton(
                        child: const Text('Paste'),
                        onPressed: () async {
                          ClipboardData? data =
                              await Clipboard.getData('text/plain');
                          if (data != null) {
                            controller.refreshTokenController.text =
                                data.text.toString();
                          }
                        },
                      ),
                      labelText: 'Refresh Token',
                      hintText: 'Paste your refresh token here.',
                    ),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return 'Refresh Token is required!';
                      }
                      return null;
                    },
                    controller: controller.refreshTokenController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.formKey.currentState!.validate()) {
                          Get.back();
                          Get.snackbar(
                            'Tokens saved successfully',
                            'Logging you in...',
                            snackPosition: SnackPosition.BOTTOM,
                            isDismissible: true,
                          );
                          if (await Get.find<AuthService>().performChangeToken(
                            controller.accessTokenController,
                            controller.refreshTokenController,
                          )) {
                            Get.offAllNamed('/home');
                          }
                        }
                      },
                      child: const Text('Save'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}