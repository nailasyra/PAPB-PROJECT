
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home/home.dart';
import 'menu/menu.dart';
import 'qr/qr.dart';
import 'member/member.dart';
import 'me/me.dart';
import 'database/database_helper.dart';


void main() {
  runApp(const TomoroApp());
}


//mendefinisikan bentuk potongan atau lekukan
class RaisedCenterShape extends NotchedShape {
  const RaisedCenterShape();

  @override
  Path getOuterPath(Rect host, Rect? guest) {
    final path = Path();

    if (guest == null) {
      return path..addRect(host);
    }

    final center = guest.center.dx;

    const double curveWidth = 60;
    const double curveHeight = 30;

    final leftCurve = center - curveWidth;
    final rightCurve = center + curveWidth;

    path.moveTo(host.left, host.top);
    path.lineTo(leftCurve, host.top);

    path.cubicTo(
      center - curveWidth * 0.35,
      host.top,
      center - curveWidth * 0.45,
      host.top - curveHeight,
      center,
      host.top - curveHeight,
    );

    path.cubicTo(
      center + curveWidth * 0.35,
      host.top - curveHeight,
      center + curveWidth * 0.45,
      host.top,
      rightCurve,
      host.top,
    );

    path.lineTo(host.right, host.top);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);

    path.close();

    return path;
  }
}

// MAIN APP
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
        fontFamily: GoogleFonts.lexend().fontFamily,
      ),
      home: const MainNavigation(),
    );
  }
}

// MAIN NAVIGATION
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;
  int lastSelectedIndex = 0;

  // STATUS LOGIN
  bool isLoggedIn = false;
  UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          //home
          const HomePage(),

          //menu
          const MenuPage(),

          // QR
          MyQrCodePage(
            isActive: selectedIndex == 2,
            onBack: () {
              setState(() {
                selectedIndex = lastSelectedIndex;
              });
            },
          ),

          //member
          const MemberPage(),

          // ME
          MePage(
            isLoggedIn: isLoggedIn,
            currentUser: currentUser,
            user: currentUser,
            name: currentUser?.nickname ?? 'caca',

            // LOGIN BERHASIL
            onRegisterSuccess: (user) {
              setState(() {
                currentUser = user;
                isLoggedIn = true;
              });
            },

            // PROFILE DIUPDATE
            onProfileUpdated: (updatedUser) {
              setState(() {
                currentUser = updatedUser;
                isLoggedIn = true;
              });
            },

            // LOGOUT
            onLogout: () {
              setState(() {
                currentUser = null;
                isLoggedIn = false;
              });
            },

            // ACCOUNT DIHAPUS
            onAccountDeleted: () {
              setState(() {
                currentUser = null;
                isLoggedIn = false;
              });
            },
          ),
        ],
      ),

      // ======================================
      // FLOATING QR BUTTON
      // ======================================

      floatingActionButton: selectedIndex == 2
          ? null
          : SizedBox(
              width: 50,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    lastSelectedIndex = selectedIndex;
                    selectedIndex = 2;
                  });
                },
                backgroundColor: const Color(0xFFFF5428),
                elevation: 2,
                shape: const CircleBorder(),
                child: Image.asset(
                  'assets/images/icon/qr.png',
                  width: 35,
                  height: 35,
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,

      // ======================================
      // BOTTOM NAVIGATION BAR
      // ======================================

      bottomNavigationBar: selectedIndex == 2
          ? null
          : BottomAppBar(
              color: Colors.white,
              elevation: 8,
              shape: const RaisedCenterShape(),
              notchMargin: 0,
              height: 65,
              padding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  navItem(
                    'assets/images/icon/home.svg',
                    'Home',
                    0,
                  ),

                  navItem(
                    'assets/images/icon/menu.svg',
                    'Menu',
                    1,
                  ),

                  const SizedBox(
                    width: 55,
                    height: 65,
                    child: Align(
                      alignment: Alignment(0, 0.55),
                      child: Text(
                        'QR',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  navItem(
                    'assets/images/icon/member.svg',
                    'Member',
                    3,
                  ),

                  navItem(
                    'assets/images/icon/me.svg',
                    'Me',
                    4,
                  ),
                ],
              ),
            ),
    );
  }

  // ==========================================
  // NAVIGATION ITEM
  // ==========================================

  Widget navItem(String iconPath, String title, int index) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
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
              SvgPicture.asset(
                iconPath,
                width: 23,
                height: 23,
                colorFilter: ColorFilter.mode(
                  isSelected
                      ? const Color(0xFFFF5428)
                      : const Color(0xFFD0D0D0),
                  BlendMode.srcIn,
                ),
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
