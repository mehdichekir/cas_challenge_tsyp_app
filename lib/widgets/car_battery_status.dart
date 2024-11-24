import 'package:flutter/material.dart';

class CarBatteryStatus extends StatefulWidget {
  final double batteryPercentage;
  final int totalDistance;

  CarBatteryStatus({
    Key? key,
    required this.batteryPercentage,
    required this.totalDistance,
  }) : super(key: key);

  @override
  State<CarBatteryStatus> createState() => _CarBatteryStatusState();
}

class _CarBatteryStatusState extends State<CarBatteryStatus> {
  bool savingMode = false;
  @override
  Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
          child: Row(
            children: [
              Icon(Icons.circle, size: 8),
              SizedBox(width: 8),
              Text(
                'Vehicle status',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 185,
                      width: screenWidth*0.45,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'V2H Mode',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 35),
                          Center(
                            child: Text(
                              'ON',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Container(
                      height: 185,
                      width: screenWidth*0.45,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Total Distance',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.electric_car,
                                color: Colors.blue,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                               ' ${widget.totalDistance.toStringAsFixed(0)} Km',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Check Milage',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.blue.shade700,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  width: screenWidth*0.5,
                  height: 384,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Battery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 200 * (widget.batteryPercentage / 100),
                                decoration: BoxDecoration(
                                  color: widget.batteryPercentage<=20? Colors.red: Colors.teal,
                                  borderRadius: BorderRadius.circular(8),
                                ),

                              ),

                            ),
                            Center(
                              child: Text('${widget.batteryPercentage.toInt()}%',
                              style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),),
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: screenWidth*0.25,
                            child: const Text(
                              'Saving mode',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: screenWidth*0.1,
                            child: Switch(
                              value: savingMode,
                              onChanged: (value) {
                                setState(() {
                                  savingMode = value;
                                });
                              },
                              activeColor: Colors.white, 
                              inactiveThumbColor:
                                  Colors.grey, 
                              inactiveTrackColor:
                                  Colors.white, 
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
