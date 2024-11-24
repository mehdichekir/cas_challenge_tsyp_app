import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartDashboard extends StatelessWidget {
  const BarChartDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final productionData = [200.0, 200.0, 200.0];
    double sumProd = productionData.reduce((value, element) => value + element);
    final consumptionDataSolarPannel = [100.0, 150.0, 150.0];
    double sumConsPannel =
        consumptionDataSolarPannel.reduce((value, element) => value + element);
    final consumptionDataCar = [50.0, 190.0, 140.0];
    double sumConsCar =
        consumptionDataCar.reduce((value, element) => value + element);
    final consumptionDataNeighbor = [120.0, 30.0, 150.0];
    double sumConsNeighbor =
        consumptionDataNeighbor.reduce((value, element) => value + element);
    final consumptionDataSteg = [20.0, 50.0, 30.0];
    double sumConsSteg =
        consumptionDataSteg.reduce((value, element) => value + element);
    final totalProd =
        sumProd - (sumConsPannel + sumConsSteg + sumConsCar + sumConsNeighbor);
    return Column(
      children: [
        Container(
          height: 400,
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            child: BarChart(
              BarChartData(
                maxY: 250,
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: true),
                barGroups: [
                  BarChartGroupData(
                    barsSpace: 10,
                    x: 1,
                    barRods: [
                      BarChartRodData(
                          toY: productionData[0], color: Colors.green),
                      BarChartRodData(
                          toY: consumptionDataCar[0], color: Colors.blue),
                      BarChartRodData(
                          toY: consumptionDataSolarPannel[0],
                          color: Colors.yellow),
                      BarChartRodData(
                          toY: consumptionDataNeighbor[0], color: Colors.orange),
                      BarChartRodData(
                          toY: consumptionDataSteg[0], color: Colors.red),
                    ],
                  ),
                  BarChartGroupData(
                    barsSpace: 10,
                    x: 2,
                    barRods: [
                      BarChartRodData(
                          toY: productionData[1], color: Colors.green),
                      BarChartRodData(
                          toY: consumptionDataCar[1], color: Colors.blue),
                      BarChartRodData(
                          toY: consumptionDataSolarPannel[1],
                          color: Colors.yellow),
                      BarChartRodData(
                          toY: consumptionDataNeighbor[1], color: Colors.orange),
                      BarChartRodData(
                          toY: consumptionDataSteg[1], color: Colors.red),
                    ],
                  ),
                  BarChartGroupData(
                    barsSpace: 10,
                    x: 3,
                    barRods: [
                      BarChartRodData(
                          toY: productionData[2], color: Colors.green),
                      BarChartRodData(
                          toY: consumptionDataCar[2], color: Colors.blue),
                      BarChartRodData(
                          toY: consumptionDataSolarPannel[2],
                          color: Colors.yellow),
                      BarChartRodData(
                          toY: consumptionDataNeighbor[2], color: Colors.orange),
                      BarChartRodData(
                          toY: consumptionDataSteg[2], color: Colors.red),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      reservedSize: 50,
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text('${value.toInt()} W');
                      },
                    ),
                  ),
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 1:
                            return const Text('Mon');
                          case 2:
                            return const Text('Tue');
                          case 3:
                            return const Text('Wed');
                          default:
                            return const Text('');
                        }
                      },
                    ),
                  ),
                ),
                alignment: BarChartAlignment.spaceBetween,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Production '),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.yellow),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Solar Panel'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Car Energy '),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Neighbor'),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('STEG '),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          height: 130,
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(130),
            border: Border.all(
              color: Colors.green,
              width: 10
            )
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 5,left: 5,top: 2,bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.lightGreen,
                        border: Border.all()
                      ),
                      child: Text('$totalProd',style: const TextStyle(fontSize: 18),)),
                  ],
                )),
                const SizedBox(height: 2,),
                const Text('KW',style: TextStyle(fontWeight: FontWeight.bold),)
            ],
          ) ,
        )
      ],
    );
  }
}
