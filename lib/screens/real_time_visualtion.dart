import 'package:cas_tsyp_app/screens/energy_dashboard.dart';
import 'package:cas_tsyp_app/screens/energy_history.dart';
import 'package:cas_tsyp_app/screens/system_status.dart';
import 'package:cas_tsyp_app/widgets/line_chart_real_time.dart';
import 'package:flutter/material.dart';

class RealTimeVisualtion extends StatefulWidget {
  static const routeName='/Real_Time_Visualisation';
  const RealTimeVisualtion({super.key});

  @override
  State<RealTimeVisualtion> createState() => _RealTimeVisualtionState();
}

class _RealTimeVisualtionState extends State<RealTimeVisualtion> {

  void _changeScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RealTimeVisualtion()),
        );
        break;
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SystemStatus()),
        );
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const EnergyHistory()),
        );
        break;
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const EnergyDashboard()),
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Real Time Data Visulation'),
      ),
      body: RealTimeVisLineChart(),
      bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: ' Visualisation',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time_outlined),
                label: ' Status',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outlined),
                label: ' History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                label: ' Dashboard',
              ),
            ],
            selectedItemColor: Colors.green.shade700,
            unselectedItemColor: Colors.grey.shade600,
            backgroundColor: Colors.transparent,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: (index)=>_changeScreen(context,index),
          ),
    );
  }
}