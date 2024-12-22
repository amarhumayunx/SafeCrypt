import 'package:flutter/material.dart';
import 'package:safecrypt/colors/colors.dart'; // Custom colors
import 'package:safecrypt/screens/create_vault_screen.dart'; // Adjust path if needed

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to SafeCrypt',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _dashboardCard(
                    icon: Icons.lock,
                    title: 'Create Vault',
                    color: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateVaultScreen(),
                        ),
                      );
                    },
                  ),
                  _dashboardCard(
                    icon: Icons.vpn_key,
                    title: 'Manage Vaults',
                    color: Colors.green,
                    onTap: () {
                      // Add navigation to Manage Vaults screen
                    },
                  ),
                  _dashboardCard(
                    icon: Icons.person,
                    title: 'Profile',
                    color: Colors.orange,
                    onTap: () {
                      // Add navigation to Profile screen
                    },
                  ),
                  _dashboardCard(
                    icon: Icons.settings,
                    title: 'Settings',
                    color: Colors.purple,
                    onTap: () {
                      // Add navigation to Settings screen
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
