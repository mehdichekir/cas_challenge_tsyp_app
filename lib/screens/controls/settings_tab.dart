
// Settings Tab
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/smart_home_controller.dart';

class SettingsTab extends StatelessWidget {
  final controller = Get.find<SmartHomeController>();

  SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            title: const Text('Connection Status'),
            trailing: Obx(() => Text(
                controller.isConnected.value ? 'Connected' : 'Disconnected')),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Reconnect to Server'),
            trailing: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                controller.connectToServer();
              },
            ),
          ),
        ),
      ],
    );
  }
}