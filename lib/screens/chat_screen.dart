import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fishing Assistant')),
      body: const Center(
        child: Text('Chatbot will be here', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
