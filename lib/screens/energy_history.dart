import 'package:cas_tsyp_app/widgets/line_chart_history.dart';
import 'package:flutter/material.dart';

class EnergyHistory extends StatefulWidget {
  static const routeName='/Energy_History';
  const EnergyHistory({super.key});

  @override
  State<EnergyHistory> createState() => _EnergyHistoryState();
}

class _EnergyHistoryState extends State<EnergyHistory> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50,),
          EnergyHistoryLineChart(),
        ],
      ),
    );
  }
}