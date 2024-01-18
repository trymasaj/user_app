import 'package:flutter/material.dart';

class BookingsTab extends StatelessWidget {
  const BookingsTab({super.key});

  static const routeName = '/BookingsTabPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookingsTab'),
      ),
      body: const Center(
        child: Text('BookingsTab Page'),
      ),
    );
  }
}
