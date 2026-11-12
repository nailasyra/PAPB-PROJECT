import 'dart:async';

import 'package:flutter/material.dart';

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

  final PageController _pageController =
      PageController(initialPage: initialPage);

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

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        if (!_pageController.hasClients) return;

        _pageController.animateToPage(
          currentPage + 1,
          duration: const Duration(milliseconds: 1100),
          curve: Curves.easeInOutCubic,
        );
      },
    );
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
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
        child: Stack(
          children: [
            // BACKGROUND
            Positioned.fill(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                switchInCurve: Curves.easeInOutCubic,
                switchOutCurve: Curves.easeInOutCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
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
                children: List.generate(
                  bannerImages.length,
                  (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: currentIndex == index ? 18 : 5,
                      height: 8,
                      decoration: BoxDecoration(
                        color: currentIndex == index
                            ? Colors.white
                            : Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    );
                  },
                ),
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
      padding: const EdgeInsets.all(20),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF9E8C75),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Lv.1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 7),

              const Text(
                '5% Cashback',
                style: TextStyle(fontSize: 11, color: Color(0xFF777777)),
              ),

              const Spacer(),

              const Icon(
                Icons.confirmation_num,
                color: Color(0xFFFF5722),
                size: 21,
              ),

              const SizedBox(width: 5),

              const Text(
                '2',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),

              const SizedBox(width: 16),

              const Icon(
                Icons.monetization_on,
                color: Color(0xFFFFB000),
                size: 21,
              ),

              const SizedBox(width: 5),

              const Text(
                '0 pts',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 27),

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

          const SizedBox(height: 13),

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
            // GRAND OPENING - BAGIAN KIRI
            Positioned(
              top: height * 0.13,
              left: width * 0.10,
              width: width * 0.38,
              child: Column(
                children: [
                  const Text(
                    'GRAND',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),
                  const Text(
                    'OPENING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      height: 1,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const FittedBox(
                      child: Text(
                        'HELLO BENGKONG',
                        style: TextStyle(
                          color: Color(0xFFFF5428),
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // GARIS PEMISAH
            Positioned(
              top: height * 0.16,
              left: width * 0.50,
              height: height * 0.23,
              child: Container(width: 1, color: Colors.white70),
            ),

            // TANGGAL DAN LOKASI - BAGIAN KANAN
            Positioned(
              top: height * 0.15,
              left: width * 0.55,
              right: width * 0.06,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '07.11.2026',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),

                  const SizedBox(height: 0),

                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'SATURDAY · 9:00 WIB',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 0),

                  const Text(
                    'TOMORO COFFEE, Golden City Bengkong',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 7,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 3),

                  const Text(
                    'JL Golden Prawn Kecamatan, RT.005/RW.16, '
                    'Tj. Buntung,\n'
                    'Kec. Bengkong, Kota Batam, Kepulauan Riau 29432',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 6,
                      height: 1.3,
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
            // JUDUL EGG TART BUNDLES
            Positioned(
              top: height * 0.15,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  'EGG TART BUNDLES',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
            ),

            // PANEL PROMO
            Positioned(
              top: height * 0.245,
              left: width * 0.19,
              right: width * 0.19,
              height: height * 0.30,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEBDCC9),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // PROMO KIRI
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'BELI 2\nEGG TART',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              height: 1.05,
                            ),
                          ),

                          const Text(
                            'mulai dari',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                              children: [
                                TextSpan(
                                  text: '35',
                                  style: TextStyle(fontSize: 32),
                                ),
                                TextSpan(
                                  text: 'K',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Untuk pembelian di aplikasi TOMORO COFFEE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // GARIS PEMISAH
                    Container(
                      width: 2,
                      height: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          9,
                          (index) => Container(
                            width: 4,
                            height: 4,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'EGG TART',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                            ),
                          ),

                          const Text(
                            'mulai dari',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 7,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                              ),
                              children: [
                                TextSpan(
                                  text: '15',
                                  style: TextStyle(fontSize: 32),
                                ),
                                TextSpan(
                                  text: 'K',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Dengan pembelian minuman apa pun',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 4,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // KETERANGAN PROMO
            Positioned(
              left: width * 0.06,
              bottom: height * 0.055,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '* Selama persediaan masih ada.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '* Syarat dan ketentuan berlaku.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '* Gambar produk hanya sebagai referensi, '
                    'silakan merujuk pada produk yang sebenarnya.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 5,
                      fontWeight: FontWeight.w600,
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
            // MONTHLY MEMBER GIFT
            Positioned(
              top: height * 0.16,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  '— Monthly Member Gift —',
                  style: TextStyle(
                    color: Color(0xFF211D1D),
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            // TULISAN DISKON
            Positioned(
              top: height * 0.23,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  'Diskon',
                  style: TextStyle(
                    color: Color(0xFF211D1D),
                    fontSize: 43,
                    fontWeight: FontWeight.w900,
                    height: 1,
                    letterSpacing: -1,
                  ),
                ),
              ),
            ),

            // ANGKA 10
            Positioned(
              top: height * 0.32,
              left: width * 0.27,
              child: const Text(
                '10',
                style: TextStyle(
                  color: Color(0xFF211D1D),
                  fontSize: 110,
                  fontWeight: FontWeight.w900,
                  height: 0.95,
                  letterSpacing: -8,
                ),
              ),
            ),

            // SIMBOL PERSEN
            Positioned(
              top: height * 0.47,
              left: width * 0.60,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFFF5428),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '%',
                    style: TextStyle(
                      color: Color(0xFF211D1D),
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),

            // SYARAT DAN KETENTUAN
            Positioned(
              left: width * 0.07,
              bottom: height * 0.055,
              child: const Text(
                '* Syarat dan ketentuan berlaku.',
                style: TextStyle(
                  color: Color(0xFF211D1D),
                  fontSize: 7,
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
