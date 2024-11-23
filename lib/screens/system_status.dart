import 'package:cas_tsyp_app/screens/energy_dashboard.dart';
import 'package:cas_tsyp_app/screens/energy_history.dart';
import 'package:cas_tsyp_app/screens/real_time_visualtion.dart';
import 'package:cas_tsyp_app/widgets/car_battery_status.dart';
import 'package:cas_tsyp_app/widgets/house_battery_status.dart';
import 'package:flutter/material.dart';

class SystemStatus extends StatefulWidget {
  static const routeName='/System_status';
  const SystemStatus({super.key,});

  @override
  State<SystemStatus> createState() => _SystemStatusState();
}

class _SystemStatusState extends State<SystemStatus> {
  final String energySource='Solar panel ';
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
        title: const Text('System Status'),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
       const SizedBox(height: 20),
        Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 0,horizontal: 25),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green
          ),
          child: Center(child: Text('Source Of energie: $energySource',style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),)),
        ),
        const HouseBatteryStatus(percentage: 70),
        CarBatteryStatus(batteryPercentage: 70,totalDistance: 2000,)
      ],),
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