import 'package:cas_tsyp_app/screens/energy_dashboard.dart';
import 'package:cas_tsyp_app/screens/house_control.dart';
import 'package:cas_tsyp_app/screens/real_time_visualization.dart';
import 'package:cas_tsyp_app/screens/system_status.dart';
import 'package:cas_tsyp_app/screens/energy_history.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  static const routeName = '/BottomNavbar';
  const BottomNavbar ({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar > {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const RealTimeVisualization(),
    const SystemStatus(),
    ControlTabBar(),
    const EnergyHistory(),
    const EnergyDashboard(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: ' Visualisation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: ' Status',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote_outlined),
            label: ' Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outlined),
            label: ' History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: ' Dashboard',
          ),
        ],
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey.shade600,
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}