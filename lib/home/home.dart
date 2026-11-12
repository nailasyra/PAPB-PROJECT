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
              PhotoCarousel(),
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
      child: const MemberSection(),
    );
  }
}

class PhotoCarousel extends StatefulWidget {
  const PhotoCarousel({super.key});

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  static const int initialPage = 10000;

  final PageController _controller = PageController(initialPage: initialPage);

  int currentPage = initialPage;
  int currentIndex = 0;

  Timer? _timer;

  final List<String> photos = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
  ];

  @override
  void initState() {
    super.initState();
    startAutoPlay();
  }

  void startAutoPlay() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (!_controller.hasClients) return;

      _controller.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 900),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
      currentIndex = index % photos.length;
    });

    startAutoPlay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 290,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                final photoIndex = index % photos.length;

                return Image.asset(
                  photos[photoIndex],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('Foto tidak ditemukan'));
                  },
                );
              },
            ),

            // INDIKATOR CAROUSEL
            Positioned(
              right: 20,
              bottom: 40,
              child: Row(
                children: List.generate(
                  photos.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: currentIndex == index ? 24 : 7,
                    height: 6,
                    decoration: BoxDecoration(
                      color: currentIndex == index
                          ? Colors.white
                          : Colors.black26,
                      borderRadius: BorderRadius.circular(20),
                    ),
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

class MemberSection extends StatelessWidget {
  const MemberSection({super.key});

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
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF777777),
                ),
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
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
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                ),
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
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          // PROMO CARDS
          Row(
            children: const [
              Expanded(
                child: FirstCupCard(),
              ),

              SizedBox(width: 12),

              Expanded(
                child: SuperValueCard(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// FIRST CUP PROMO
// ==========================================

class FirstCupCard extends StatelessWidget {
  const FirstCupCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F2),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'First Cup',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 3),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 29,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFF512D),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 2, left: 2),
                    child: Text(
                      'OFF',
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF512D),
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              const Text(
                'Order Now  ›',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Positioned(
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.local_cafe,
              color: Color(0xFFFF512D),
              size: 38,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SUPER VALUE PROMO
// ==========================================

class SuperValueCard extends StatelessWidget {
  const SuperValueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4F2),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Super Value',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 7),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Rp',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF512D),
                    ),
                  ),

                  const Text(
                    '1K',
                    style: TextStyle(
                      fontSize: 28,
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFFF512D),
                    ),
                  ),

                  const SizedBox(width: 4),

                  Text(
                    '30K',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              const Text(
                'Buy Now  ›',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const Positioned(
            right: 0,
            bottom: 0,
            child: Icon(
              Icons.confirmation_num,
              color: Color(0xFFFF512D),
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}


class ExploreMore extends StatelessWidget {
  const ExploreMore({super.key});

  final List<Map<String, dynamic>> menus = const [
    {
      'title': 'Referral',
      'icon': Icons.people_outline,
    },
    {
      'title': 'Monthly\nPromo',
      'icon': Icons.shopping_bag_outlined,
    },
    {
      'title': 'Spin & Win',
      'icon': Icons.casino_outlined,
    },
    {
      'title': 'Mission',
      'icon': Icons.assignment_outlined,
    },
    {
      'title': 'Voucher',
      'icon': Icons.confirmation_number_outlined,
    },
    {
      'title': 'Rewards',
      'icon': Icons.card_giftcard_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        top: 5,
        bottom: 15,
      ),
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
              separatorBuilder: (context, index) =>
                  const SizedBox(width: 5),
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
                          color: Color.fromARGB(239, 235, 230, 230),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          menu['icon'],
                          size: 32,
                          color: const Color(0xFF444444),
                        ),
                      ),

                      const SizedBox(height: 7),

                      Text(
                        menu['title'],
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

