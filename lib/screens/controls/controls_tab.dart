import 'package:cas_tsyp_app/helpers/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/smart_home_controller.dart';

class ControlsTab extends StatelessWidget {
  final controller = Get.find<SmartHomeController>();

  ControlsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Status Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('System Status',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 8),
                _buildStatusRow('Temperature',
                    '${controller.status.value['environment']?['temperature']}°C', Icons.thermostat),
                _buildStatusRow('Humidity',
                    '${controller.status.value['environment']?['humidity']}%', Icons.water),
                _buildStatusRow('AC',
                    controller.status.value['environment']?['fan_running'] == true
                        ? 'Running'
                        : 'Off', Icons.ac_unit),
              ],
            ),
          ),
        ),

        // Doors Control Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Doors Control',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            controller.sendCommand('SET GARAGE OPEN'),
                        child: const Text('Open Garage'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          controller.sendCommand('SET GARAGE CLOSE'),
                          NotificationService().showFireNotification(),
                        },
                        child: const Text('Close Garage'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            controller.sendCommand('SET FRONTDOOR OPEN'),
                        child: const Text('Open Front Door'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            controller.sendCommand('SET FRONTDOOR CLOSE'),
                        child: const Text('Close Front Door'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Lights Control Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lights Control',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 16),
                _buildLightControls('Room'),
                const SizedBox(height: 16),
                _buildLightControls('Toilet'),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildStatusRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildLightControls(String location) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$location Light'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.sendCommand(
                    'SET PAUSE $location DURATION=3600000 STATE=UP'),
                child: const Text('Force ON (1h)'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => controller.sendCommand(
                    'SET PAUSE $location DURATION=3600000 STATE=DOWN'),
                child: const Text('Force OFF (1h)'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
