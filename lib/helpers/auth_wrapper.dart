import 'package:cas_tsyp_app/bottom_navbar.dart';
import 'package:cas_tsyp_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  static const routeName = '/';
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Check if the user is logged in
        if (snapshot.hasData) {
          return const BottomNavbar();
        }
        // User is not logged in
        return const AuthScreen();
      },
    );
  }
}