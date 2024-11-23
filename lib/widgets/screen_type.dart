import 'package:flutter/material.dart';

class ScreenType extends StatelessWidget {
  final String routeName;
  final String title;

  const ScreenType({required this.title, required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Center(child: Text(title))),
        onTap: () => Navigator.of(context).pushNamed(routeName),
      ),
    );
  }
}
