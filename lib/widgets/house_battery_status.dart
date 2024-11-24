import 'package:flutter/material.dart';

class HouseBatteryStatus extends StatelessWidget {
  final double percentage;
  final bool isCharging; 

  const HouseBatteryStatus({
    Key? key,
    required this.percentage,
    this.isCharging = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 0),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 20.0),
          child: Row(
            children: [
              Icon(Icons.circle, size: 8),
              SizedBox(width: 8),
              Text(
                'Battery status',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width*0.9,
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Positioned(
                    right: -5,
                    top: 7,
                    child: Container(
                      width: 3,
                      height: 11,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 2,
                    top: 2,
                    child: Container(
                      width: 147 * (percentage / 100),
                      height: 80,
                      decoration: BoxDecoration(
                        color: percentage <= 20 ? Colors.red : Colors.teal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (isCharging)
                    const Positioned(
                      left: 10,
                      top: 5,
                      child: Icon(
                        Icons.bolt,
                        color: Colors.yellow,
                        size: 15,
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 25),
              Text(
                '${percentage.toInt()}%',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 25),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'IR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
