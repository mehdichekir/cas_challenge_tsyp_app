import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../helpers/smart_home_controller.dart';
import 'package:cas_tsyp_app/screens/visuals/energy_dashboard.dart';
import 'package:cas_tsyp_app/screens/visuals/real_time_visualization.dart';
import 'package:cas_tsyp_app/screens/visuals/system_status.dart';
import 'package:cas_tsyp_app/screens/visuals/energy_history.dart';

class VisualizationTabBar extends StatelessWidget {
  final controller = Get.put(SmartHomeController());
  VisualizationTabBar({super.key});

  final tabNames = [
    "Energy Dashboard",
    "Real Time Visualization",
    "System Status",
    "Energy History",
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: null, // Set title to null to avoid default behavior
          flexibleSpace: const Center(
            child: Text(
              "House Energy Visualization",
              textAlign: TextAlign.center, // Center text alignment
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dashboard
                ,color: Colors.green,), child: Text('Dashboard',style: TextStyle(color: Colors.green, fontSize: 11.5),),),
              Tab(icon: Icon(Icons.account_balance_wallet
                ,color: Colors.green,), child: Text('Balance',style: TextStyle(color: Colors.green, fontSize: 11.5),),),
              Tab(icon: Icon(Icons.query_stats_outlined
                ,color: Colors.green,), child: Text('Status',style: TextStyle(color: Colors.green, fontSize: 11.5),),),
              Tab(icon: Icon(Icons.history
                ,color: Colors.green,), child: Text('History',style: TextStyle(color: Colors.green, fontSize: 11.5),),),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EnergyDashboard(),
            RealTimeVisualization(),
            SystemStatus(),
            EnergyHistory(),
          ],
        ),
      ),
    );
  }
}