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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('System Status'),
      ),
      body:  SingleChildScrollView(
        child: Column(
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
            child: Center(child: Text('Source Of energy: $energySource',style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),)),
          ),
          const HouseBatteryStatus(percentage: 70),
          CarBatteryStatus(batteryPercentage: 70,totalDistance: 2000,)
        ],),
      ),
    );
  }
}