import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _C {
  static const Color chipText = Color(0xFFD97601); // teks pilihan aktif
  static const Color chipBg = Color(0xFFFEF6EB); // bg pilihan aktif
  static const Color chipBorder = Color(0xFFFBECD9);
  static const Color plus = Color(0xFFFF9C00); // tombol + terisi
  static const Color plusOutline = Color(0xFFEBA045); // tombol + outline
  static const Color plusDisabled = Color(0xFFF7E3CA); // + saat batas add on tercapai
  static const Color plusUnavailable = Color(0xFFE6E6E6); // + saat add on habis/tidak tersedia
  static const Color rippleBlue = Color(0x334A90E2); // efek sentuh (biru muda, seperti di video)
  static const Color cta = Color(0xFFFF5524); // tombol Add to Cart
  static const Color grey = Color(0xFFF8F8F8); // bg chip / row / band
  static const Color divider = Color(0xFFDEDEDE);
  static const Color title = Color(0xFF212121);
  static const Color label = Color(0xFF323232);
  static const Color body = Color(0xFF656565); // teks chip & add on
  static const Color desc = Color(0xFF989898);
  static const Color disabledText = Color(0xFFCFCFCF);
  static const Color recoBg = Color(0xFFFFF9F2);
}

TextStyle _font(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = _C.body,
  double? height,
  TextDecoration? decoration,
}) {
  return GoogleFonts.lexend(
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
    decoration: decoration,
  );
}

// ---------------------------------------------------------------------
// Model data
// ---------------------------------------------------------------------
class OptionItem {
  final String label;
  final int extraPrice;
  final bool available;
  const OptionItem(this.label, {this.extraPrice = 0, this.available = true});
}

enum GroupStyle { chips, cupCards }

/// Satu kelompok pilihan, misalnya CupSize / Temperature / Milk / Topping.
class OptionGroup {
  final String title;
  final List<OptionItem> options;
  final int initial; // index pilihan awal
  final int columns; // jumlah kolom grid (3 = CupSize/Temperature, 2 = Milk/Topping)
  final GroupStyle style;

  const OptionGroup({
    required this.title,
    required this.options,
    this.initial = 0,
    this.columns = 3,
    this.style = GroupStyle.chips,
  });
}

class AddOnItem {
  final String name;
  final int price;
  final bool available;
  const AddOnItem(this.name, this.price, {this.available = true});
}

class AddOnSection {
  final String title;
  final List<AddOnItem> items;
  final int? beforeGroup;
  const AddOnSection({
    required this.title,
    required this.items,
    this.beforeGroup,
  });
}

class RecommendedItem {
  final String name;
  final String imageUrl;
  final int price;
  final int? oldPrice;
  const RecommendedItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    this.oldPrice,
  });
}

class MenuDetailData {
  final String name;
  final String description;
  final String imageUrl;
  final int basePrice;
  final bool bannerImage; // true = gambar lebar penuh (seperti Caffe Americano)
  final List<OptionGroup> groups;
  final String addOnTitle;
  final List<AddOnItem> addOns;
  final RecommendedItem? recommended;
  // Add on utama tampil sebelum group ke-N (null = paling bawah)
  final int? addOnPosition;
  // Section add on tambahan
  final List<AddOnSection> extraAddOns;

  const MenuDetailData({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.basePrice,
    required this.groups,
    required this.addOns,
    this.addOnTitle = 'Add On',
    this.bannerImage = false,
    this.recommended,
    this.addOnPosition,
    this.extraAddOns = const [],
  });

  MenuDetailData copyWith({
    String? description,
    String? imageUrl,
    int? basePrice,
    RecommendedItem? recommended,
  }) {
    return MenuDetailData(
      name: name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      basePrice: basePrice ?? this.basePrice,
      groups: groups,
      addOns: addOns,
      addOnTitle: addOnTitle,
      bannerImage: bannerImage,
      recommended: recommended ?? this.recommended,
      addOnPosition: addOnPosition,
      extraAddOns: extraAddOns,
    );
  }
}

class MenuCatalog {
  static const String _img =
      'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=600';

  static const Map<String, String> imageLinks = {
    // --- Mont Blanc ---
    'Choco Mont Blanc': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-509bfe3e/photo/798068eb0de594b.webp',
    'Mocha Mont Blanc': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-0b3f7afb/photo/47e7ff4587559967.webp',
    // --- Master S.O.E ---
    'Master S.O.E - Americano': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-88ff3e01/photo/3f0e272ef8e776d0.webp',
    'Master S.O.E - Latte': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-c5000d58/photo/f4f409388f03557b.webp',
    'Master S.O.E - Breve Latte': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-e1dbb041/photo/e34b901c0028ad58.webp',
    // --- Triple Pistachio ---
    'Triple Dubai Pistachio Chocolate': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-03e2f9e2/photo/85154b82e554d0bc.webp',
    // --- Tomoro Signature ---
    'TOMORO Aren Latte': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-a234ab61/photo/699b5c0f99ba7085.webp',
    // --- Black Coffee ---
    'Caffe Americano': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-9ec00439/photo/1d6fbb071c0fc64e.webp', // gambar banner lebar
    // --- Milk Based Coffee ---
    'Kopi Susu Aren': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-a3af3383/photo/9a2e27619d12a401.webp',
    // --- Flavoured Drinks ---
    'Peach Jasmine Tea': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-b6338744/photo/bc0c11764a3c2bbc.webp',
    // --- Tea Series ---
    'Matcha Latte': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-328113ae/photo/4364d930caa5d444.webp',
    'Matcha Oat Latte': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-6f727fb3/photo/e5dd2c47ecf867c1.webp',
    // --- Frappe ---
    'Strawberry Jasmine Smoothie': 'https://huawei-food-cms.grab.com/compressed_webp/items/url-172a6ccb/photo/c885419417e57c52.webp',
    // --- Gambar bagian "Recommended" ---
    'Glow In The Dark Sticker Bundle': '',
    'Daily Duo Bundle': '',
  };

  static String _link(String name, String fallback) {
    final v = (imageLinks[name] ?? '').trim();
    return v.isEmpty ? fallback : v;
  }

  static MenuDetailData _withLinks(MenuDetailData m) {
    final r = m.recommended;
    return m.copyWith(
      imageUrl: _link(m.name, m.imageUrl),
      recommended: r == null
          ? null
          : RecommendedItem(
              name: r.name,
              imageUrl: _link(r.name, r.imageUrl),
              price: r.price,
              oldPrice: r.oldPrice,
            ),
    );
  }

  // ----- Opsi yang dipakai berulang -----
  static const List<OptionItem> _cup2 = [
    OptionItem('Small'),
    OptionItem('Medium', extraPrice: 4000),
  ];
  static const List<OptionItem> _cup3 = [
    OptionItem('Small'),
    OptionItem('Medium', extraPrice: 4000),
    OptionItem('Jumbo', extraPrice: 8000), // harga tambahan: perkiraan
  ];
  static const List<OptionItem> _milk = [
    OptionItem('Master Milk'),
    OptionItem('Oat Milk', extraPrice: 6000, available: false),
    OptionItem('Coconut Milk', extraPrice: 6000),
  ];
  static const List<OptionItem> _topping = [
    OptionItem('No Topping'),
    OptionItem('Sea Salt Cloud', extraPrice: 6000, available: false),
    OptionItem('Cheese Cloud', extraPrice: 6000), // harga tambahan: perkiraan
    OptionItem('Whipping cream', extraPrice: 6000, available: false),
  ];
  static const List<OptionItem> _icedOnly = [OptionItem('Iced')];
  static const List<OptionItem> _icedHotDisabled = [
    OptionItem('Iced'),
    OptionItem('Hot', available: false),
  ];

  static const List<AddOnItem> _stdAddOns = [
    AddOnItem('Sugar Syrup', 0),
    AddOnItem('Additional Espresso Shot', 5000),
    AddOnItem('Caramel Sauce', 5000),
    AddOnItem('Vanilla Syrup', 5000),
    AddOnItem('Aren Syrup', 5000),
    AddOnItem('Caramel Syrup', 5000),
    AddOnItem('Manuka Honey Syrup', 5000, available: false),
  ];

  static MenuDetailData standardDrink({
    required String name,
    required String description,
    required String imageUrl,
    required int basePrice,
  }) {
    return MenuDetailData(
      name: name,
      description: description,
      imageUrl: imageUrl,
      basePrice: basePrice,
      groups: const [
        OptionGroup(
          title: 'CupSize',
          options: _cup2,
          style: GroupStyle.cupCards,
        ),
        OptionGroup(title: 'Temperature', options: _icedOnly),
        OptionGroup(
          title: 'Sweetness',
          columns: 2,
          options: [OptionItem('Normal Sweet'), OptionItem('Less Sweet')],
        ),
        OptionGroup(title: 'Milk', columns: 2, options: _milk),
      ],
      addOns: _stdAddOns,
    );
  }

  static final List<MenuDetailData> _list = [

    // ===== MONT BLANC SERIES =====

    // Choco Mont Blanc  (dari video)
    standardDrink(
      name: 'Choco Mont Blanc',
      description:
          'Pengalaman yang worth it buat dinikmati dalam sebuah cangkir, di mana cokelat premium\n'
          'lokal 100% ketemu susu creamy yang lembut, kasih rasa nyaman di tiap tegukan.\n'
          'Disempurnakan sama cloud foam jeruk yang pulpy dan cacao nibs yang kriuk, kasih\n'
          'sentuhan akhir yang segar dan nggak terduga, bikin momen nyoklat harianmu jadi makin\n'
          'worth it buat di nikmati',
      imageUrl: _img,
      basePrice: 29000,
    ),

    // Mocha Mont Blanc  (belum ada screenshot -> template standar)
    standardDrink(
      name: 'Mocha Mont Blanc',
      description: 'Mocha kesukaanmu, tapi naik kelas dan makin worth it untuk dibahas. Espresso yang bold bertemu cokelat premium lokal dan susu creamy yang lembut, menciptakan rasa yang menumpuk dan makin kaya di tiap tegukan. Semuanya disempurnakan dengan cloud foam jeruk yang pulpy dan cacao nibs yang renyah, memberi sentuhan citrus yang pas agar rasanya makin nendang.', // TODO: isi dari aplikasi asli
      imageUrl: _img,
      basePrice: 28000,
    ),

    // ===== MASTER S.O.E SERIES =====

    // Master S.O.E - Americano  (tanpa CupSize, ada Hot, add on khusus)
    const MenuDetailData(
      name: 'Master S.O.E - Americano',
      description:
          'Perpaduan sempurna antara kesegaran citrus yang cerah dan aroma floral khas melati, '
          'dilengkapi tekstur yang lembut serta manis karamel yang bertahan lama, '
          'menghadirkan pengalaman kopi yang elegan dan menyenangkan.',
      imageUrl: _img,
      basePrice: 28000,
      groups: [
        OptionGroup(
          title: 'Temperature',
          options: [OptionItem('Iced'), OptionItem('Hot')],
          initial: 1, // default "Hot" seperti di aplikasi asli
        ),
      ],
      addOnTitle: 'Add - SOE Espresso Shot',
      addOns: [AddOnItem('Additional SOE Espresso Shot', 10000)],
    ),

    // Master S.O.E - Latte  (add on SOE tampil di antara Temperature dan Milk)
    const MenuDetailData(
      name: 'Master S.O.E - Latte',
      description:
          'Latte yang lembut dan seimbang dengan karakter buttery dan nutty cookie yang manis, '
          'diakhiri tekstur creamy yang halus. Tersedia dengan TOMORO Master Milk, Oat Milk, '
          'atau Coconut Milk.',
      imageUrl: _img,
      basePrice: 30000,
      groups: [
        OptionGroup(
          title: 'Temperature',
          options: [OptionItem('Iced'), OptionItem('Hot')],
          initial: 1,
        ),
        OptionGroup(title: 'Milk', columns: 2, options: _milk),
      ],
      addOnTitle: 'Add - SOE Espresso Shot',
      addOns: [AddOnItem('Additional SOE Espresso Shot', 10000)],
      addOnPosition: 1, // tampil sebelum group ke-1 (Milk)
    ),

    // Master S.O.E - Breve Latte
    const MenuDetailData(
      name: 'Master S.O.E - Breve Latte',
      description:
          'Latte kaya rasa dengan profil yang seimbang, diracik menggunakan Single Origin '
          'Espresso hasil kurasi kami. Menghadirkan manis yang lebih menonjol, tekstur creamy '
          'yang lembut, serta akhir rasa yang halus, menampilkan aroma dan karakter unik dari '
          'espresso pilihan.',
      imageUrl: _img,
      basePrice: 35000,
      groups: [
        OptionGroup(
          title: 'Temperature',
          options: [OptionItem('Iced'), OptionItem('Hot')],
          initial: 1,
        ),
      ],
      addOnTitle: 'Add - SOE Espresso Shot',
      addOns: [AddOnItem('Additional SOE Espresso Shot', 10000)],
    ),

    // ===== TRIPLE PISTACHIO SERIES =====

    // Triple Dubai Pistachio Chocolate  (ada Recommended)
    const MenuDetailData(
      name: 'Triple Dubai Pistachio Chocolate',
      description:
          'Dessert kekinian dalam satu gelas dengan perpaduan pistachio premium yang '
          'creamy-nutty dan cokelat premium lokal Indonesia. Dilengkapi pistachio foam '
          'yang lembut serta pistachio kunafa crunch yang renyah untuk sensasi rasa dan '
          'tekstur yang memanjakan.',
      imageUrl: _img,
      basePrice: 32000,
      groups: [
        OptionGroup(
          title: 'CupSize',
          options: _cup2,
          style: GroupStyle.cupCards,
        ),
        OptionGroup(title: 'Temperature', options: _icedOnly),
      ],
      addOns: _stdAddOns,
      recommended: RecommendedItem(
        name: 'Glow In The Dark Sticker Bundle',
        imageUrl: _img,
        price: 34000,
        oldPrice: 34000,
      ),
    ),

    // ===== TOMORO SIGNATURE =====

    // TOMORO Aren Latte  (Tomoro Signature)
    const MenuDetailData(
      name: 'TOMORO Aren Latte',
      description:
          'Kopi susu favorit kita hanya menggunakan 100% kopi arabika, gula aren lokal dan '
          'susu segar. Sudah pasti favorit semua orang.',
      imageUrl: _img,
      basePrice: 21000,
      groups: [
        OptionGroup(title: 'CupSize', options: _cup3),
        OptionGroup(
          title: 'Temperature',
          options: [OptionItem('Iced'), OptionItem('Hot')],
        ),
        OptionGroup(
          title: 'Sweetness',
          columns: 2,
          options: [OptionItem('Normal Sweet'), OptionItem('Less Sweet')],
        ),
        OptionGroup(title: 'Milk', columns: 2, options: _milk),
        OptionGroup(title: 'Topping', columns: 2, options: _topping),
      ],
      addOns: _stdAddOns,
    ),

    // ===== BLACK COFFEE =====

    // Caffe Americano  (gambar banner lebar + Recommended)
    const MenuDetailData(
      name: 'Caffe Americano',
      description:
          'Rasa espresso yang kaya di tuangkan ke air panas, mempertahankan crema kopi '
          'sempurna di cangkir dengan cita rasa cokelat hazelnut dan gula merah.',
      imageUrl: _img,
      basePrice: 18000,
      bannerImage: true,
      groups: [
        OptionGroup(title: 'CupSize', options: _cup3),
        OptionGroup(title: 'Temperature', options: _icedHotDisabled),
        OptionGroup(title: 'Topping', columns: 2, options: _topping),
      ],
      addOns: _stdAddOns,
      recommended: RecommendedItem(
        name: 'Daily Duo Bundle',
        imageUrl: _img,
        price: 29000,
        oldPrice: 36000,
      ),
    ),

    // ===== MILK BASED COFFEE =====

    // Kopi Susu Aren  (di aplikasi asli tidak ada deskripsi)
    const MenuDetailData(
      name: 'Kopi Susu Aren',
      description: ' ',
      imageUrl: _img,
      basePrice: 18000,
      groups: [
        OptionGroup(title: 'CupSize', options: _cup3),
        OptionGroup(
          title: 'Sweetness',
          columns: 2,
          options: [OptionItem('Normal Sweet'), OptionItem('Less Sweet')],
        ),
        OptionGroup(title: 'Topping', columns: 2, options: _topping),
      ],
      addOns: _stdAddOns,
    ),

    // ===== FLAVOURED DRINKS =====

    // Peach Jasmine Tea  (Flavoured Drinks)
    const MenuDetailData(
      name: 'Peach Jasmine Tea',
      description:
          'Perpaduan sempurna dari rasa manis dari Peach Purée Asli dan wangi dari Jasmine '
          'Green Tea, menghasilkan rasa yang menyegarkan.',
      imageUrl: _img,
      basePrice: 19000,
      groups: [
        OptionGroup(title: 'CupSize', options: _cup3),
        OptionGroup(title: 'Temperature', options: _icedOnly),
        OptionGroup(
          title: 'Sweetness',
          columns: 2,
          options: [OptionItem('Normal Sweet'), OptionItem('Less Sweet')],
        ),
        OptionGroup(title: 'Topping', columns: 2, options: _topping),
      ],
      addOns: _stdAddOns,
    ),

    // ===== TEA SERIES =====

    // Matcha Latte  (CupSize 3 pilihan, Milk, Topping)
    const MenuDetailData(
      name: 'Matcha Latte',
      description: 'Kombinasi premium matcha yang wangi dan susu segar.',
      imageUrl: _img,
      basePrice: 27000,
      groups: [
        OptionGroup(title: 'CupSize', options: _cup3),
        OptionGroup(title: 'Temperature', options: _icedHotDisabled),
        OptionGroup(title: 'Milk', columns: 2, options: _milk),
        OptionGroup(title: 'Topping', columns: 2, options: _topping),
      ],
      addOns: _stdAddOns,
    ),

    // Matcha Oat Latte
    const MenuDetailData(
      name: 'Matcha Oat Latte',
      description:
          'Susu oat yang luar biasa enak dengan cita rasa matcha yang khas, lahirlah matcha '
          'oat latte nya TOMORO.',
      imageUrl: _img,
      basePrice: 30000,
      groups: [
        OptionGroup(title: 'CupSize', options: _cup3),
        OptionGroup(title: 'Temperature', options: _icedHotDisabled),
        OptionGroup(title: 'Topping', columns: 2, options: _topping),
      ],
      addOns: _stdAddOns,
    ),

    // ===== FRAPPE =====

    // Strawberry Jasmine Smoothie  (Frappe; ada add on Granola sebelum Topping)
    const MenuDetailData(
      name: 'Strawberry Jasmine Smoothie',
      description:
          'Perpaduan Jasmine Green Tea yang di blend dengan Strawberry Purée Asli, '
          'menghasilkan minuman yang menyegarkan.\n'
          'Whipped Cream pada gambar tidak termasuk.',
      imageUrl: _img,
      basePrice: 19000,
      groups: [
        OptionGroup(
          title: 'CupSize',
          options: _cup2,
          style: GroupStyle.cupCards,
        ),
        OptionGroup(title: 'Temperature', options: _icedOnly),
        OptionGroup(
          title: 'Sweetness',
          columns: 2,
          options: [OptionItem('Normal Sweet'), OptionItem('Less Sweet')],
        ),
        OptionGroup(title: 'Topping', columns: 2, options: _topping),
      ],
      extraAddOns: [
        AddOnSection(
          title: 'Add - Granola Topping',
          items: [AddOnItem('Granola Topping', 3000)],
          beforeGroup: 3, // tampil sebelum Topping
        ),
      ],
      addOns: _stdAddOns,
    ),
  ];

  static String _key(String s) =>
      s.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Cari menu berdasarkan nama (tidak peduli huruf besar/kecil).
  static MenuDetailData? find(String name) {
    final k = _key(name);
    for (final m in _list) {
      if (_key(m.name) == k) return _withLinks(m);
    }
    return null;
  }

  static List<String> get names => _list.map((e) => e.name).toList();
}

// ---------------------------------------------------------------------
// Widget utama
// ---------------------------------------------------------------------
class DetailMenu extends StatefulWidget {
  final MenuDetailData data;

  const DetailMenu({super.key, required this.data});

  /// Tampilkan detail menu sebagai bottom sheet.
  /// Panggil dari halaman menu saat item diklik.
  static Future<void> show(
    BuildContext context, {
    required String name,
    String? imageUrl,
    String? description,
    int? basePrice,
  }) {
    final data = _resolveMenuData(
      name: name,
      imageUrl: imageUrl,
      description: description,
      basePrice: basePrice,
    );

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: false,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (_) => DetailMenu(data: data),
    );
  }

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  static const int _maxPerAddOn = 2;
  static const int _maxTotalAddOn = 3;

  late final MenuDetailData _d;
  late final List<int> _sel; // index pilihan tiap group
  final Map<String, int> _addOnQty = {};
  int _qty = 1;

  final ScrollController _scroll = ScrollController();
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _d = widget.data;
    _sel = _d.groups.map((g) => g.initial).toList();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldExpand = _scroll.offset > 24;
    if (shouldExpand != _expanded) setState(() => _expanded = shouldExpand);
  }

  // ----- Harga -----
  int get _totalAddOnQty => _addOnQty.values.fold(0, (a, b) => a + b);

  int get _unitPrice {
    int price = _d.basePrice;
    for (int i = 0; i < _d.groups.length; i++) {
      price += _d.groups[i].options[_sel[i]].extraPrice;
    }
    for (final a in _allAddOns) {
      price += a.price * (_addOnQty[a.name] ?? 0);
    }
    return price;
  }

  int get _totalPrice => _unitPrice * _qty;

  Iterable<AddOnItem> get _allAddOns => [
        ..._d.addOns,
        for (final e in _d.extraAddOns) ...e.items,
      ];

  String _rupiah(int value) {
    final s = value.toString();
    final buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i != 0 && (s.length - i) % 3 == 0) buf.write('.');
      buf.write(s[i]);
    }
    return 'Rp $buf';
  }

  void _changeAddOn(AddOnItem item, int delta) {
    final current = _addOnQty[item.name] ?? 0;
    final next = current + delta;
    if (next < 0 || next > _maxPerAddOn) return;
    if (delta > 0 && _totalAddOnQty >= _maxTotalAddOn) return;
    setState(() {
      if (next == 0) {
        _addOnQty.remove(item.name);
      } else {
        _addOnQty[item.name] = next;
      }
    });
  }

  // ===================================================================
  // BUILD
  // ===================================================================
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final sheetHeight =
        _expanded ? media.size.height : media.size.height * 0.80;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      height: sheetHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(_expanded ? 0 : 20),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _buildContent(),
                _buildStickyHeader(media.padding.top),
              ],
            ),
          ),
          _buildBottomBar(media.padding.bottom),
        ],
      ),
    );
  }

  // ----- Header kecil saat di-scroll -----
  Widget _buildStickyHeader(double topPadding) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: IgnorePointer(
        ignoring: !_expanded,
        child: AnimatedOpacity(
          opacity: _expanded ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: EdgeInsets.only(top: topPadding, left: 8, right: 16),
            height: 56 + topPadding,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 28, color: _C.title),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    _d.imageUrl,
                    width: 32,
                    height: 32,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const SizedBox(
                      width: 32,
                      height: 32,
                      child: Icon(Icons.local_cafe, size: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _d.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _font(14, weight: FontWeight.w600, color: _C.title),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ----- Isi yang bisa di-scroll -----
  Widget _buildContent() {
    return SingleChildScrollView(
      controller: _scroll,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Text(
                  _d.name,
                  style: _font(17, weight: FontWeight.w700, color: _C.title),
                ),
                const SizedBox(height: 8),
                Text(
                  _d.description,
                  style: _font(12, color: _C.desc, height: 1.27),
                ),
                const SizedBox(height: 14),
                const Divider(height: 1, color: _C.divider),
                const SizedBox(height: 28),

                // Kelompok pilihan + section add on, sesuai urutan aplikasi asli
                ..._buildBody(),
              ],
            ),
          ),

          _band(),

          // Recommended (hanya untuk menu yang punya)
          if (_d.recommended != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recommended',
                    style: _font(15, weight: FontWeight.w700, color: _C.title),
                  ),
                  const SizedBox(height: 12),
                  _buildRecommended(_d.recommended!),
                ],
              ),
            ),
            _band(),
          ],
        ],
      ),
    );
  }

  Widget _band() => Container(height: 12, color: _C.grey);

  /// Menyusun group pilihan dan section add on sesuai posisinya.
  List<Widget> _buildBody() {
    final glen = _d.groups.length;
    // Urutan: section tambahan dulu, add on utama paling akhir di posisi yang sama
    final sections = <_SectionRef>[
      for (final e in _d.extraAddOns)
        _SectionRef(e.title, e.items, (e.beforeGroup ?? glen).clamp(0, glen).toInt()),
      _SectionRef(
        _d.addOnTitle,
        _d.addOns,
        (_d.addOnPosition ?? glen).clamp(0, glen).toInt(),
      ),
    ];

    final out = <Widget>[];
    for (int i = 0; i <= glen; i++) {
      for (int k = 0; k < sections.length; k++) {
        final sec = sections[k];
        if (sec.pos != i) continue;
        final isLast = k == sections.length - 1 && i == glen;
        out.addAll(_buildAddOnSection(sec.title, sec.items, isLast ? 24 : 30));
      }
      if (i < glen) out.add(_buildGroup(i));
    }
    return out;
  }

  List<Widget> _buildAddOnSection(
      String title, List<AddOnItem> items, double bottomGap) {
    return [
      _label(title),
      const SizedBox(height: 10),
      ...items.map(_buildAddOnRow),
      SizedBox(height: bottomGap),
    ];
  }

  Widget _label(String text) {
    return Text(text, style: _font(13, color: _C.label));
  }

  // ----- Satu kelompok pilihan -----
  Widget _buildGroup(int gi) {
    final g = _d.groups[gi];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(g.title),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (context, c) {
            const gap = 10.0;
            final w =
                ((c.maxWidth - gap * (g.columns - 1)) / g.columns).floorToDouble();
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: List.generate(g.options.length, (i) {
                final o = g.options[i];
                final selected = _sel[gi] == i;
                void onTap() => setState(() => _sel[gi] = i);
                return SizedBox(
                  width: w,
                  child: g.style == GroupStyle.cupCards
                      ? _CupCard(
                          label: o.label,
                          index: i,
                          selected: selected,
                          onTap: onTap,
                        )
                      : _OptionChip(
                          label: o.label,
                          selected: selected,
                          enabled: o.available,
                          onTap: onTap,
                        ),
                );
              }),
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // ----- Gambar produk + tombol close -----
  Widget _buildImage() {
    final closeButton = Positioned(
      top: 10,
      right: 12,
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Color(0xFFD9D9D9),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, size: 14, color: Colors.white),
        ),
      ),
    );

    if (_d.bannerImage) {
      return SizedBox(
        height: 233,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                _d.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: _C.grey,
                  child: const Icon(Icons.local_cafe_outlined,
                      size: 64, color: _C.disabledText),
                ),
              ),
            ),
            closeButton,
          ],
        ),
      );
    }

    return SizedBox(
      height: 245,
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Image.network(
                _d.imageUrl,
                height: 200,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, progress) {
                  if (progress == null) return child;
                  return const SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: _C.plus,
                      ),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => const SizedBox(
                  height: 200,
                  child: Center(
                    child: Icon(Icons.local_cafe_outlined,
                        size: 64, color: _C.disabledText),
                  ),
                ),
              ),
            ),
          ),
          closeButton,
        ],
      ),
    );
  }

  Widget _buildAddOnRow(AddOnItem item) {
    final qty = _addOnQty[item.name] ?? 0;
    final limitReached =
        qty >= _maxPerAddOn || _totalAddOnQty >= _maxTotalAddOn;
    final canAdd = item.available && !limitReached;
    final textColor = item.available ? _C.body : _C.disabledText;

    final Color plusColor = !item.available
        ? _C.plusUnavailable
        : limitReached
            ? _C.plusDisabled
            : _C.plusOutline;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 9, right: 10),
      height: 40,
      decoration: BoxDecoration(
        color: _C.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: _font(12, color: textColor),
                  ),
                ),
                const SizedBox(width: 20),
                Text(_rupiah(item.price), style: _font(12, color: textColor)),
              ],
            ),
          ),
          if (qty > 0) ...[
            _AddOnButton(
              symbol: _AddOnSymbol.minus,
              color: _C.plusOutline,
              enabled: true,
              onTap: () => _changeAddOn(item, -1),
            ),
            SizedBox(
              width: 27,
              child: Text(
                '$qty',
                textAlign: TextAlign.center,
                style: _font(15, weight: FontWeight.w400, color: _C.title),
              ),
            ),
          ],
          _AddOnButton(
            symbol: _AddOnSymbol.plus,
            color: plusColor,
            enabled: canAdd,
            onTap: () => _changeAddOn(item, 1),
          ),
        ],
      ),
    );
  }

  // ----- Kartu Recommended -----
  Widget _buildRecommended(RecommendedItem r) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _C.recoBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              r.imageUrl,
              width: 84,
              height: 84,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 84,
                height: 84,
                color: _C.grey,
                child: const Icon(Icons.local_cafe_outlined,
                    color: _C.disabledText),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: _font(12, weight: FontWeight.w600, color: _C.title),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (r.oldPrice != null)
                          Text(
                            _rupiah(r.oldPrice!),
                            style: _font(
                              10,
                              color: const Color(0xFFAAAAAA),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Text(
                          _rupiah(r.price),
                          style: _font(15,
                              weight: FontWeight.w700, color: _C.title),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: _C.plus,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.chevron_right,
                          size: 18, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----- Bar bawah: harga, stepper, Add to Cart -----
  Widget _buildBottomBar(double bottomPadding) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 14, 15, 12 + bottomPadding),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _rupiah(_totalPrice),
                  style: _font(17, weight: FontWeight.w700, color: _C.title),
                ),
              ),
              _RoundButton(
                icon: Icons.remove,
                filled: false,
                enabled: _qty > 1,
                size: 22,
                onTap: () => setState(() => _qty--),
              ),
              SizedBox(
                width: 36,
                child: Text(
                  '$_qty',
                  textAlign: TextAlign.center,
                  style: _font(15, weight: FontWeight.w600, color: _C.title),
                ),
              ),
              _RoundButton(
                icon: Icons.add,
                filled: true,
                enabled: true,
                size: 22,
                onTap: () => setState(() => _qty++),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 49,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _C.cta,
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Add to Cart',
                style: _font(17, weight: FontWeight.w700, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionRef {
  final String title;
  final List<AddOnItem> items;
  final int pos;
  const _SectionRef(this.title, this.items, this.pos);
}

/// Chip pilihan (CupSize, Temperature, Sweetness, Milk, Topping)
class _OptionChip extends StatelessWidget {
  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  const _OptionChip({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = selected && enabled;
    final Color textColor = !enabled
        ? _C.disabledText
        : active
            ? _C.chipText
            : _C.body;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        height: 33,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? _C.chipBg : _C.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active ? _C.chipBorder : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: _font(12, color: textColor),
        ),
      ),
    );
  }
}

/// Kartu CupSize dengan gambar gelas (Small / Medium)
class _CupCard extends StatelessWidget {
  final String label;
  final int index;
  final bool selected;
  final VoidCallback onTap;

  const _CupCard({
    required this.label,
    required this.index,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Ukuran gelas makin besar sesuai urutan (Small < Medium < Jumbo)
    final bool big = index >= 1;
    final Size size = big ? const Size(23.28, 32.54) : const Size(23.13, 30.15);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 83,
        decoration: BoxDecoration(
          color: selected ? _C.chipBg : _C.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? _C.chipBorder : Colors.transparent,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 19.5),
            // Ikon sejajar di bawah (rata dasar), seperti aplikasi asli
            SizedBox(
              height: 33,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomPaint(
                  size: size,
                  painter: _CupPainter(selected: selected, big: big),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: _font(12, color: selected ? _C.chipText : _C.body, height: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}

class _CupPainter extends CustomPainter {
  final bool selected;
  final bool big; // false = Small, true = Medium
  const _CupPainter({required this.selected, required this.big});

  static const Color _orange = Color(0xFFEC7B45);

  @override
  void paint(Canvas canvas, Size size) {
    final double refW = big ? 156 : 155;
    final double refH = big ? 218 : 202;
    canvas.scale(size.width / refW, size.height / refH);

    final double sw = big ? 5 : 6; // tebal garis
    final stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = sw
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..color = selected ? const Color(0xFF1A1A1A) : const Color(0xFF454545);

    // ----- Data bentuk (garis tengah goresan) -----
    final Rect rim;
    final Offset capBL, capTL, capTR, capBR;
    final Offset l1, l2, r1, r2; // dua titik di sisi kiri & kanan badan
    final double bottomY, bottomR, capR;
    final Offset logoCenter;
    final double logoSize;

    if (!big) {
      rim = const Rect.fromLTRB(3, 22.5, 152, 43);
      capBL = const Offset(10, 22.5);
      capTL = const Offset(14, 3);
      capTR = const Offset(141, 3);
      capBR = const Offset(145, 22.5);
      l1 = const Offset(16, 50);
      l2 = const Offset(27, 190);
      r1 = const Offset(138, 50);
      r2 = const Offset(127, 190);
      bottomY = 198;
      bottomR = 11;
      capR = 6;
      logoCenter = const Offset(77, 108);
      logoSize = 42;
    } else {
      rim = const Rect.fromLTRB(2.5, 21, 153.5, 41.5);
      capBL = const Offset(12, 21);
      capTL = const Offset(12.5, 2.5);
      capTR = const Offset(141.5, 2.5);
      capBR = const Offset(143, 21);
      l1 = const Offset(15.5, 45);
      l2 = const Offset(27.5, 205);
      r1 = const Offset(138.5, 45);
      r2 = const Offset(127.5, 205);
      bottomY = 214.5;
      bottomR = 12;
      capR = 6;
      logoCenter = const Offset(77.5, 115.7);
      logoSize = 49;
    }

    double xAt(Offset a, Offset b, double y) =>
        a.dx + (b.dx - a.dx) * (y - a.dy) / (b.dy - a.dy);

    // ----- Badan gelas -----
    final topY = rim.bottom;
    final lTop = xAt(l1, l2, topY);
    final rTop = xAt(r1, r2, topY);
    final lBot = xAt(l1, l2, bottomY);
    final rBot = xAt(r1, r2, bottomY);
    final lCurve = xAt(l1, l2, bottomY - bottomR);
    final rCurve = xAt(r1, r2, bottomY - bottomR);
    final body = Path()
      ..moveTo(lTop, topY)
      ..lineTo(lCurve, bottomY - bottomR)
      ..quadraticBezierTo(lBot, bottomY, lBot + bottomR, bottomY)
      ..lineTo(rBot - bottomR, bottomY)
      ..quadraticBezierTo(rBot, bottomY, rCurve, bottomY - bottomR)
      ..lineTo(rTop, topY);
    canvas.drawPath(body, stroke);

    // ----- Bibir tutup (persegi membulat) -----
    canvas.drawRRect(
      RRect.fromRectAndRadius(rim, const Radius.circular(5)),
      stroke,
    );

    // ----- Tutup atas -----
    final cap = Path()
      ..moveTo(capBL.dx, capBL.dy)
      ..lineTo(capTL.dx, capTL.dy + capR)
      ..quadraticBezierTo(capTL.dx, capTL.dy, capTL.dx + capR, capTL.dy)
      ..lineTo(capTR.dx - capR, capTR.dy)
      ..quadraticBezierTo(capTR.dx, capTR.dy, capTR.dx, capTR.dy + capR)
      ..lineTo(capBR.dx, capBR.dy);
    canvas.drawPath(cap, stroke);

    // ----- Logo kepala kucing -----
    final outer = Rect.fromCenter(
      center: logoCenter,
      width: logoSize,
      height: logoSize,
    );
    if (selected) {
      canvas.drawPath(_catPath(outer), Paint()..color = _orange);
    } else {
      canvas.drawPath(_catPath(outer.deflate(sw / 2)), stroke);
    }
  }

  /// Siluet kepala kucing (dua telinga) di dalam kotak [r].
  Path _catPath(Rect r) {
    double x(double u) => r.left + u * r.width;
    double y(double v) => r.top + v * r.height;
    return Path()
      ..moveTo(x(0.07), y(0.0)) // ujung telinga kiri
      ..lineTo(x(0.28), y(0.21))
      ..lineTo(x(0.70), y(0.21))
      ..lineTo(x(0.89), y(0.02)) // ujung telinga kanan
      ..lineTo(x(1.0), y(0.86))
      ..quadraticBezierTo(x(1.0), y(1.0), x(0.88), y(1.0))
      ..lineTo(x(0.12), y(1.0))
      ..quadraticBezierTo(x(0.0), y(1.0), x(0.0), y(0.86))
      ..close();
  }

  @override
  bool shouldRepaint(covariant _CupPainter old) =>
      old.selected != selected || old.big != big;
}

enum _AddOnSymbol { plus, minus }

class _AddOnButton extends StatelessWidget {
  final _AddOnSymbol symbol;
  final Color color;
  final bool enabled;
  final VoidCallback onTap;

  const _AddOnButton({
    required this.symbol,
    required this.color,
    required this.enabled,
    required this.onTap,
  });

  static const double _size = 22;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkResponse(
        onTap: enabled ? onTap : null,
        radius: 15,
        containedInkWell: false,
        highlightShape: BoxShape.circle,
        splashColor: _C.rippleBlue,
        highlightColor: Colors.transparent,
        child: SizedBox(
          width: _size,
          height: _size,
          child: CustomPaint(
            painter: _AddOnButtonPainter(symbol: symbol, color: color),
          ),
        ),
      ),
    );
  }
}

class _AddOnButtonPainter extends CustomPainter {
  final _AddOnSymbol symbol;
  final Color color;
  const _AddOnButtonPainter({required this.symbol, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final c = size.center(Offset.zero);

    // Lingkaran luar (garis tipis)
    canvas.drawCircle(
      c,
      size.width / 2 - 0.6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2
        ..color = color,
    );

    // Simbol + / - (tebal, ujung membulat)
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = color;
    const double half = 5.2; // setengah panjang garis simbol
    canvas.drawLine(c.translate(-half, 0), c.translate(half, 0), p);
    if (symbol == _AddOnSymbol.plus) {
      canvas.drawLine(c.translate(0, -half), c.translate(0, half), p);
    }
  }

  @override
  bool shouldRepaint(covariant _AddOnButtonPainter old) =>
      old.color != color || old.symbol != symbol;
}

/// Tombol bulat + / - (outline atau terisi oranye)
class _RoundButton extends StatelessWidget {
  final IconData icon;
  final bool filled;
  final bool enabled;
  final double size;
  final VoidCallback onTap;

  const _RoundButton({
    required this.icon,
    required this.filled,
    required this.enabled,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color main = !enabled
        ? _C.plusDisabled
        : filled
            ? _C.plus
            : _C.plusOutline;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? main : Colors.transparent,
          border: filled ? null : Border.all(color: main, width: 1.3),
        ),
        child: Icon(
          icon,
          size: size * 0.72,
          color: filled ? Colors.white : main,
        ),
      ),
    );
  }
}

MenuDetailData _resolveMenuData({
  required String name,
  String? imageUrl,
  String? description,
  int? basePrice,
}) {
  final found = MenuCatalog.find(name);
  if (found != null) {
    return found.copyWith(
      imageUrl: imageUrl,
      description: description,
      basePrice: basePrice,
    );
  }
  return MenuCatalog.standardDrink(
    name: name,
    description: description ?? 'Deskripsi menu belum tersedia.',
    imageUrl: imageUrl ?? MenuCatalog._img,
    basePrice: basePrice ?? 25000,
  );
}

class ChocoMontBlancPage extends StatelessWidget {
  const ChocoMontBlancPage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Choco Mont Blanc');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Choco Mont Blanc'));
}

class MasterSoeAmericanoPage extends StatelessWidget {
  const MasterSoeAmericanoPage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Master S.O.E - Americano');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Master S.O.E - Americano'));
}

class TripleDubaiPistachioChocolatePage extends StatelessWidget {
  const TripleDubaiPistachioChocolatePage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Triple Dubai Pistachio Chocolate');

  @override
  Widget build(BuildContext context) => DetailMenu(
      data: _resolveMenuData(name: 'Triple Dubai Pistachio Chocolate'));
}

class MatchaLattePage extends StatelessWidget {
  const MatchaLattePage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Matcha Latte');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Matcha Latte'));
}

class CaffeAmericanoPage extends StatelessWidget {
  const CaffeAmericanoPage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Caffe Americano');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Caffe Americano'));
}

class MochaMontBlancPage extends StatelessWidget {
  const MochaMontBlancPage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Mocha Mont Blanc');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Mocha Mont Blanc'));
}

class MasterSoeLattePage extends StatelessWidget {
  const MasterSoeLattePage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Master S.O.E - Latte');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Master S.O.E - Latte'));
}

class MasterSoeBreveLattePage extends StatelessWidget {
  const MasterSoeBreveLattePage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Master S.O.E - Breve Latte');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Master S.O.E - Breve Latte'));
}

class TomoroArenLattePage extends StatelessWidget {
  const TomoroArenLattePage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'TOMORO Aren Latte');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'TOMORO Aren Latte'));
}

class KopiSusuArenPage extends StatelessWidget {
  const KopiSusuArenPage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Kopi Susu Aren');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Kopi Susu Aren'));
}

class PeachJasmineTeaPage extends StatelessWidget {
  const PeachJasmineTeaPage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Peach Jasmine Tea');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Peach Jasmine Tea'));
}

class MatchaOatLattePage extends StatelessWidget {
  const MatchaOatLattePage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Matcha Oat Latte');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Matcha Oat Latte'));
}

class StrawberryJasmineSmoothiePage extends StatelessWidget {
  const StrawberryJasmineSmoothiePage({super.key});

  static Future<void> show(BuildContext context) =>
      DetailMenu.show(context, name: 'Strawberry Jasmine Smoothie');

  @override
  Widget build(BuildContext context) =>
      DetailMenu(data: _resolveMenuData(name: 'Strawberry Jasmine Smoothie'));
}


class DetailMenuPage extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final String? description;
  final int? basePrice;

  const DetailMenuPage({
    super.key,
    required this.name,
    this.imageUrl,
    this.description,
    this.basePrice,
  });

  static Future<void> show(
    BuildContext context, {
    required String name,
    String? imageUrl,
    String? description,
    int? basePrice,
  }) =>
      DetailMenu.show(
        context,
        name: name,
        imageUrl: imageUrl,
        description: description,
        basePrice: basePrice,
      );

  @override
  Widget build(BuildContext context) => DetailMenu(
        data: _resolveMenuData(
          name: name,
          imageUrl: imageUrl,
          description: description,
          basePrice: basePrice,
        ),
      );
}
