import 'dart:math' as math;
import 'package:flutter/material.dart';

// ==========================================
// WARNA
// ==========================================

const Color backgroundColor = Color(0xFFF7F7F7);
const Color darkColor = Color(0xFF24201E);

const Color level1Color = Color(0xFFB9A894);
const Color level2Color = Color(0xFFFF9900);
const Color level3Color = Color(0xFFF15B19);
const Color level4Color = Color(0xFF5D5045);

// ==========================================
// DATA BENEFITS
// ==========================================

class BenefitData {
  final IconData icon;
  final String title;
  final String description;

  const BenefitData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// ==========================================
// DATA MEMBERSHIP
// ==========================================

class MemberInfo {
  final int level;
  final String name;
  final Color color;
  final String description;
  final List<BenefitData> benefits;

  const MemberInfo({
    required this.level,
    required this.name,
    required this.color,
    required this.description,
    required this.benefits,
  });
}

final List<MemberInfo> memberLevels = [
  // LEVEL 1
  MemberInfo(
    level: 1,
    name: 'Coffee Newbie',
    color: level1Color,
    description: '3 more orders to reach Lv.2',
    benefits: const [
      BenefitData(
        icon: Icons.monetization_on_outlined,
        title: 'Points Rewards',
        description:
            'Enjoy Cashback on points for every purchase you made!',
      ),
      BenefitData(
        icon: Icons.confirmation_number_outlined,
        title: 'Membership Voucher',
        description:
            'Enjoy exclusive offers on the app every week',
      ),
    ],
  ),

  // LEVEL 2
  MemberInfo(
    level: 2,
    name: 'Coffee Holic',
    color: level2Color,
    description: 'Place 3 orders at Lv.1 to unlock Lv.2',
    benefits: const [
      BenefitData(
        icon: Icons.monetization_on,
        title: 'APP 1.1× Points',
        description: 'Earn 1.1× points on app orders',
      ),
      BenefitData(
        icon: Icons.confirmation_number,
        title: 'Membership Voucher',
        description:
            'Enjoy exclusive offers on the app every week',
      ),
      BenefitData(
        icon: Icons.cake,
        title: 'Birthday Treats 20% OFF',
        description: 'Celebrate your birthday with 20% off',
      ),
    ],
  ),

  // LEVEL 3
  MemberInfo(
    level: 3,
    name: 'Coffee Addict',
    color: level3Color,
    description: 'Place 5 orders at Lv.2 to unlock Lv.3',
    benefits: const [
      BenefitData(
        icon: Icons.monetization_on,
        title: 'APP 1.2× Points',
        description: 'Earn 1.2× points on app orders',
      ),
      BenefitData(
        icon: Icons.confirmation_number,
        title: 'Membership Voucher',
        description:
            'Enjoy exclusive offers on the app every week',
      ),
      BenefitData(
        icon: Icons.cake,
        title: 'Birthday Treats 30% OFF',
        description: 'Celebrate your birthday with 30% off',
      ),
    ],
  ),

  // LEVEL 4
  MemberInfo(
    level: 4,
    name: 'Coffee Mania',
    color: level4Color,
    description: 'Place 12 orders at Lv.3 to unlock Lv.4',
    benefits: const [
      BenefitData(
        icon: Icons.monetization_on,
        title: 'APP 1.5× Points',
        description: 'Earn 1.5× points on app orders',
      ),
      BenefitData(
        icon: Icons.confirmation_number,
        title: 'Membership Voucher',
        description:
            'Enjoy exclusive offers on the app every week',
      ),
      BenefitData(
        icon: Icons.cake,
        title: 'Birthday Treats B1G1',
        description: 'Enjoy B1G1 off on your birthday',
      ),
      BenefitData(
        icon: Icons.card_giftcard,
        title: 'Exclusive Experience',
        description:
            'Enjoy special experiences made for members',
      ),
    ],
  ),
];

// ==========================================
// MEMBER PAGE
// ==========================================

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MemberLevelPage(level: 1);
  }
}

// ==========================================
// HALAMAN LEVEL DAN SWIPE
// ==========================================

class MemberLevelPage extends StatefulWidget {
  final int level;

  const MemberLevelPage({
    super.key,
    this.level = 1,
  });

  @override
  State<MemberLevelPage> createState() =>
      _MemberLevelPageState();
}

class _MemberLevelPageState extends State<MemberLevelPage> {
  late PageController pageController;
  late int selectedLevel;
  bool isUpdatingLevel = false;

  @override
  void initState() {
    super.initState();

    // Pastikan level awal selalu berada di antara 1 sampai 4.
    selectedLevel = widget.level.clamp(1, 4).toInt();

    pageController = PageController(
      initialPage: selectedLevel - 1,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // Dipanggil saat titik level di bagian atas disentuh.
  void changeLevel(int level) {
    if (level < 1 || level > 4 || !pageController.hasClients) {
      return;
    }

    pageController.animateToPage(
      level - 1,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  // Konten Benefits baru diganti setelah gerakan swipe benar-benar selesai.
  bool handlePageScroll(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.axis == Axis.horizontal &&
        pageController.hasClients) {
      final int newLevel =
          (pageController.page ?? (selectedLevel - 1)).round() + 1;

      if (newLevel != selectedLevel && !isUpdatingLevel) {
        isUpdatingLevel = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          setState(() {
            selectedLevel = newLevel.clamp(1, 4).toInt();
          });
          isUpdatingLevel = false;
        });
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final member = memberLevels[selectedLevel - 1];
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // HEADER BERGESER MENGIKUTI JARI.
            // Data Benefits di bawah tidak berubah sampai swipe selesai.
            SizedBox(
              height: (screenHeight * 0.39)
                  .clamp(285.0, 360.0)
                  .toDouble(),
              child: NotificationListener<ScrollNotification>(
                onNotification: handlePageScroll,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: memberLevels.length,
                  physics: const PageScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MembershipHeader(
                      key: ValueKey(index),
                      member: memberLevels[index],
                      onLevelTap: changeLevel,
                    );
                  },
                ),
              ),
            ),

            // Benefits berganti setelah PageView mencapai halaman tujuan.
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 280),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                child: SingleChildScrollView(
                  key: ValueKey(selectedLevel),
                  child: BenefitsSection(
                    benefits: member.benefits,
                    color: member.color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// HEADER MEMBERSHIP
// ==========================================

class MembershipHeader extends StatelessWidget {
  final MemberInfo member;
  final Function(int) onLevelTap;

  const MembershipHeader({
    super.key,
    required this.member,
    required this.onLevelTap,
  });

  @override
  Widget build(BuildContext context) {
    final int currentLevel = member.level;

    final int firstLevel =
        math.max(1, currentLevel - 1);

    final int lastLevel =
        math.min(4, currentLevel + 1);

    final visibleLevels = List.generate(
      lastLevel - firstLevel + 1,
      (index) => firstLevel + index,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final headerHeight = constraints.maxHeight;

        return Container(
          width: width,
          height: headerHeight,
          color: member.color,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // BACKGROUND DEKORASI
              Positioned(
                right: 35,
                top: headerHeight * 0.30,
                child: Transform.rotate(
                  angle: -0.2,
                  child: Container(
                    width: width * 0.46,
                    height: headerHeight * 0.46,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(
                        alpha: 0.025,
                      ),
                      borderRadius:
                          BorderRadius.circular(35),
                    ),
                  ),
                ),
              ),

              // GARIS SETENGAH LINGKARAN
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: CustomPaint(
                  size: Size(width, 125),
                  painter: LevelCurvePainter(),
                ),
              ),

              // TITIK DAN TULISAN LEVEL
              ...List.generate(
                visibleLevels.length,
                (index) {
                  final level = visibleLevels[index];

                  final double position =
                      visibleLevels.length == 1
                          ? 0.5
                          : visibleLevels.length == 2
                              ? (index == 0 ? 0.34 : 0.66)
                              : (index + 1) / 4;

                  // PERBAIKAN ERROR NUM KE DOUBLE
                  final double curveX = position;
                  final double curveY = (
                    35 +
                    100 * math.pow(
                      math.sin(math.pi * curveX),
                      2,
                    )
                  ).toDouble();

                  final double top = curveY - 12;

                  return Positioned(
                    left: width * position - 34,
                    top: top,
                    width: 68,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onLevelTap(level),
                      child: LevelIndicator(
                        level: level,
                        active: level == currentLevel,
                        locked: level > currentLevel,
                      ),
                    ),
                  );
                },
              ),

              // TOMBOL INFORMASI
              Positioned(
                top: 75,
                right: 22,
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Membership Level',
                        ),
                        content: const Text(
                          'Setiap level memiliki keuntungan '
                          'dan persyaratan pesanan yang berbeda.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(context),
                            child: const Text('Mengerti'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 29,
                  ),
                ),
              ),

              // MASKOT ANIMASI
              Positioned(
                right: 5,
                top: headerHeight * 0.42,
                width: width * 0.40,
                height: headerHeight * 0.48,
                child: FloatingMascot(
                  key: ValueKey(currentLevel),
                  level: currentLevel,
                ),
              ),

              // NAMA DAN DESKRIPSI MEMBERSHIP
              Positioned(
                left: 32,
                top: headerHeight * 0.48,
                width: width * 0.57,
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            member.name,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: width < 360 ? 21 : 23,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 23,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      member.description,
                      style: TextStyle(
                        fontSize: width < 360 ? 12 : 13,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ==========================================
// INDIKATOR LEVEL
// ==========================================

class LevelIndicator extends StatelessWidget {
  final int level;
  final bool active;
  final bool locked;

  const LevelIndicator({
    super.key,
    required this.level,
    required this.active,
    required this.locked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: active ? 19 : 15,
          height: active ? 19 : 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active
                ? Colors.white
                : Colors.transparent,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'Lv.$level',
          style: TextStyle(
            color: Colors.white,
            fontSize: active ? 17 : 14,
            fontWeight: active
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        if (locked)
          const Icon(
            Icons.lock,
            color: Colors.white,
            size: 14,
          ),
      ],
    );
  }
}

// ==========================================
// MASKOT KOPI
// ==========================================

class CoffeeMascot extends StatelessWidget {
  final int level;

  const CoffeeMascot({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    if (level == 3) {
      return Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 5,
            left: 10,
            child: Icon(
              Icons.music_note,
              color: Color(0xFFFFD3AD),
              size: 36,
            ),
          ),
          const Positioned(
            right: 8,
            top: 15,
            child: Icon(
              Icons.music_note,
              color: Color(0xFFFFD3AD),
              size: 30,
            ),
          ),
          Icon(
            Icons.headphones,
            color: darkColor,
            size: 145,
          ),
          Positioned(
            bottom: 15,
            child: Row(
              children: [
                coffeeCup(),
                const SizedBox(width: 9),
                coffeeCup(),
              ],
            ),
          ),
        ],
      );
    }

    if (level == 4) {
      return Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 0,
            child: Icon(
              Icons.workspace_premium,
              color: Color(0xFFFFBD4A),
              size: 47,
            ),
          ),
          Icon(
            Icons.local_cafe,
            color: darkColor,
            size: 145,
          ),
          Positioned(
            bottom: 15,
            child: Row(
              children: [
                coffeeCup(),
                const SizedBox(width: 7),
                coffeeCup(),
              ],
            ),
          ),
          const Positioned(
            right: 0,
            top: 45,
            child: Icon(
              Icons.coffee,
              color: Color(0xFFFFD38A),
              size: 40,
            ),
          ),
        ],
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(
          Icons.local_cafe,
          color: darkColor,
          size: 145,
        ),
        Positioned(
          bottom: 35,
          child: Icon(
            level == 1
                ? Icons.favorite
                : Icons.sentiment_satisfied,
            color: level == 1
                ? const Color(0xFFFF795D)
                : const Color(0xFFFFE9B0),
            size: 32,
          ),
        ),
      ],
    );
  }

  Widget coffeeCup() {
    return Container(
      width: 40,
      height: 67,
      decoration: BoxDecoration(
        color: const Color(0xFFFFE3C0),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: const Icon(
        Icons.coffee,
        color: Color(0xFF9B5631),
        size: 26,
      ),
    );
  }
}

// ==========================================
// ANIMASI MASKOT MENGAMBANG
// ==========================================

class FloatingMascot extends StatefulWidget {
  final int level;

  const FloatingMascot({
    super.key,
    required this.level,
  });

  @override
  State<FloatingMascot> createState() =>
      _FloatingMascotState();
}

class _FloatingMascotState extends State<FloatingMascot>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final value = controller.value;

        // GERAKAN NAIK TURUN
        final movement =
            math.sin(value * 2 * math.pi) * 7;

        // EFEK BERDENYUT
        final scale =
            1 + math.sin(value * 2 * math.pi) * 0.025;

        return Transform.translate(
          offset: Offset(0, movement),
          child: Transform.scale(
            scale: scale,
            child: Stack(
              children: [
                // ILUSTRASI MASKOT
                CoffeeMascot(
                  level: widget.level,
                ),

                // EFEK KEDIPAN DEKORASI
                Positioned(
                  top: 30,
                  right: 25,
                  child: Opacity(
                    opacity: 0.5 +
                        0.5 *
                            math.sin(
                              value * 2 * math.pi,
                            ).abs(),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Color(0xFFFFE1A8),
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ==========================================
// BENEFITS SECTION
// ==========================================

class BenefitsSection extends StatelessWidget {
  final List<BenefitData> benefits;
  final Color color;

  const BenefitsSection({
    super.key,
    required this.benefits,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        18,
        22,
        18,
        24,
      ),
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Benefits',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),
          const SizedBox(height: 18),
          ...benefits.map(
            (benefit) => Padding(
              padding: const EdgeInsets.only(
                bottom: 13,
              ),
              child: BenefitCard(
                benefit: benefit,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// BENEFIT CARD
// ==========================================

class BenefitCard extends StatelessWidget {
  final BenefitData benefit;
  final Color color;

  const BenefitCard({
    super.key,
    required this.benefit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              shape: BoxShape.circle,
            ),
            child: Icon(
              benefit.icon,
              color: color,
              size: 29,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  benefit.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  benefit.description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF999999),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// GARIS SETENGAH LINGKARAN
// ==========================================

class LevelCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Kurva dibuat dari dua cubic bezier.
    // Kedua ujung mempunyai arah garis mendatar (tangent horizontal),
    // jadi saat dua halaman PageView bertemu, garis tidak membentuk
    // puncak tajam seperti bentuk V.
    final double startY = 35;
    final double middleY = 135;
    final double quarterX = size.width * 0.25;
    final double middleX = size.width * 0.5;
    final double threeQuarterX = size.width * 0.75;

    final path = Path()
      ..moveTo(0, startY)
      ..cubicTo(
        quarterX,
        startY,
        quarterX,
        middleY,
        middleX,
        middleY,
      )
      ..cubicTo(
        threeQuarterX,
        middleY,
        threeQuarterX,
        startY,
        size.width,
        startY,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(
    covariant LevelCurvePainter oldDelegate,
  ) => false;
}

// ==========================================
// BOTTOM NAVIGATION
// ==========================================

class MemberBottomNavigation extends StatelessWidget {
  const MemberBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          navItem(Icons.home, 'Home'),
          navItem(
            Icons.local_drink,
            'Menu',
          ),

          // TOMBOL QR
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5638),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.qr_code,
              color: Colors.white,
              size: 34,
            ),
          ),

          // MEMBER AKTIF
          const Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                Icons.workspace_premium,
                color: Color(0xFFFF5638),
                size: 25,
              ),
              SizedBox(height: 3),
              Text(
                'Member',
                style: TextStyle(
                  color: Color(0xFFFF5638),
                  fontSize: 12,
                ),
              ),
            ],
          ),

          navItem(
            Icons.person,
            'Me',
          ),
        ],
      ),
    );
  }

  Widget navItem(
    IconData icon,
    String title,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: const Color(0xFFD0D0D0),
          size: 25,
        ),
        const SizedBox(height: 3),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}