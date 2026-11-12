
import 'package:flutter/material.dart';

import 'home/home.dart';
import 'menu/menu.dart';
import 'qr/qr.dart';
import 'member/member.dart';
import 'me/me.dart';

void main() {
  runApp(const TomoroApp());
}

class TomoroApp extends StatelessWidget {
  const TomoroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomoro Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        fontFamily: 'Roboto',
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomePage(),
    MenuPage(),
    QRPage(),
    MemberPage(),
    MePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      floatingActionButton: SizedBox(
        width: 58,
        height: 58,
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              selectedIndex = 2;
            });
          },
          backgroundColor: const Color(0xFFFF5428),
          elevation: 3,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.qr_code,
            color: Colors.white,
            size: 29,
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        notchMargin: 7,
        height: 65,
        padding: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem(Icons.home_rounded, 'Home', 0),
            navItem(Icons.local_cafe_rounded, 'Menu', 1),

            const SizedBox(width: 55),

            navItem(Icons.workspace_premium_rounded, 'Member', 3),
            navItem(Icons.person_rounded, 'Me', 4),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String title, int index) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: SizedBox(
          height: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 23,
                color: isSelected
                    ? const Color(0xFFFF5428)
                    : const Color(0xFFD0D0D0),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11,
                  color: isSelected
                      ? const Color(0xFFFF5428)
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
