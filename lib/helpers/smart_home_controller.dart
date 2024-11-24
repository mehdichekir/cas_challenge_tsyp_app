import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'notifications_service.dart';


class SmartHomeController extends GetxController {
  late io.Socket socket;
  final status = Rx<Map<String, dynamic>>({});
  final temperatureHistory = <double>[].obs;
  final humidityHistory = <double>[].obs;
  final timeHistory = <DateTime>[].obs;
  final isConnected = false.obs;
  final notificationService = NotificationService();
  final serverUrl = 'https://powerhive.loca.lt/';

  @override
  void onInit() {
    super.onInit();
    connectToServer();
  }

  void connectToServer() {
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      isConnected.value = true;
      Fluttertoast.showToast(msg: 'Connected to server');
    });

    socket.onDisconnect((_) {
      isConnected.value = false;
      Fluttertoast.showToast(msg: 'Disconnected from server');
    });

    socket.on('status_update', (data) {
      status.value = Map<String, dynamic>.from(data);

      // Update historical data
      if (data['environment'] != null) {
        temperatureHistory.add(data['environment']['temperature']);
        humidityHistory.add(data['environment']['humidity']);
        timeHistory.add(DateTime.now());

        // Keep last 100 readings
        if (temperatureHistory.length > 100) {
          temperatureHistory.removeAt(0);
          humidityHistory.removeAt(0);
          timeHistory.removeAt(0);
        }
      }

      // Check for fire alert
      if (data['alarm'] != null && data['alarm']['fire_detected'] == true) {
        notificationService.showFireNotification();
      }
    });
  }

  void sendCommand(String command) {
    print('Sending command: $command');
    print(isConnected);
    if (isConnected.value) {
      socket.emit('command', command);
    }
  }
}
