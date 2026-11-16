
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    'logo': 'assets/images/icon/monthly_promo.svg',
    'icon': null,
    'type': 'banner',
    'products': [],
  },
  {
    'category': 'MASTER S.O.E SERIES',
    'label': 'MASTER\nS.O.E\nSERIES',
    'badge': 'CHAMPION',
    'logo': 'assets/images/icon/soe.svg',
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
    'logo': 'assets/images/icon/triple_pistachio.svg',
    'banner': 'assets/images/banners/triple_pistachio_banner.png',
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
    'logo': '',
    'icon': null,
    'products': [
      {
        'name': 'Tomoro Signature',
        'price': 'Rp 25.000',
        'image': '',
      },
    ],
  },
  {
    'category': 'BLACK COFFEE',
    'label': 'BLACK\nCOFFEE',
    'badge': '',
    'logo': '',
    'icon': null,
    'products': [
      {
        'name': 'Americano',
        'price': 'Rp 18.000',
        'image': '',
      },
    ],
  },
  {
    'category': 'MILK BASED COFFEE',
    'label': 'MILK\nBASED\nCOFFEE',
    'badge': '',
    'logo': '',
    'icon': null,
    'products': [
      {
        'name': 'Cafe Latte',
        'price': 'Rp 23.000',
        'image': '',
      },
    ],
  },
  {
    'category': 'FLAVOURED DRINKS',
    'label': 'FLAVO\nURED\nDRINKS',
    'badge': '',
    'logo': '',
    'icon': null,
    'products': [
      {
        'name': 'Chocolate Drink',
        'price': 'Rp 22.000',
        'image': '',
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const MenuHeader(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SIDEBAR KIRI
                SizedBox(
                  width: 84,
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
                              title: category['category'],
                              products: products,
                              onProductTap: widget.onProductTap,
                              isBanner: category['category'] == 'MONTHLY PROMO',
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
                flex: 3,
                child: Container(
                  height: 43,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F1F1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Text(
                            'Pickup',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF303030),
                            ),
                          ),
                        ),
                      ),

                      const Expanded(
                        child: Center(
                          child: Text(
                            'Delivery',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF555555),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // SEARCH
              Expanded(
                flex: 2,
                child: Container(
                  height: 43,
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
                        size: 25,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 15,
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
            children: [
              // LOGO RUKO SVG
              _StoreIcon(),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Ruko Panam',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF292929),
                  ),
                ),
              ),

              Icon(
                Icons.chevron_right,
                color: Color(0xFFCCCCCC),
                size: 28,
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
      width: 30,
      height: 30,
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
    '',
    '',
    '',
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
                    child: _NetworkImage(
                      imageUrl: banners[index],
                      fit: BoxFit.cover,
                      width: double.infinity,
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
class CategorySidebar extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          final isSelected = selectedIndex == index;
          final String badge =
              category['badge'] as String? ?? '';
          final String label =
              category['label'] as String? ?? '';
          final String logo =
              category['logo'] as String? ?? '';
          final dynamic icon = category['icon'];

          return InkWell(
            onTap: () => onCategoryTap(index),
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
                    // Badge kategori
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

                    // Logo SVG kategori
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
                        ),
                      )

                    // Icon berupa path SVG
                    else if (isSelected &&
                        icon is String &&
                        icon.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: SvgPicture.asset(
                          icon,
                          width: 28,
                          height: 28,
                          fit: BoxFit.contain,
                        ),
                      )

                    // Icon berupa Material Icon
                    else if (isSelected && icon is IconData)
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                        ),
                        child: Icon(
                          icon,
                          size: 32,
                          color: const Color(0xFFD99A43),
                        ),
                      ),

                    // Nama kategori
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
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
  final bool isBanner;

  const CategorySection({
    super.key,
    required this.title,
    required this.products,
    this.onProductTap,
    this.isBanner = false,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF292929),
              letterSpacing: 0.2,
            ),
          ),

          const SizedBox(height: 18),

          // TAMPILAN MONTHLY PROMO
          if (isBanner)
            const BannerCarousel()
          else
            // DAFTAR PRODUK BIASA
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
          vertical: 12,
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // GAMBAR PRODUK
            SizedBox(
              width: 105,
              height: 125,
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
                      fontSize: 16,
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF222222),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),

            // TOMBOL PLUS VISUAL SAJA
            const Padding(
              padding: EdgeInsets.only(left: 5),
              child: Icon(
                Icons.add_circle,
                size: 43,
                color: Color(0xFFFFA500),
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
