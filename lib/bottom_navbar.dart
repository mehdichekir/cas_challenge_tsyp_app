import 'package:cas_tsyp_app/screens/house_control.dart';
import 'package:cas_tsyp_app/screens/house_visualization.dart';
import 'package:cas_tsyp_app/screens/profile_screen.dart';
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
    VisualizationTabBar(),
    ControlTabBar(),
    const ProfileScreen(),
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
            icon: Icon(Icons.ssid_chart_outlined),
            label: ' Visualisation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_remote_outlined),
            label: ' Control',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: ' Profile',
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