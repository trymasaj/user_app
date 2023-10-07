
import 'package:flutter/material.dart';

class SettingsTabPage extends StatelessWidget {
  const SettingsTabPage({
    super.key
  });
  static const routeName = '/SettingsTabPage';


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: const Text('SettingsTab'),
     ),
     body: const Center(
       child: Text('SettingsTab Page'),
     ),
   );
  }

}
