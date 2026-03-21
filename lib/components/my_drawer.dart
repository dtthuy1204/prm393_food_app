import 'package:flutter/material.dart';
import 'package:prm393_food_app/components/my_drawer_tile.dart';
import 'package:prm393_food_app/pages/settings_page.dart';
import 'package:prm393_food_app/services/auth/auth_service.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

 @override
Widget build(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFFFDEE9),
            Color(0xFFB5FFFC),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),

      child: SafeArea(
        child: Column(
          children: [

            // 🔝 HEADER
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.85),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                children: [
                  // avatar
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.pink.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Welcome 👋",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Let's order something!",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            // 📋 MENU
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [

                  MyDrawerTile(
                    text: "Home",
                    icon: Icons.home,
                    onTap: () => Navigator.pop(context),
                  ),

                  MyDrawerTile(
                    text: "Settings",
                    icon: Icons.settings,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 10),

                  Divider(color: Colors.grey[300]),

                  const SizedBox(height: 10),

                  // 🔴 LOGOUT (nổi bật)
                  MyDrawerTile(
                    text: "Logout",
                    icon: Icons.logout,
                    onTap: () {
                      Navigator.pop(context);
                      logout();
                    },
                  ),
                ],
              ),
            ),

            // 👇 footer
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "Food App v1.0 🍔",
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
