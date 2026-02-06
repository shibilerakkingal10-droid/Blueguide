import 'package:flutter/material.dart';

class EmergencyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Tips')),
      body: const Center(
        child: Text(
          'Safety tips will be shown here',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
