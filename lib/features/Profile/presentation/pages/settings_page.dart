import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
            ),
            const SizedBox(height: 8),
            const Text(
              'Khalid',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'khalid@gmail.com',
              style: TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blue),
              title: const Text('Language'),
              trailing: const Text('English', style: TextStyle(color: Colors.blue)),
              onTap: () {
                // Handle Language Change
              },
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6_outlined, color: Colors.blue),
              title: const Text('Theme'),
              trailing: const Text('System', style: TextStyle(color: Colors.blue)),
              onTap: () {
                // Handle Theme Change
              },
            ),
            ListTile(
              leading: const Icon(Icons.water_drop_outlined, color: Colors.blue),
              title: const Text('Water tracker'),
              trailing: const Text('Enabled', style: TextStyle(color: Colors.blue)),
              onTap: () {
                // Handle Water Tracker Setting
              },
            ),
          ],
        ),
      ),
    );
  }
}