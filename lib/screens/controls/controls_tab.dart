import 'package:cas_tsyp_app/helpers/notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helpers/smart_home_controller.dart';


class ControlsTab extends StatefulWidget {
  final controller = Get.find<SmartHomeController>();

  ControlsTab({super.key});

  @override
  State<ControlsTab> createState() => _ControlsTabState();
}

class _ControlsTabState extends State<ControlsTab> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Status Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('System Status',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 8),
                _buildStatusRow('Temperature',
                    '${widget.controller.status.value!.environment.temperature}°C', Icons.thermostat),
                _buildStatusRow('Humidity',
                    '${widget.controller.status.value!.environment.humidity}%', Icons.water),
                _buildStatusRow('AC',
                    widget.controller.status.value!.environment.fanRunning
                        ? 'Running'
                        : 'Off', Icons.ac_unit),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () => widget.controller.sendCommand('TOGGLE AC'),
                    child: const Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        Card(
          child: Padding(
            padding:const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'AC control',
                  style:
                  TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        widget.controller.sendCommand('SET AC ON');
                      },
                      icon: const Icon(Icons.timer),
                      label: Text(widget.controller.status.value?.environment.fanRunning == true
                          ? 'Turn off Air Conditioner'
                          : 'Turn on Air Conditioner'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Doors Control Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Doors Control',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            widget.controller.sendCommand('SET GARAGE OPEN'),
                        child: const Text('Open Garage'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => {
                          widget.controller.sendCommand('SET GARAGE CLOSE'),
                          NotificationService().showFireNotification(),
                        },
                        child: const Text('Close Garage'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            widget.controller.sendCommand('SET FRONTDOOR OPEN'),
                        child: const Text('Open Front Door'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            widget.controller.sendCommand('SET FRONTDOOR CLOSE'),
                        child: const Text('Close Front Door'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Lights Control Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Lights Control',
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                const SizedBox(height: 16),
                _buildLightControls('BEDROOM'),
                const SizedBox(height: 16),
                _buildLightControls('TOILET'),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget _buildStatusRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon),
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildLightControls(String location) {
    return LightControls(
      location: location,
      sendCommand: widget.controller.sendCommand,
    );
  }
}


class DurationPickerDialog extends StatefulWidget {
  final Function(int milliseconds) onDurationSelected;

  const DurationPickerDialog({
    super.key,
    required this.onDurationSelected,
  });

  @override
  State<DurationPickerDialog> createState() => _DurationPickerDialogState();
}

class _DurationPickerDialogState extends State<DurationPickerDialog> {
  int _value = 1;
  String _timeUnit = 'hours'; // Default unit

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Set Duration'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Duration',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _value = int.tryParse(value) ?? 1;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _timeUnit,
                items: const [
                  DropdownMenuItem(
                    value: 'seconds',
                    child: Text('Seconds'),
                  ),
                  DropdownMenuItem(
                    value: 'minutes',
                    child: Text('Minutes'),
                  ),
                  DropdownMenuItem(
                    value: 'hours',
                    child: Text('Hours'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _timeUnit = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            int milliseconds;
            switch (_timeUnit) {
              case 'seconds':
                milliseconds = _value * 1000;
                break;
              case 'minutes':
                milliseconds = _value * 60 * 1000;
                break;
              case 'hours':
                milliseconds = _value * 60 * 60 * 1000;
                break;
              default:
                milliseconds = _value * 60 * 60 * 1000; // Default to hours
            }
            widget.onDurationSelected(milliseconds);
            Navigator.of(context).pop();
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}

class LightControls extends StatelessWidget {
  final String location;
  final Function(String) sendCommand;

  const LightControls({
    super.key,
    required this.location,
    required this.sendCommand,
  });

  void _showDurationPicker(BuildContext context, String state) {
    showDialog(
      context: context,
      builder: (ctx) => DurationPickerDialog(
        onDurationSelected: (milliseconds) {
          sendCommand(
            'SET PAUSE $location DURATION=$milliseconds STATE=$state',
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$location Light'),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showDurationPicker(context, 'UP'),
                icon: const Icon(Icons.timer),
                label: const Text('Force ON'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _showDurationPicker(context, 'DOWN'),
                icon: const Icon(Icons.timer),
                label: const Text('Force OFF'),
              ),
            ),
          ],
        ),
        // Quick preset buttons
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => sendCommand(
                  'SET PAUSE $location DURATION=${3600000} STATE=UP',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                ),
                child: const Text('1h ON'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () => sendCommand(
                  'SET PAUSE $location DURATION=${1800000} STATE=UP',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black,
                ),
                child: const Text('30m ON'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
