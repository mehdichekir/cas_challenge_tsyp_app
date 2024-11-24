import 'package:cas_tsyp_app/widgets/energy-meter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RealTimeVisLineChart extends StatelessWidget {
  const RealTimeVisLineChart({super.key});

  @override
  Widget build(BuildContext context) {
  var EnergyProducedList=[FlSpot(0,150),FlSpot(10,150),FlSpot(15,100),FlSpot(20,50),FlSpot(25,100),FlSpot(30,190)];
  double totalEnergyProduced = EnergyProducedList.fold(0, (sum, spot) => sum + spot.y);
  var EnergyConsumedList=[FlSpot(0,100 ),FlSpot(10,100),FlSpot(15,70),FlSpot(20,30),FlSpot(25,90),FlSpot(30,150)];
  double totalEnergyConsumed = EnergyConsumedList.fold(0, (sum, spot) => sum + spot.y);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20,left: 20,top: 20,bottom: 10),
            height: 350,
            width: 500,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 0,bottom: 0,right: 30),
                  height: 300,
                  width: double.infinity,
                  child: LineChart(
                    LineChartData(
                      minX: 0,
                      maxX: 30,
                      minY: 0,
                      maxY: 200,
                      titlesData: const FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30
                          ),
                          axisNameSize: 50
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,reservedSize: 35
                          ),
                          axisNameSize: 30
                        ),
                        topTitles: AxisTitles(
                          axisNameWidget: Text('Your Energy Balance',),
                          axisNameSize: 70
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: false
                          )
                        )
                        ),
                      gridData: FlGridData(
                        getDrawingHorizontalLine: (value) {
                          return const FlLine(
                            color: Colors.grey,
                            strokeWidth: 1
                          );
                        },
                        drawVerticalLine: false
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: Colors.grey,width: 1)
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          spots: EnergyProducedList,
                          color: Colors.lightGreen,
                          barWidth: 5,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.lightGreen
                          )
                        ),
                        LineChartBarData(
                          isCurved: true,
                          spots: EnergyConsumedList,
                          color: Colors.red,
                          barWidth: 5,
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.red
                          )
                        ),
                        
                      ]
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Text('Production'),
                    const SizedBox(width: 50,),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red
                      ),
                    ),
                    const SizedBox(width: 10,),
                    const Text('Consumtion')
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(50),
            child: DifferenceMeter(value1: totalEnergyProduced, value2: totalEnergyConsumed))
        ],
      ),
    );
  }
}