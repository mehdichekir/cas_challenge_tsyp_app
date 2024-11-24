import 'package:cas_tsyp_app/screens/choose_type_screen.dart';
import 'package:cas_tsyp_app/screens/energy_dashboard.dart';
import 'package:cas_tsyp_app/screens/energy_history.dart';
import 'package:cas_tsyp_app/screens/home_screen.dart';
import 'package:cas_tsyp_app/screens/auth_screen.dart';
import 'package:cas_tsyp_app/screens/real_time_visualtion.dart';
import 'package:cas_tsyp_app/screens/system_status.dart';
import 'package:cas_tsyp_app/widgets/line_chart_history.dart';
import 'package:cas_tsyp_app/widgets/line_chart_real_time.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyC7YV0xcryBiTpABGCNkm17YV93coF00f8", 
        appId: "1:590814977316:android:f59880f2a5cbffab23e7b1", 
        messagingSenderId: "590814977316", 
        projectId: "challenge-tsyp-cas-app", 
        authDomain: "challenge-tsyp-cas-app.firebaseapp.com",
        measurementId: "G-7VD31QW1G7"
      ),
    );
  }

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
      routes: {
        AuthScreen.routeName:(context)=>const AuthScreen(),
        EnergyDashboard.routeName:(context)=>EnergyDashboard(),
        EnergyHistory.routeName:(context)=>EnergyHistory(),
        RealTimeVisualtion.routeName:(context)=>RealTimeVisualtion(),
        SystemStatus.routeName:(context)=>SystemStatus()
      },
    );
  }
}
