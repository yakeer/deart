import 'package:deart/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: SettingsList(
          contentPadding: const EdgeInsets.all(8),
          backgroundColor: Get.theme.backgroundColor,
          sections: [
            SettingsSection(
              title: 'General',
              tiles: [
                SettingsTile.switchTile(
                  title: 'Wake up',
                  leading: const Icon(Icons.nights_stay_outlined),
                  switchValue: controller.wakeUp.value,
                  onToggle: (bool value) {},
                ),
              ],
            ),
            SettingsSection(
              title: 'Account',
              tiles: [
                SettingsTile(
                  title: 'Logout',
                  onPressed: (context) => controller.logout(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}