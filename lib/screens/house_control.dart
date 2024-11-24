import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/smart_home_controller.dart';
import 'controls/charts_tab.dart';
import 'controls/controls_tab.dart';
import 'controls/settings_tab.dart';

class ControlTabBar extends StatelessWidget {
  final controller = Get.put(SmartHomeController());
  ControlTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Home Control'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Controls'),
              Tab(icon: Icon(Icons.show_chart), text: 'Charts'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ControlsTab(),
            ChartsTab(),
            SettingsTab(),
          ],
        ),
      ),
    );
  }
}