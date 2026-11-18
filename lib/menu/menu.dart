
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ======================================================
// MENU DATA
// Ganti URL gambar sesuai gambar yang kamu miliki.
// URL gambar harus berupa direct HTTPS image URL.
// ======================================================


const List<Map<String, dynamic>> menuData = [
  {
    'category': 'MONT BLANC SERIES',
    'label': 'MONT\nBLANC\nSERIES',
    'badge': 'NEW',
    'logo': 'assets/images/icon/mont_series.svg',
    'icon': null,
    'products': [
      {
        'name': 'Choco Mont Blanc',
        'price': 'Rp 29.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-509bfe3e/photo/798068eb0de594b.webp',
      },
      {
        'name': 'Mocha Mont Blanc',
        'price': 'Rp 28.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-0b3f7afb/photo/47e7ff4587559967.webp',
      },
    ],
  },
  {
    'category': 'MONTHLY PROMO',
    'label': 'MONTHLY\nPROMO',
    'badge': '',
    'logo': 'assets/images/icon/promo.svg',
    'banner': 'assets/images/backgrounds/montly_promo_menu.jpeg',
    'icon': null,
    'type': 'banner',
    'products': [],
  },
  {
    'category': 'MASTER S.O.E SERIES',
    'label': 'MASTER\nS.O.E\nSERIES',
    'badge': 'CHAMPION',
    'logo': 'assets/images/icon/seo.svg',
    'icon': null,
    'products': [
      {
        'name': 'Master S.O.E - Americano',
        'price': 'Rp 28.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-88ff3e01/photo/3f0e272ef8e776d0.webp',
      },
      {
        'name': 'Master S.O.E - Latte',
        'price': 'Rp 30.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-88ff3e01/photo/3f0e272ef8e776d0.webp',
      },
    ],
  },
  {
    'category': 'TRIPLE PISTACHIO SERIES',
    'label': 'TRIPLE\nPISTACHIO\nSERIES',
    'badge': '',
    'logo': 'assets/images/icon/pistacio.svg',
    'banner': 'assets/images/backgrounds/glowInTheDark.jpeg',
    'icon': null,
    'products': [
      {
        'name': 'Triple Dubai Pistachio Chocolate',
        'price': 'Rp 32.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-03e2f9e2/photo/85154b82e554d0bc.webp',
      },
      {
        'name': 'Triple Pistachio Latte',
        'price': 'Rp 29.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-046b9919/photo/80d10ca8e3deaa8c.webp',
      },
      {
        'name': 'Triple Pistachio Matcha',
        'price': 'Rp 32.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-4152baec/photo/be780575e1221eaf.webp',
      },
    ],
  },
  {
    'category': 'TOMORO SIGNATURE',
    'label': 'TOMORO\nSIGNATURE',
    'badge': '',
    'logo': 'assets/images/icon/member.svg',
    'icon': null,
    'products': [
      {
        'name': 'Tomoro Aren Latte',
        'price': 'Rp 21.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-a234ab61/photo/699b5c0f99ba7085.webp',
      },
      {
        'name': 'Matcha Latte',
        'price': 'Rp 21.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-328113ae/photo/4364d930caa5d444.webp',
      },
      {
        'name': 'Caffe Latte',
        'price': 'Rp 24.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-3d1210d7/photo/4792dc90d0bd522f.webp',
      },
    ],
  },
  {
    'category': 'BLACK COFFEE',
    'label': 'BLACK\nCOFFEE',
    'badge': '',
    'logo': 'assets/images/icon/coffee.svg',
    'icon': null,
    'products': [
      {
        'name': 'Caffe Americano',
        'price': 'Rp 18.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-9ec00439/photo/1d6fbb071c0fc64e.webp',
      },
      {
        'name': 'Strawberry Americano',
        'price': 'Rp 19.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-08b8b88b/photo/861a8ea082240786.webp',
      },
      {
        'name': 'Peach Americano',
        'price': 'Rp 19.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-9623e905/photo/f5c586abd72e9f8a.webp',
      },
    ],
  },
  {
    'category': 'MILK BASED COFFEE',
    'label': 'MILK\nBASED\nCOFFEE',
    'badge': '',
    'logo': 'assets/images/icon/milk.svg',
    'icon': null,
    'products': [
      {
        'name': 'TOMORO Oat Latte',
        'price': 'Rp 23.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-a3af3383/photo/9a2e27619d12a401.webp',
      },
      {
        'name': 'Caramel Macchiato salted Cloud',
        'price': 'Rp 29.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-00d22335/photo/48a12e4cd2598cf4.webp',
      },
      {
        'name': 'Caramel Cheese Latte',
        'price': 'Rp 23.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-2b06a683/photo/f7bc4e2c88b552c2.webp',
      },
    ],
  },
  {
    'category': 'FLAVOURED DRINKS',
    'label': 'FLAVO\nURED\nDRINKS',
    'badge': '',
    'logo': '',
    'icon': Icons.coffee_outlined,
    'products': [
      {
        'name': 'Matcha Oat Latte',
        'price': 'Rp 30.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-6f727fb3/photo/e5dd2c47ecf867c1.webp',
      },
      {
        'name': 'Matcha Salted Cloud',
        'price': 'Rp 30.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-77c25ee8/photo/8136b37d518923e3.webp',
      },
      {
        'name': 'Chocolate Salted Cloud',
        'price': 'Rp 30.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-edad60e5/photo/cb60faa70757123.webp',
      },
    ],
  },
  {
    'category': 'TEA SERIES',
    'label': 'TEA\nSERIES',
    'badge': '',
    'logo': '',
    'icon': Icons.local_drink_outlined,
    'products': [
      {
        'name': 'Peach Jasmine Tea',
        'price': 'Rp 19.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-b6338744/photo/bc0c11764a3c2bbc.webp',
      },
      {
        'name': 'Strawberry Jasmine Tea',
        'price': 'Rp 19.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-172a6ccb/photo/c885419417e57c52.webp',
      },
      {
        'name': 'Chocolate Salted Cloud',
        'price': 'Rp 19.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-681d16fb/photo/59876fae968f956e.webp',
      },
    ],
  },
  {
    'category': 'FOOD',
    'label': 'FOOD',
    'badge': '',
    'logo': '',
    'icon': Icons.breakfast_dining_outlined,
    'products': [
      {
        'name': 'Butter Croissant',
        'price': 'Rp 16.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-046d6fb2/photo/69a87fd6e8ec4692.webp',
      },
      {
        'name': 'Choco Denish',
        'price': 'Rp 20.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-3842eaf0/photo/8e516236c481dff7.webp',
      },
      {
        'name': 'Cinamon Roll',
        'price': 'Rp 18.000',
        'image': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-771870d7/photo/e241d6d6a85c81.webp',
      },
    ],
  },
];

// ======================================================
// MENU PAGE
// Halaman utama menu TOMORO
// ======================================================

class MenuPage extends StatefulWidget {
  // Callback untuk menghubungkan produk ke halaman detail
  final ValueChanged<Map<String, String>>? onProductTap;

  const MenuPage({
    super.key,
    this.onProductTap,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _contentKey = GlobalKey();
  int selectedCategory = 0;
  late final List<GlobalKey> sectionKeys;
  List<String> get categories => menuData
      .map((item) => item['category'] as String)
      .toList();

  @override
  void initState() {
    super.initState();

    sectionKeys = List.generate(
      menuData.length,
      (index) => GlobalKey(),
    );
    _scrollController.addListener(_onScroll);
  }

  // ====================================================
  // DETEKSI KATEGORI BERDASARKAN POSISI SCROLL
  // ====================================================

  void _onScroll() {
    final contentContext = _contentKey.currentContext;
    if (contentContext == null) return;
    final contentObject = contentContext.findRenderObject();
    if (contentObject is! RenderBox) return;
    final contentTop =
        contentObject.localToGlobal(Offset.zero).dy;
    final threshold = contentTop + 25;
    int activeIndex = 0;
    for (int i = 0; i < sectionKeys.length; i++) {
      final sectionContext = sectionKeys[i].currentContext;
      if (sectionContext == null) continue;
      final sectionObject = sectionContext.findRenderObject();
      if (sectionObject is! RenderBox) continue;
      final sectionTop =
          sectionObject.localToGlobal(Offset.zero).dy;
      if (sectionTop <= threshold) {
        activeIndex = i;
      }
    }

    if (selectedCategory != activeIndex && mounted) {
      setState(() {
        selectedCategory = activeIndex;
      });
    }
  }

  // ====================================================
  // KLIK KATEGORI SIDEBAR
  // ====================================================

  void _selectCategory(int index) {
    final context = sectionKeys[index].currentContext;

    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      alignment: 0.0,
    );

    setState(() {
      selectedCategory = index;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    super.dispose();
  }

  @override
 
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle.merge(
      style: GoogleFonts.lexend(),
      child: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              const MenuHeader(),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SIDEBAR KIRI
                    SizedBox(
                      width: 76,
                      child: CategorySidebar(
                        categories: menuData,
                        selectedIndex: selectedCategory,
                        onCategoryTap: _selectCategory,
                      ),
                    ),

                    // KONTEN KANAN
                    Expanded(
                      child: SingleChildScrollView(
                        key: _contentKey,
                        controller: _scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // BANNER CAROUSEL
                            const BannerCarousel(),

                            // SELURUH KATEGORI PRODUK
                            ...List.generate(
                              menuData.length,
                              (index) {
                                final category = menuData[index];

                                final products =
                                    (category['products'] as List)
                                        .map(
                                          (item) =>
                                              Map<String, String>.from(item),
                                        )
                                        .toList();

                                return CategorySection(
                                  key: sectionKeys[index],
                                  title: category['category'] as String,
                                  products: products,
                                  onProductTap: widget.onProductTap,
                                  bannerImage: category['banner'] as String?,
                                );
                              },
                            ),
                          ],
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
    );
  }
}


// ======================================================
// HEADER
// PICKUP - DELIVERY - SEARCH - LOCATION
// ======================================================

class MenuHeader extends StatelessWidget {
  const MenuHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(17, 15, 17, 18),
      child: Column(
        children: [
          // PICKUP DAN DELIVERY + SEARCH
          Row(
            children: [
              // PICKUP / DELIVERY
              Expanded(
                flex: 5,
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 1,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Text(
                              'Pickup',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF303030),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // JARAK ANTARA DELIVERY DAN SEARCH
              const Spacer(flex: 2),

              // SEARCH
              Expanded(
                flex: 3,
                child: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7F7F7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xFF999999),
                        size: 23,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          // LOKASI TOKO
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // LOGO RUKO SVG
              _StoreIcon(),
              SizedBox(width: 12),

              Text(
                'Ruko Panam',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF292929),
                ),
              ),

              SizedBox(width: 4),

              Icon(
                Icons.chevron_right,
                color: Color(0xFFCCCCCC),
                size: 23,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// LOGO RUKO
class _StoreIcon extends StatelessWidget {
  const _StoreIcon();

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/icon/ruko.svg',
      width: 21,
      height: 21,
      fit: BoxFit.contain,
    );
  }
}


// ======================================================
// BANNER CAROUSEL
// ======================================================


class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  int currentPage = 0;

  // MASUKKAN LINK BANNER DI SINI
  final List<String> banners = [
    'assets/images/backgrounds/menu_benner_1.jpeg',
    'assets/images/backgrounds/menu_benner_2.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: SizedBox(
        height: 190,
        child: Stack(
          children: [
            // GAMBAR CAROUSEL
            PageView.builder(
              itemCount: banners.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      banners[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint('Gagal memuat banner: $error');
                        return const Icon(Icons.broken_image_outlined);
                      },
                    ),
                  ),
                );
              },
            ),

            // INDIKATOR SLIDE DI KANAN BAWAH
            Positioned(
              right: 25,
              bottom: 18,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  banners.length,
                  (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(left: 5),
                      width: currentPage == index ? 23 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: currentPage == index
                            ? const Color(0xFFF15A24)
                            : const Color(0xFFE5E5E5),
                        borderRadius: BorderRadius.circular(10),
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

// ======================================================
// SIDEBAR KATEGORI
// ======================================================

class CategorySidebar extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final int selectedIndex;
  final Function(int) onCategoryTap;

  const CategorySidebar({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategoryTap,
  });

  @override
  State<CategorySidebar> createState() => _CategorySidebarState();
}

class _CategorySidebarState extends State<CategorySidebar> {
  late List<GlobalKey> itemKeys;

  @override
  void initState() {
    super.initState();

    itemKeys = List.generate(
      widget.categories.length,
      (index) => GlobalKey(),
    );
  }

  // OTOMATIS MENGIKUTI KATEGORI AKTIF
  @override
  void didUpdateWidget(covariant CategorySidebar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Perbarui key jika jumlah kategori berubah
    if (oldWidget.categories.length != widget.categories.length) {
      itemKeys = List.generate(
        widget.categories.length,
        (index) => GlobalKey(),
      );
    }

    // Geser sidebar ketika kategori aktif berubah
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        if (widget.selectedIndex < 0 ||
            widget.selectedIndex >= itemKeys.length) {
          return;
        }

        final selectedContext =
            itemKeys[widget.selectedIndex].currentContext;

        if (selectedContext != null) {
          Scrollable.ensureVisible(
            selectedContext,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: 0.35,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 76,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          final category = widget.categories[index];

          final isSelected = widget.selectedIndex == index;

          final String badge =
              category['badge'] as String? ?? '';

          final String label =
              category['label'] as String? ?? '';

          final String logo =
              category['logo'] as String? ?? '';

          final dynamic icon = category['icon'];

          return InkWell(
            key: itemKeys[index],
            onTap: () => widget.onCategoryTap(index),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 112,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white
                    : const Color(0xFFFAFAFA),
                border: Border(
                  left: BorderSide(
                    color: isSelected
                        ? const Color(0xFFD99A43)
                        : Colors.transparent,
                    width: 4,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // BADGE KATEGORI
                    if (badge.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 6,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE99A32),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    // LOGO SVG KATEGORI
                    if (isSelected && logo.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: SvgPicture.asset(
                          logo,
                          width: 30,
                          height: 25,
                          fit: BoxFit.contain,
                          colorFilter:
                              category['category'] ==
                                      'TOMORO SIGNATURE'
                                  ? const ColorFilter.mode(
                                      Color.fromARGB(
                                        255,
                                        255,
                                        184,
                                        103,
                                      ),
                                      BlendMode.srcIn,
                                    )
                                  : null,
                        ),
                      )

                    // ICON BERUPA PATH SVG
                    else if (isSelected &&
                        icon is String &&
                        icon.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: SvgPicture.asset(
                          icon,
                          width: 25,
                          height: 25,
                          fit: BoxFit.contain,
                        ),
                      )

                    // ICON MATERIAL
                    else if (isSelected && icon is IconData)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Icon(
                          icon,
                          size: 25,
                          color: const Color(0xFFD99A43),
                        ),
                      ),

                    // NAMA KATEGORI
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10,
                        height: 1.3,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFFD99A43)
                            : const Color(0xFF777777),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



// ======================================================
// CATEGORY SECTION
// ======================================================

class CategorySection extends StatelessWidget {
  final String title;
  final List<Map<String, String>> products;
  final ValueChanged<Map<String, String>>? onProductTap;
  final String? bannerImage;

  const CategorySection({
    super.key,
    required this.title,
    required this.products,
    this.onProductTap,
    this.bannerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // JUDUL KATEGORI
          Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xFF292929),
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 18),

          // GAMBAR BANNER STATIS
          if (bannerImage != null && bannerImage!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                bannerImage!,
                width: double.infinity,
                height: 130,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 130,
                    color: const Color(0xFFF5F5F5),
                    child: const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                        size: 35,
                        color: Color(0xFFCCCCCC),
                      ),
                    ),
                  );
                },
              ),
            )

          // DAFTAR PRODUK BIASA
          else
            ...products.map(
              (product) => ProductCard(
                name: product['name'] ?? '',
                price: product['price'] ?? '',
                imageUrl: product['image'] ?? '',
                onTap: () => onProductTap?.call(product),
              ),
            ),
        ],
      ),
    );
  }
}


// ======================================================
// PRODUCT CARD
// ======================================================

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GAMBAR PRODUK
            SizedBox(
              width: 85,
              height: 100,
              child: _NetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(width: 10),

            // NAMA DAN HARGA
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 51, 51, 51),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // TOMBOL PLUS VISUAL SAJA
            SizedBox(
              height: 100,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: const Padding(
                  padding: EdgeInsets.only(left: 5, bottom: 15),
                  child: Icon(
                    Icons.add_circle,
                    size: 27,
                    color: Color(0xFFFFA500),
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


// ======================================================
// NETWORK IMAGE
// Menangani URL kosong atau gambar gagal dimuat
// ======================================================

class _NetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;

  const _NetworkImage({
    required this.imageUrl,
    required this.fit,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(imageUrl);

    final validUrl = uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;

    if (!validUrl) {
      return Container(
        width: width,
        color: const Color(0xFFF5F5F5),
        child: const Center(
          child: Icon(
            Icons.image_outlined,
            size: 35,
            color: Color(0xFFCCCCCC),
          ),
        ),
      );
    }

    return Image.network(
      imageUrl,
      width: width,
      fit: fit,

      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          color: const Color(0xFFF5F5F5),
          child: const Center(
            child: Icon(
              Icons.broken_image_outlined,
              size: 35,
              color: Color(0xFFCCCCCC),
            ),
          ),
        );
      },
    );
  }
}
