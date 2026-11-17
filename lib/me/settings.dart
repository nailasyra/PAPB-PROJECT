
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import 'my_profile.dart';

class SettingsPage extends StatelessWidget {
  final bool isLoggedIn;
  final UserModel? user;

  const SettingsPage({
    super.key,
    this.isLoggedIn = false,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          if (isLoggedIn) ...[
            _settingItem(
              title: 'My Profile',
              onTap: () {
                if (user == null) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyProfilePage(user: user!),
                  ),
                );
              },
            ),
          ],

          _settingItem(
            title: 'About',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Version 3.8.0',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 22,
                ),
              ],
            ),
            onTap: () {},
          ),

          if (isLoggedIn) ...[
            _settingItem(
              title: 'Delete Account',
              icon: Icons.highlight_off,
              onTap: () {},
            ),
            _settingItem(
              title: 'Logout',
              icon: Icons.logout,
              onTap: () {},
            ),
          ],
        ],
      ),
    );
  }

  Widget _settingItem({
    required String title,
    Widget? trailing,
    IconData? icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 57,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFEEEEEE),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: Colors.black87,
              ),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
            if (trailing != null)
              trailing
            else
              const Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
