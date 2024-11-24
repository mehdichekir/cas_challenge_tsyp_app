import 'package:cas_tsyp_app/widgets/line_chart_real_time.dart';
import 'package:flutter/material.dart';

class RealTimeVisualization extends StatefulWidget {
  static const routeName='/Real_Time_Visualisation';
  const RealTimeVisualization({super.key});

  @override
  State<RealTimeVisualization> createState() => _RealTimeVisualizationState();
}

class _RealTimeVisualizationState extends State<RealTimeVisualization> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Real Time Data Visualization'),
      ),
      body: const RealTimeVisLineChart(),
    );
  }
}