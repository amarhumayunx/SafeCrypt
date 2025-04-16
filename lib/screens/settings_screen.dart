import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            // Section 1: Account settings
            ListTile(
              title: Text('Account Settings'),
              subtitle: Text('Manage your account details'),
              leading: Icon(Icons.account_circle),
              onTap: () {
                // You can add functionality here
                // For example, navigate to another screen for account settings
              },
            ),
            Divider(),

            // Section 2: Notifications
            ListTile(
              title: Text('Notifications'),
              subtitle: Text('Set your notification preferences'),
              leading: Icon(Icons.notifications),
              onTap: () {
                // Add functionality for notifications settings
              },
            ),
            Divider(),

            // Section 3: Privacy settings
            ListTile(
              title: Text('Privacy Settings'),
              subtitle: Text('Manage your privacy preferences'),
              leading: Icon(Icons.lock),
              onTap: () {
                // Add functionality for privacy settings
              },
            ),
            Divider(),

            // Section 4: App theme
            ListTile(
              title: Text('App Theme'),
              subtitle: Text('Switch between light and dark themes'),
              leading: Icon(Icons.brightness_6),
              onTap: () {
                // Add functionality to toggle app theme
              },
            ),
            Divider(),

            // Section 5: About
            ListTile(
              title: Text('About'),
              subtitle: Text('Learn more about the app'),
              leading: Icon(Icons.info),
              onTap: () {
                // Add functionality to show about info
              },
            ),
            Divider(),

            // Section 6: Logout
            ListTile(
              title: Text('Logout'),
              subtitle: Text('Sign out of your account'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                // Add logout functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
