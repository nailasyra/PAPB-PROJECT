import 'package:flutter/material.dart';

import 'delete_account.dart';
import '../database/database_helper.dart';
import 'my_profile.dart';

class SettingsPage extends StatefulWidget {
  final bool isLoggedIn;
  final UserModel? user;
  final ValueChanged<UserModel>? onProfileUpdated;
  final VoidCallback? onLogout;
  final VoidCallback? onAccountDeleted;
  const SettingsPage({
    super.key,
    this.isLoggedIn = false,
    this.user,
    this.onProfileUpdated,
    this.onLogout,
    this.onAccountDeleted,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = widget.user;
  }

  @override
  void didUpdateWidget(covariant SettingsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.user != widget.user) {
      currentUser = widget.user;
    }
  }

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
          if (widget.isLoggedIn) ...[
            _settingItem(
              title: 'My Profile',
              onTap: () async {
                if (currentUser == null) return;

                final updatedUser = await Navigator.push<UserModel>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyProfilePage(user: currentUser!),
                  ),
                );

                if (updatedUser != null) {
                  setState(() {
                    currentUser = updatedUser;
                  });

                  widget.onProfileUpdated?.call(updatedUser);
                }
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
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(width: 5),
                Icon(Icons.chevron_right, color: Colors.grey, size: 22),
              ],
            ),
            onTap: () {},
          ),

          if (widget.isLoggedIn) ...[
            _settingItem(
              title: 'Delete Account',
              icon: Icons.highlight_off,
              onTap: () {
                if (currentUser == null) return;

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DeleteAccountPage(
                      user: currentUser!,
                      onAccountDeleted: () {
                        widget.onAccountDeleted?.call();
                      },
                    ),
                  ),
                );
              },
            ),
            _settingItem(
              title: 'Logout',
              icon: Icons.logout,
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  constraints: const BoxConstraints(maxWidth: double.infinity),
                  builder: (sheetContext) {
                    return SafeArea(
                      top: false,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                // Tutup Bottom Sheet
                                Navigator.pop(sheetContext);

                                // Logout
                                widget.onLogout?.call();

                                // Kembali ke halaman Me
                                Navigator.pop(context);
                              },
                              child: const SizedBox(
                                height: 66,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Logout now',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF292929),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const Divider(height: 1, color: Color(0xFFEEEEEE)),

                            InkWell(
                              onTap: () => Navigator.pop(sheetContext),
                              child: const SizedBox(
                                height: 70,
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF292929),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
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
            bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
          ),
        ),
        child: Row(
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 10),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ),
            if (trailing != null)
              trailing
            else
              const Icon(Icons.chevron_right, color: Colors.grey, size: 22),
          ],
        ),
      ),
    );
  }
}
