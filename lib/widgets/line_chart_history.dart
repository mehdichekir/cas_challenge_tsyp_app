import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EnergyHistoryLineChart extends StatelessWidget {
  const EnergyHistoryLineChart({super.key});

  @override
  Widget build(BuildContext context) {
   
    var energyHistoryList = [
      FlSpot(0, 50),
      FlSpot(1, 100),
      FlSpot(2, 75),
      FlSpot(3, 170),
      FlSpot(4, 130),
      FlSpot(5, 100),
    ];

    
    List<String> dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    double highestProduction =
        energyHistoryList.map((spot) => spot.y).reduce((a, b) => a > b ? a : b);
    double todayProduction = energyHistoryList.last.y;
    double dailyAverage = energyHistoryList.map((spot) => spot.y).reduce((a, b) => a + b) / energyHistoryList.length;
    String dailyAverageCleaned = dailyAverage.toStringAsFixed(2);
    
  

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(16),
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: LineChart(
            LineChartData(
              minX: 0,
              maxX: energyHistoryList.length - 1,
              minY: 0,
              maxY: 200,
              titlesData: FlTitlesData(
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 &&
                          index < dayLabels.length &&
                          value == index.toDouble()) {
                        return Text(
                          dayLabels[index],
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 45,
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()} W');
                    },
                  ),
                ),
                bottomTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                getDrawingVerticalLine: (value) {
                  int index = value.toInt();
                  if (index >= 0 && index < energyHistoryList.length) {

                    return FlLine(
                      color: Colors.grey.shade400,
                      strokeWidth: 1,
                    );
                  }
                  return FlLine(color: Colors.transparent);
                },
                drawHorizontalLine:
                    false, 
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  spots: energyHistoryList,
                  color: Colors.green,
                  barWidth: 3,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.green.withOpacity(0.3),
                  ),
                  dotData:
                      FlDotData(show: true), 
                ),
               
                LineChartBarData(
                  isCurved: false,
                  spots: energyHistoryList
                      .map((spot) => FlSpot(spot.x, 0))
                      .toList(),
                  showingIndicators:
                      energyHistoryList.map((spot) => spot.x.toInt()).toList(),
                  barWidth: 1, 
                  isStrokeCapRound: true,
                  color: Colors.grey.shade400, 
                  belowBarData: BarAreaData(show: false),
                  dotData: FlDotData(show: false), 
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Highest Production Day',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '$highestProduction W',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Today',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '$todayProduction W',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 15,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Average',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '$dailyAverageCleaned W',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
