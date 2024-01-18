import 'package:flutter/material.dart';

class ProvidersTab extends StatelessWidget {
  const ProvidersTab({super.key});

  static const routeName = '/ProvidersTabPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProvidersTab'),
      ),
      body: const Center(
        child: Text('ProvidersTab Page'),
      ),
    );
  }
}
