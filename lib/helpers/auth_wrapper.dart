import 'package:cas_tsyp_app/bottom_navbar.dart';
import 'package:cas_tsyp_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  static const routeName = '/';
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const BottomNavbar();
        }else{
        return const HomeScreen();
        }
      },
    );
  }
}