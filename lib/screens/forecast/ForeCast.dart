import 'package:cas_tsyp_app/widgets/forecast_widget.dart';
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
    '24/11/2024':150,
    '25/11/2024':160,
    '26/11/2024':220,
    '27/11/2024':180,
    '28/11/2024 ':80,
    '29/11/2024':105,
    '30/11/2024':240
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
          title: null, 
          flexibleSpace: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Power Supply Analysis",
                  textAlign: TextAlign.center, 
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent
        ),
      body: EnergyTableWidget(energyData: energyData),
    );
  }
}

