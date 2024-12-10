import 'package:diet_tracker/features/Profile/data/profile_service.dart';
import 'package:flutter/material.dart';
import 'me_page.dart';
import 'settings_page.dart';
import 'about_us_page.dart';
import 'contact_us_page.dart';

import 'package:flutter/material.dart';
import 'me_page.dart';
import 'settings_page.dart';
import 'about_us_page.dart';
import 'contact_us_page.dart';

class ProfilePage extends StatefulWidget {
  final String token;
  const ProfilePage({super.key, required this.token});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userDetails;
  void initState() {
    super.initState();
    final profileService = ProfileService(baseUrl: 'http://localhost:5022');
    _userDetails = profileService.fetchUserDetails(widget.token);
  }

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
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
          future: _userDetails,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            final user = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user['name'],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user["email"],
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    // Me Button
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MePage(
                                      token: widget.token,
                                    )),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Me',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ),
                    // Calorie Intake
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade100,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Calorie Intake',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '3400 Cal',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    // Dark Theme Toggle (Non-functional)
                    const SwitchListTile(
                      title: Text('Dark theme'),
                      value: false, // Default to false (no functionality)
                      onChanged: null, // Disable toggle functionality
                      activeColor: Colors.blue,
                    ),
                    // Contact Us
                    ListTile(
                      leading:
                          const Icon(Icons.email_outlined, color: Colors.blue),
                      title: const Text('Contact us'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContactUsPage()),
                        );
                      },
                    ),
                    // About App
                    ListTile(
                      leading:
                          const Icon(Icons.info_outline, color: Colors.blue),
                      title: const Text('About app'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUsPage()),
                        );
                      },
                    ),
                    // Settings
                    ListTile(
                      leading: const Icon(Icons.settings_outlined,
                          color: Colors.blue),
                      title: const Text('Settings'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage()),
                        );
                      },
                    ),
                    const Divider(),
                    // Logout
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        // Handle logout
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
