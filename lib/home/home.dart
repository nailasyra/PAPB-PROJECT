import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: SingleChildScrollView(
          child: Column(
            children: const [
              PromoCarousel(),
              TransformMemberSection(),
              ExploreMore(),
              LimitedOffersSection(),
              ForYouSection(),
              MissionSection(),
              TomoroHighlightSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class TransformMemberSection extends StatelessWidget {
  const TransformMemberSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -25),
      child: const MemberPromoSection(),
    );
  }
}

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({super.key});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  static const int initialPage = 10000;

  final PageController _pageController = PageController(
    initialPage: initialPage,
  );

  int currentPage = initialPage;
  int currentIndex = 0;

  Timer? _timer;

  final List<String> bannerImages = [
    'assets/images/backgrounds/bg01.png',
    'assets/images/backgrounds/bg02.png',
    'assets/images/backgrounds/bg03.png',
    'assets/images/backgrounds/bg05.png',
  ];

  @override
  void initState() {
    super.initState();
    startAutoPlay();
  }

  void startAutoPlay() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_pageController.hasClients) return;

      _pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 1100),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
      currentIndex = index % bannerImages.length;
    });

    startAutoPlay();
  }

  Widget getBannerContent(int index) {
    switch (index % bannerImages.length) {
      case 0:
        return const MasterSoeContent();
      case 1:
        return const GrandOpeningContent();
      case 2:
        return const EggTartContent();
      case 3:
        return const MonthlyGiftContent();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
        child: Stack(
          children: [
            // BACKGROUND
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                switchInCurve: Curves.easeInOutCubic,
                switchOutCurve: Curves.easeInOutCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image.asset(
                  bannerImages[currentIndex],
                  key: ValueKey(currentIndex),
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Background tidak ditemukan'),
                    );
                  },
                ),
              ),
            ),

            // TULISAN BANNER
            Positioned.fill(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return getBannerContent(index);
                },
              ),
            ),

            // INDIKATOR
            Positioned(
              right: 20,
              bottom: 40,
              child: Row(
                children: List.generate(bannerImages.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentIndex == index ? 20 : 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.white
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemberPromoSection extends StatelessWidget {
  const MemberPromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 18),
      padding: const EdgeInsets.only(top: 15, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // MEMBER STATUS
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 242, 241),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Level
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9E8C75),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Text(
                        'Lv.1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Cashback
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7),
                      child: Text(
                        '5% Cashback',
                        style: TextStyle(
                          fontSize: 9,
                          color: Color.fromARGB(255, 111, 110, 110),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 7),

              const Spacer(),

              Image.asset(
                'assets/images/backgrounds/tiket.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),

              const Text(
                '2',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),

              const SizedBox(width: 12),

              Image.asset(
                'assets/images/backgrounds/koin.png',
                width: 30,
                height: 40,
                fit: BoxFit.contain,
              ),

              const Text(
                '0 ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),

              const Text(
                'pts',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // SECTION TITLE
          Row(
            children: [
              const Text(
                'New Member Exclusive',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF222222),
                ),
              ),

              const Spacer(),

              Text(
                'Limited time',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // PROMO IMAGES
          Row(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/images/backgrounds/membercup.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('First Cup tidak ditemukan'),
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Container(
                  width: 1,
                  height: 35,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  color: const Color.fromARGB(255, 245, 244, 244),
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/images/backgrounds/membertiket.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text('Super Value tidak ditemukan'),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExploreMore extends StatelessWidget {
  const ExploreMore({super.key});

  final List<Map<String, String>> menus = const [
    {'title': 'Pick Up', 'icon': 'assets/images/icon/pick up.png'},
    {'title': 'Delivery', 'icon': 'assets/images/icon/delivery.png'},
    {'title': 'Referral', 'icon': 'assets/images/icon/referral.png'},
    {'title': 'Monthly\nPromo', 'icon': 'assets/images/icon/monthly promo.png'},
    {'title': 'Spin & Win', 'icon': 'assets/images/icon/spin & win.png'},
    {'title': 'Mission', 'icon': 'assets/images/icon/mission.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 5, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore More',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 95,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: menus.length,
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemBuilder: (context, index) {
                final menu = menus[index];

                return SizedBox(
                  width: 90,
                  child: Column(
                    children: [
                      Container(
                        width: 54,
                        height: 54,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(209, 234, 234, 234),
                              Color.fromARGB(255, 250, 250, 250),
                            ],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          menu['icon']!,
                          width: 54,
                          height: 54,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        menu['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF222222),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// BANNER 1: MASTER S.O.E. SERIES
// ==========================================

class RecommendationClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - 7, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class MasterSoeContent extends StatelessWidget {
  const MasterSoeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // JUDUL MASTER S.O.E.
            Positioned(
              top: height * 0.120,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: 'MASTER '),
                          TextSpan(
                            text: 'S.O.E.',
                            style: TextStyle(
                              fontSize: 23,
                              color: Color(0xFFF0B56C),
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(text: ' SERIES'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 2),

                  const Text(
                    'E T H I O P I A N  H E R I T A G E',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // JENIS KOPI
            Positioned(
              top: height * 0.27,
              left: width * 0.31,
              right: width * 0.31,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 3,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Latte  |  Americano  |  Breve Latte',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // RECOMMENDED BY
            Positioned(
              left: 0,
              bottom: height * 0.13,
              child: ClipPath(
                clipper: RecommendationClipper(),
                child: Container(
                  width: width * 0.30,
                  padding: const EdgeInsets.fromLTRB(12, 9, 28, 9),
                  color: const Color(0xFFFFF7E9),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'RECOMMENDED BY',
                        style: TextStyle(
                          fontSize: 3,
                          color: Color(0xFFC18B54),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 0),
                      Text(
                        'MUHAMMAD AGA',
                        style: TextStyle(
                          fontSize: 7,
                          color: Color(0xFF25201B),
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 0),
                      Text(
                        'Indonesia Barista Champion 2016 & 2025\n'
                        'World Espresso Champion 2025',
                        style: TextStyle(
                          fontSize: 3,
                          color: Color(0xFF51483F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ==========================================
// BANNER 2: GRAND OPENING
// ==========================================

class GrandOpeningContent extends StatelessWidget {
  const GrandOpeningContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // LEFT: GRAND OPENING
            Positioned(
              top: height * 0.12,
              left: width * 0.06,
              width: width * 0.40,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'GRAND',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                    ),
                  ),
                  Text(
                    'OPENING',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      height: 0.95,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Container(
                    width: width * 0.37,
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'HELLO BENGKONG',
                        style: GoogleFonts.montserrat(
                          color: const Color(0xFFFF5428),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // DIVIDER
            Positioned(
              top: height * 0.16,
              left: width * 0.48,
              height: height * 0.48,
              child: Container(
                width: 1,
                color: Colors.white70,
              ),
            ),

            // RIGHT: DATE & LOCATION
            Positioned(
              top: height * 0.13,
              left: width * 0.51,
              right: width * 0.04,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // DATE
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      '07.11.2026',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        height: 1,
                      ),
                    ),
                  ),

                  const SizedBox(height: 3),

                  // DAY & TIME - FORCE ONE LINE
                  SizedBox(
                    width: double.infinity,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'SATURDAY · 9:00 WIB',
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // LOCATION
                  Text(
                    'TOMORO COFFEE, Golden City Bengkong',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 7.5,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 2),

                  // ADDRESS
                  Text(
                    'Jl. Golden Prawn, Tj. Buntung, Bengkong, '
                    'Kota Batam, Kepulauan Riau 29432',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 6,
                      fontWeight: FontWeight.w500,
                      height: 1.05,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
// ==========================================
// BANNER 3 : EGG TART
// ==========================================

class EggTartContent extends StatelessWidget {
  const EggTartContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // ==========================================
            // JUDUL
            // ==========================================
            Positioned(
              top: height * 0.12,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'EGG TART BUNDLES',
                  style: GoogleFonts.outfit(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
            ),

            // ==========================================
            // PANEL PROMO
            // ==========================================
            Positioned(
              top: height * 0.23,
              left: width * 0.12,
              right: width * 0.12,
              height: height * 0.27,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEBDCC9),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    // PROMO KIRI
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 3,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'BELI 2\nEGG TART',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                height: 1.0,
                              ),
                            ),

                            Text(
                              'mulai dari',
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 7,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),

                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '35',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'K',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              'Untuk pembelian di aplikasi TOMORO COFFEE',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 5,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // GARIS DOTTED
                    SizedBox(
                      width: 5,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          10,
                          (index) => Container(
                            width: 3,
                            height: 3,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // PROMO KANAN
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 3,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'EGG TART',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                height: 1.0,
                              ),
                            ),

                            Text(
                              'mulai dari',
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 7,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),

                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '15',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 34,
                                      fontWeight: FontWeight.w900,
                                      height: 1,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'K',
                                    style: GoogleFonts.outfit(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Text(
                              'Dengan pembelian minuman apa pun',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.outfit(
                                color: Colors.black,
                                fontSize: 5,
                                fontWeight: FontWeight.w600,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // DISCLAIMER
            // ==========================================
            Positioned(
              left: width * 0.06,
              bottom: height * 0.045,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '* Selama persediaan masih ada.',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontSize: 5.5,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    '* Syarat dan ketentuan berlaku.',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontSize: 5.5,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    '* Gambar produk hanya sebagai referensi, '
                    'silakan merujuk pada produk yang sebenarnya.',
                    style: GoogleFonts.outfit(
                      color: Colors.black,
                      fontSize: 5.5,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// ==========================================
// BANNER 4: MONTHLY MEMBER GIFT
// ==========================================

class MonthlyGiftContent extends StatelessWidget {
  const MonthlyGiftContent({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Stack(
          children: [
            // ==========================================
            // MONTHLY MEMBER GIFT
            // ==========================================
            Positioned(
              top: height * 0.16,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  '— Monthly Member Gift —',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF211D1D),
                    fontSize: width * 0.038,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
            ),

            // ==========================================
            // DISKON
            // ==========================================
            Positioned(
              top: height * 0.23,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Diskon',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFF211D1D),
                    fontSize: width * 0.115,
                    fontWeight: FontWeight.w900,
                    height: 1,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),
            // ==========================================
            // ANGKA 10
            // ==========================================
            Positioned(
              top: height * 0.36,
              left: width * 0.23,
              width: width * 0.52,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.center,
                child: Text(
                  '10',
                  style: GoogleFonts.archivo(
                    color: const Color(0xFF211D1D),
                    fontSize: width * 0.29,
                    fontWeight: FontWeight.w900,
                    height: 0.85,
                    letterSpacing: -width * 0.02,
                  ),
                ),
              ),
            ),

            // ==========================================
            // BADGE %
            // ==========================================
            Positioned(
              top: height * 0.47,
              left: width * 0.63,
              child: SizedBox(
                width: width * 0.105,
                height: width * 0.105,
                child: ClipPath(
                  clipper: BurstBadgeClipper(),
                  child: Container(
                    color: const Color(0xFFFF5428),
                    child: Center(
                      child: Text(
                        '%',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF211D1D),
                          fontSize: width * 0.065,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ==========================================
            // SYARAT DAN KETENTUAN
            // ==========================================
            Positioned(
              left: width * 0.07,
              bottom: height * 0.055,
              child: Text(
                '* Syarat dan ketentuan berlaku.',
                style: GoogleFonts.outfit(
                  color: const Color(0xFF211D1D),
                  fontSize: width * 0.018,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ==========================================
// CUSTOM SHAPE BADGE PERSEN
// ==========================================

class BurstBadgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const points = 24;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final path = Path();

    for (int i = 0; i < points; i++) {
      final angle = (i * 2 * 3.141592653589793 / points) -
          3.141592653589793 / 2;

      final currentRadius = i.isEven ? radius : radius * 0.88;

      final x = center.dx + currentRadius * cos(angle);
      final y = center.dy + currentRadius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// ==========================================
// BAGIAN LANJUTAN HOME: LIMITED OFFERS
// ==========================================

class LimitedOffersSection extends StatelessWidget {
  const LimitedOffersSection({super.key});

  static const List<String> offerImages = [
    'assets/images/home/lo3.png',
    'assets/images/home/lo2.png',
    'assets/images/home/lo1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 10, bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Limited Offers',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEEEE),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.access_time_filled,
                      size: 12,
                      color: Color(0xFFFF5428),
                    ),
                    SizedBox(width: 4),
                    Text(
                      '18 : 43 : 56',
                      style: TextStyle(
                        color: Color(0xFFFF5428),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 124,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: offerImages.length + 1,
              separatorBuilder: (context, index) => const SizedBox(width: 9),
              itemBuilder: (context, index) {
                if (index < offerImages.length) {
                  return _LimitedOfferBanner(image: offerImages[index]);
                }

                return Container(
                  width: 88,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icon/panahkanan.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                            size: 35,
                          );
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF555555),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LimitedOfferBanner extends StatelessWidget {
  const _LimitedOfferBanner({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        image,
        width: 250,
        height: 124,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Colors.grey,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// BAGIAN LANJUTAN HOME: FOR YOU
// ==========================================

class ForYouSection extends StatelessWidget {
  const ForYouSection({super.key});

  static const List<Map<String, String>> products = [
    {
      'image': 'assets/images/home/for you1.png',
      'name': 'Master S.O.E\n- Americano',
      'price': 'Rp 30.000',
    },
    {
      'image': 'assets/images/home/for you2.png',
      'name': 'Master S.O.E\n- Latte',
      'price': 'Rp 32.000',
    },
    {
      'image': 'assets/images/home/for you3.png',
      'name': 'Master S.O.E\n- Breve Latte',
      'price': 'Rp 37.000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 3, bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'For You',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 235,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 13),
              itemBuilder: (context, index) {
                final product = products[index];

                return Container(
                  width: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFDFF),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.025),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 140,
                        height: 132,
                        child: Image.asset(
                          product['image']!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const ColoredBox(
                              color: Color(0xFFECECEC),
                              child: Center(
                                child: Icon(
                                  Icons.local_cafe_outlined,
                                  color: Colors.grey,
                                  size: 35,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 8, 8, 0),
                        child: Text(
                          product['name']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.25,
                            color: Color(0xFF292929),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 0, 8, 12),
                        child: Text(
                          product['price']!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF222222),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// BAGIAN LANJUTAN HOME: MISSION
// ==========================================

class MissionSection extends StatelessWidget {
  const MissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    const textDark = Color(0xFF202020);
    const progressOrange = Color(0xFFFF9E00);
    const buttonOrange = Color(0xFFEF602F);

    const boldStyle = TextStyle(
      fontFamily: 'HomeRubik',
      fontWeight: FontWeight.w700,
      color: textDark,
      letterSpacing: 0,
    );

    return ColoredBox(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 18, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mission',
              style: boldStyle.copyWith(
                fontSize: 17,
                height: 1.2,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/home/mission.png',
                  width: 56,
                  height: 56,
                  fit: BoxFit.contain,
                  semanticLabel: '50 Points',
                ),
                const SizedBox(width: 9),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete personal information',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: boldStyle.copyWith(fontSize: 14, height: 1.2),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                              child: LinearProgressIndicator(
                                value: 2 / 3,
                                minHeight: 7,
                                backgroundColor: Color(0xFFF3F3F3),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  progressOrange,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Text.rich(
                            TextSpan(
                              children: const [
                                TextSpan(
                                  text: '2',
                                  style: TextStyle(color: progressOrange),
                                ),
                                TextSpan(
                                  text: '/3',
                                  style: TextStyle(color: Color(0xFF999999)),
                                ),
                              ],
                            ),
                            style: boldStyle.copyWith(fontSize: 13, height: 1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 26),
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Halaman Mission belum dihubungkan.'),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: buttonOrange,
                    backgroundColor: Colors.white,
                    fixedSize: const Size(51, 28),
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.standard,
                    side: const BorderSide(color: buttonOrange, width: 1.4),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    'GO',
                    style: boldStyle.copyWith(
                      fontSize: 13,
                      height: 1,
                      color: buttonOrange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// BAGIAN LANJUTAN HOME: TOMORO HIGHLIGHT
// ==========================================

class TomoroHighlightSection extends StatelessWidget {
  const TomoroHighlightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 2, 14, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOMORO Highlight',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 13),
          ClipRRect(
            borderRadius: BorderRadius.circular(11),
            child: Image.asset(
              'assets/images/home/tomoro higlight.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  height: 180,
                  child: Center(
                    child: Text('Gambar TOMORO Highlight tidak ditemukan'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
