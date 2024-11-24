import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// Model for energy data
class DailyEnergy {
  final String day;
  final double ghi;

  DailyEnergy({
    required this.day,
    required this.ghi,
  });

  factory DailyEnergy.fromJson(Map<String, dynamic> json) {
    return DailyEnergy(
      day: json['day'] as String,
      ghi: double.parse(json['ghi'].toString()),
    );
  }
}

class EnergyTableScreen extends StatefulWidget {
  static const routeName = '/energy-table';
  const EnergyTableScreen({Key? key}) : super(key: key);

  @override
  State<EnergyTableScreen> createState() => _EnergyTableScreenState();
}

class _EnergyTableScreenState extends State<EnergyTableScreen> {
  late io.Socket socket;
  Map<String,double> energyData = {
    'd1':120,
    'd2':150,
    'd3':140,
    'd4':200,
    'd5':100,
    'd6':190
  };

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    // Replace with your Socket.IO server URL
    socket = io.io('YOUR_SERVER_URL', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('Connected to Socket.IO server');
    });

    socket.on('energyData', (data) {
      if (mounted) {
        setState(() {
          energyData =
              data.map((item) => DailyEnergy.fromJson(item)).toList();
        });
      }
    });

    socket.on('disconnect', (_) {
      print('Disconnected from Socket.IO server');
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Energy'),
        backgroundColor: const Color(0xFF3F51B5),
      ),
      body: EnergyTableWidget(energyData: energyData),
    );
  }
}

class EnergyTableWidget extends StatelessWidget {
  final Map<String,double> energyData;

  const EnergyTableWidget({
    Key? key,
    required this.energyData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF3F51B5).withOpacity(0.8),
            const Color(0xFF3F51B5),
          ],
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Your Energy',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[300]!,
                          width: 2,
                        ),
                      ),
                    ),
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Day',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'GHI',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'W',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  ...energyData.entries.map((data) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              data.key,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              data.value.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              '${double.parse((data.value * 0.092).toStringAsFixed(2)) }',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
