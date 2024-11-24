import 'package:cas_tsyp_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String userEmail;
  late Map<String, dynamic>? userData;
  bool isLoading = true;
  final String _appVersion = 'App Version 1.0.0';
  // Constants
  static const double _profileImageRadius = 65.0;
  static const EdgeInsets _screenPadding = EdgeInsets.only(
    top: 80.0,
    left: 16.0,
    right: 16.0,
    bottom: 16.0,
  );


 Future<void> getUserData() async{
  final  userId = FirebaseAuth.instance.currentUser!.uid;
  final snapShot = await FirebaseFirestore.instance.collection('Users').doc(userId).get();
  setState(() {
  userData = snapShot.data() ;
    isLoading = false;
  });
  }

  @override
  void initState() {
   super.initState();
   getUserData();
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      }
    } catch (e) {
      if (context.mounted) showSnackBar(context, 'Error Signing Out');
    }
  }

  void _handleLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Logout Confirmation'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _signOut(context);
            },
            child: const Text('logout'),
          ),
        ],
      ),
    );
  }


  Widget _buildProfileImage() {
    return const CircleAvatar(
      radius: _profileImageRadius,
      backgroundImage: AssetImage('assets/icons/default_profile_pic_man.png')
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Column(
      children: [
        Text(
          "${userData?["username"]} ",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text('${userData?['email']}', style: theme.textTheme.titleMedium),
      ],
    );
  }

  Widget _buildMenuItems(ThemeData theme) {
    return Column(
      children: [
        settingScreenItem(
          context,
          icon: Icons.settings,
          itemName: 'Settings',
          page: 'Settings'
        ),
        ListTile(
          leading: Icon(Icons.person_rounded, color: theme.primaryColor),
          title: Text('Personal Account', style: theme.textTheme.titleSmall),
          onTap: () {},
        ),
        settingScreenItem(
          context,
          icon: Icons.support_agent,
          itemName: 'Contact Support',
          page:'Contact Support',
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app, color: theme.primaryColor),
          title: Text('Logout', style: theme.textTheme.titleSmall),
          onTap: () => _handleLogout(context),
        ),
      ],
    );

  }

  @override
  Widget build(BuildContext context) {

    if(isLoading) {
      return const CustomLoadingScreen(message: "Loading...",);
    }
    /*if (userData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }*/

    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: _screenPadding,
            child: Column(
              children: [
                _buildProfileImage(),
                const SizedBox(height: 12),
                _buildUserInfo(theme),
                const SizedBox(height: 14),
                Divider(color: theme.primaryColorLight),
                const SizedBox(height: 14),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildMenuItems(theme),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
            child: Text(
              _appVersion,
              style: theme.textTheme.labelMedium?.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}