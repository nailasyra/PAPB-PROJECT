import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ==========================================
// PENGATURAN CEPAT
// ==========================================

// Font Tomoro mirip "Lexend". Kalau sudah menambahkan font Lexend di
// pubspec.yaml (family: Lexend), ganti jadi 'Lexend'.
const String? kFontFamily = null;

// Semua posisi dirancang dari lebar layar 411dp, lalu diskalakan otomatis.
const double kDesignWidth = 411;

// Folder gambar maskot dan (opsional) ikon Benefits.
const String kMemberAssetDir = 'assets/images/member';

// Nyalakan (true) untuk melihat garis kotak maskot saat menyetel ukuran/posisi.
const bool kDebugMascotBox = false;

// Lama efek huruf V + percikan bintang sebelum hilang (milidetik).
const int kEffectDurationMs = 3200;

// Seberapa transparan huruf V (0.0 - 1.0). Makin besar makin jelas.
const double kVOpacity = 0.14;

// ==========================================
// WARNA
// ==========================================

const Color backgroundColor = Color(0xFFF8F8F8);
const Color darkColor = Color(0xFF24201E);

const Color level1Color = Color(0xFFB9A894);
const Color level2Color = Color(0xFFFF9900);
const Color level3Color = Color(0xFFF2641A);
const Color level4Color = Color(0xFF67574A);

TextStyle ts(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = Colors.white,
  double? height,
}) {
  return TextStyle(
    fontFamily: kFontFamily,
    fontSize: size,
    fontWeight: weight,
    color: color,
    height: height,
  );
}

// ==========================================
// DATA
// ==========================================

enum BenefitIconType { points, multiplier, voucher, birthday, gift }

class BenefitData {
  final BenefitIconType type;
  final String? badge;
  final String title;
  final String description;

  const BenefitData({
    required this.type,
    this.badge,
    required this.title,
    required this.description,
  });
}

class MemberInfo {
  final int level;
  final String name;
  final Color color;
  final String description;

  /// Lebar kotak maskot sebagai pecahan dari lebar layar.
  final double mascotWidth;

  /// Titik tengah maskot: X sebagai pecahan lebar layar,
  /// Y dalam dp (pada lebar 411) dari atas layar.
  final double mascotCenterX;
  final double mascotCenterY;

  /// Huruf V samar yang muncul lalu menghilang. Sekarang aktif di semua
  /// level. Kalau PNG maskot Lv.3 / Lv.4 masih memuat huruf V permanen di
  /// dalamnya, export ulang PNG-nya tanpa V.
  final bool showV;

  /// Cahaya yang menyala sebentar saat level ini muncul.
  final bool glow;

  final List<BenefitData> benefits;

  const MemberInfo({
    required this.level,
    required this.name,
    required this.color,
    required this.description,
    required this.mascotWidth,
    required this.mascotCenterX,
    required this.mascotCenterY,
    required this.showV,
    required this.glow,
    required this.benefits,
  });
}

const List<MemberInfo> memberLevels = [
  MemberInfo(
    level: 1,
    name: 'Coffee Newbie',
    color: level1Color,
    description: '3 more orders to reach Lv.2',
    mascotWidth: 0.85,
    mascotCenterX: 0.79,
    mascotCenterY: 243,
    showV: true,
    glow: false,
    benefits: [
      BenefitData(
        type: BenefitIconType.points,
        title: 'Points Rewards',
        description: 'Enjoy Cashback on points for every purchase you made!',
      ),
      BenefitData(
        type: BenefitIconType.voucher,
        title: 'Membership Voucher',
        description: 'Enjoy exclusive offers on the app every week',
      ),
    ],
  ),
  MemberInfo(
    level: 2,
    name: 'Coffee Holic',
    color: level2Color,
    description: 'Place 3 orders at Lv.1 to unlock\nLv.2',
    mascotWidth: 1.01,
    mascotCenterX: 0.77,
    mascotCenterY: 241,
    showV: true,
    glow: false,
    benefits: [
      BenefitData(
        type: BenefitIconType.multiplier,
        badge: '1.1x',
        title: 'APP 1.1× Points',
        description: 'Earn 1.1× points on app orders',
      ),
      BenefitData(
        type: BenefitIconType.voucher,
        title: 'Membership Voucher',
        description: 'Enjoy exclusive offers on the app every week',
      ),
      BenefitData(
        type: BenefitIconType.birthday,
        title: 'Birthday Treats 20% OFF',
        description: 'Celebrate your birthday with 20% off',
      ),
    ],
  ),
  MemberInfo(
    level: 3,
    name: 'Coffee Addict',
    color: level3Color,
    description: 'Place 5 orders at Lv.2 to unlock\nLv.3',
    mascotWidth: 0.487,
    mascotCenterX: 0.756,
    mascotCenterY: 249,
    showV: true,
    glow: true,
    benefits: [
      BenefitData(
        type: BenefitIconType.multiplier,
        badge: '1.2x',
        title: 'APP 1.2× Points',
        description: 'Earn 1.2× points on app orders',
      ),
      BenefitData(
        type: BenefitIconType.voucher,
        title: 'Membership Voucher',
        description: 'Enjoy exclusive offers on the app every week',
      ),
      BenefitData(
        type: BenefitIconType.birthday,
        title: 'Birthday Treats 30% OFF',
        description: 'Celebrate your birthday with 30% off',
      ),
    ],
  ),
  MemberInfo(
    level: 4,
    name: 'Coffee Mania',
    color: level4Color,
    description: 'Place 12 orders at Lv.3 to\nunlock Lv.4',
    mascotWidth: 0.55,
    mascotCenterX: 0.785,
    mascotCenterY: 229,
    showV: true,
    glow: true,
    benefits: [
      BenefitData(
        type: BenefitIconType.multiplier,
        badge: '1.5x',
        title: 'APP 1.5× Points',
        description: 'Earn 1.5× points on app orders',
      ),
      BenefitData(
        type: BenefitIconType.voucher,
        title: 'Membership Voucher',
        description: 'Enjoy exclusive offers on the app every week',
      ),
      BenefitData(
        type: BenefitIconType.birthday,
        title: 'Birthday Treats B1G1',
        description: 'Enjoy B1G1 off on your birthday',
      ),
      BenefitData(
        type: BenefitIconType.gift,
        title: 'Exclusive Experience',
        description:
            'VIP People only. Exclusive Experience awaiting for TOMORO champions!',
      ),
    ],
  ),
];

// Progress untuk Lv.1
const int ordersDone = 0;
const int ordersNeeded = 3;

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

class MemberLevelPage extends StatefulWidget {
  final int level;

  const MemberLevelPage({super.key, this.level = 1});

  @override
  State<MemberLevelPage> createState() => _MemberLevelPageState();
}

class _MemberLevelPageState extends State<MemberLevelPage> {
  late final PageController pageController;
  late int selectedLevel;

  @override
  void initState() {
    super.initState();
    selectedLevel = widget.level.clamp(1, 4).toInt();
    pageController = PageController(initialPage: selectedLevel - 1);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  double get currentPage {
    if (pageController.hasClients && pageController.position.haveDimensions) {
      return pageController.page ?? (selectedLevel - 1).toDouble();
    }
    return (selectedLevel - 1).toDouble();
  }

  Color backgroundForPage(double page) {
    final double p = page.clamp(0.0, 3.0).toDouble();
    final int i = p.floor();
    final int j = math.min(i + 1, 3);
    return Color.lerp(
      memberLevels[i].color,
      memberLevels[j].color,
      p - i,
    )!;
  }

  void goToLevel(int level) {
    if (level < 1 || level > 4 || !pageController.hasClients) return;
    pageController.animateToPage(
      level - 1,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double s = w / kDesignWidth;
    final double sheetTop = 344 * s;
    final MemberInfo member = memberLevels[selectedLevel - 1];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: AnimatedBuilder(
          animation: pageController,
          // PageView dibuat sekali saja agar tidak dibangun ulang tiap frame.
          child: PageView.builder(
            controller: pageController,
            itemCount: memberLevels.length,
            onPageChanged: (index) {
              setState(() => selectedLevel = index + 1);
            },
            itemBuilder: (context, index) {
              return HeaderPage(
                member: memberLevels[index],
                w: w,
                s: s,
                active: index == selectedLevel - 1,
              );
            },
          ),
          builder: (context, pageView) {
            final double page = currentPage;
            final Color bg = backgroundForPage(page);
            final double headerHeight = sheetTop + 40;

            return Stack(
              children: [
                // Warna latar atas (berubah halus saat digeser)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: headerHeight,
                  child: ColoredBox(color: bg),
                ),

                // Bagian atas yang bisa digeser (teks + maskot)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: headerHeight,
                  child: pageView!,
                ),

                // Setengah lingkaran + titik level (tetap, tidak ikut geser)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 140 * s,
                  child: LevelTrack(
                    page: page,
                    w: w,
                    s: s,
                    bgColor: bg,
                    onTap: goToLevel,
                  ),
                ),

                // Tombol info
                Positioned(
                  top: 57 * s,
                  right: 15 * s,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => showInfoDialog(context),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),

                // Sheet Benefits (tetap, isi berganti)
                Positioned(
                  top: sheetTop,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      // PERBAIKAN: default-nya Stack rata TENGAH, itu yang
                      // membuat Lv.1 (isi lebih pendek) turun ke bawah.
                      // Sekarang selalu rata ATAS dan memenuhi sheet.
                      layoutBuilder: (currentChild, previousChildren) {
                        return Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            ...previousChildren,
                            if (currentChild != null) currentChild,
                          ],
                        );
                      },
                      child: SizedBox.expand(
                        key: ValueKey(selectedLevel),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(17, 0, 17, 110),
                          child: BenefitsSection(
                            s: s,
                            level: member.level,
                            benefits: member.benefits,
                            color: member.color,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Membership Level'),
        content: const Text(
          'Setiap level memiliki keuntungan dan persyaratan pesanan yang berbeda.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SETENGAH LINGKARAN + TITIK LEVEL (TETAP)
// ==========================================

class LevelTrack extends StatelessWidget {
  final double page;
  final double w;
  final double s;
  final Color bgColor;
  final ValueChanged<int> onTap;

  const LevelTrack({
    super.key,
    required this.page,
    required this.w,
    required this.s,
    required this.bgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double radius = w * 0.656;
    final double cx = w / 2;
    final double bottomY = 91 * s;
    final double spacing = w * 0.192;

    final List<Widget> children = [
      Positioned.fill(
        child: IgnorePointer(
          child: CustomPaint(
            painter: ArcPainter(
              center: Offset(cx, bottomY - radius),
              radius: radius,
            ),
          ),
        ),
      ),
    ];

    for (int i = 0; i < 4; i++) {
      final double d = i - page;
      final double ad = d.abs();

      final double opacity =
          ad <= 1 ? 1.0 : (1 - (ad - 1) / 0.4).clamp(0.0, 1.0).toDouble();
      if (opacity <= 0) continue;

      final double x = cx + d * spacing;
      final double dx = x - cx;
      final double y =
          bottomY - (radius - math.sqrt(radius * radius - dx * dx));
      final double t = ad.clamp(0.0, 1.0).toDouble();

      children.add(
        Positioned(
          left: x - 32,
          top: y - 14,
          width: 64,
          height: 54,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTap(i + 1),
            child: Opacity(
              opacity: opacity,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 28,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Opacity(
                          opacity: 1 - t,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: bgColor,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.6,
                              ),
                            ),
                          ),
                        ),
                        Opacity(
                          opacity: t,
                          child: Icon(
                            Icons.lock,
                            size: 13,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 22,
                    left: 0,
                    right: 0,
                    height: 18,
                    child: Center(
                      child: Text(
                        'Lv.${i + 1}',
                        style: ts(
                          14.0 + (11.5 - 14.0) * t,
                          weight: FontWeight.lerp(
                            FontWeight.w700,
                            FontWeight.w400,
                            t,
                          )!,
                          color: Colors.white.withValues(
                            alpha: 1.0 - 0.22 * t,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Stack(clipBehavior: Clip.hardEdge, children: children);
  }
}

class ArcPainter extends CustomPainter {
  final Offset center;
  final double radius;

  const ArcPainter({required this.center, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant ArcPainter old) =>
      old.center != center || old.radius != radius;
}

// ==========================================
// ISI HEADER PER LEVEL (IKUT DIGESER)
// ==========================================

class HeaderPage extends StatefulWidget {
  final MemberInfo member;
  final double w;
  final double s;
  final bool active;

  const HeaderPage({
    super.key,
    required this.member,
    required this.w,
    required this.s,
    required this.active,
  });

  @override
  State<HeaderPage> createState() => _HeaderPageState();
}

class _HeaderPageState extends State<HeaderPage>
    with TickerProviderStateMixin {
  // Maskot naik pelan dari bawah saat level ini muncul.
  late final AnimationController entrance;
  // V + cahaya + percikan bintang: muncul lalu hilang dalam beberapa detik.
  late final AnimationController effects;
  // Gerakan mengambang kecil yang berulang.
  late final AnimationController idle;

  @override
  void initState() {
    super.initState();
    entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
      value: 1,
    );
    effects = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: kEffectDurationMs),
      value: 0,
    );
    idle = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    )..repeat();

    if (widget.active) _play();
  }

  @override
  void didUpdateWidget(covariant HeaderPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.active && widget.active) _play();
  }

  void _play() {
    entrance.forward(from: 0);
    effects.forward(from: 0);
  }

  @override
  void dispose() {
    entrance.dispose();
    effects.dispose();
    idle.dispose();
    super.dispose();
  }

  // 0 -> naik cepat -> tahan -> turun pelan -> 0
  double intensity(double t) {
    if (t <= 0 || t >= 1) return 0;
    if (t < 0.12) return t / 0.12;
    if (t < 0.5) return 1;
    return (1 - (t - 0.5) / 0.5).clamp(0.0, 1.0).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    final MemberInfo member = widget.member;
    final double w = widget.w;
    final double s = widget.s;
    final bool first = member.level == 1;

    final double mw = w * member.mascotWidth;
    final double cx = w * member.mascotCenterX;
    final double cy = member.mascotCenterY * s;

    // Bentuk gelap membulat di belakang maskot
    final double blobSize = w * 0.50;
    final double blobCx = w * 0.73;
    final double blobCy = 204 * s;

    // Huruf V
    final double vW = w * 0.292;
    final double vH = w * 0.34;
    final double vCx = w * 0.70;
    final double vTop = 157 * s;

    // Cahaya
    final double glowSize = w * 0.62;

    // Area percikan bintang (di sekitar maskot)
    final double spLeft = w * 0.42;
    final double spTop = 135 * s;
    final double spW = w * 0.58;
    final double spH = 215 * s;

    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        // Bentuk gelap membulat (statis)
        Positioned(
          left: blobCx - blobSize / 2,
          top: blobCy - blobSize / 2,
          width: blobSize,
          height: blobSize,
          child: const CustomPaint(painter: BlobPainter()),
        ),

        // Huruf V (besar, transparan, muncul lalu hilang)
        if (member.showV)
          Positioned(
            left: vCx - vW / 2,
            top: vTop,
            width: vW,
            height: vH,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: effects,
                builder: (context, _) {
                  return CustomPaint(
                    painter: VPainter(intensity: intensity(effects.value)),
                  );
                },
              ),
            ),
          ),

        // Cahaya (muncul sebentar lalu hilang)
        if (member.glow)
          Positioned(
            left: cx - glowSize / 2,
            top: cy - glowSize / 2,
            width: glowSize,
            height: glowSize,
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: effects,
                builder: (context, _) {
                  return CustomPaint(
                    painter: GlowPainter(intensity: intensity(effects.value)),
                  );
                },
              ),
            ),
          ),

        // Maskot: naik pelan lalu mengambang kecil
        Positioned(
          left: cx - mw / 2,
          top: cy - mw / 2,
          width: mw,
          height: mw,
          child: AnimatedBuilder(
            animation: Listenable.merge([entrance, idle]),
            child: kDebugMascotBox
                ? DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellowAccent),
                    ),
                    child: CoffeeMascot(level: member.level),
                  )
                : CoffeeMascot(level: member.level),
            builder: (context, child) {
              final double e =
                  Curves.easeOutCubic.transform(entrance.value.clamp(0.0, 1.0));
              final double floatY =
                  math.sin(idle.value * 2 * math.pi) * 3.2 * s;

              return Transform.translate(
                offset: Offset(0, (1 - e) * 30 * s + floatY),
                child: child,
              );
            },
          ),
        ),

        // Percikan bintang di semua level (hilang setelah beberapa detik)
        Positioned(
          left: spLeft,
          top: spTop,
          width: spW,
          height: spH,
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: effects,
              builder: (context, _) {
                return CustomPaint(
                  painter: SparklePainter(progress: effects.value, s: s),
                );
              },
            ),
          ),
        ),

        // Nama + keterangan
        Positioned(
          left: 22,
          top: 159 * s,
          width: w * 0.62,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        member.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: ts(22, weight: FontWeight.w700),
                      ),
                    ),
                    if (!first) ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withValues(alpha: 0.16),
                        ),
                        child: const Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (first) ...[
                const SizedBox(height: 9.3),
                Text(
                  'Valid for a lifetime',
                  style: ts(
                    12,
                    height: 1.25,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 24.7),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '$ordersDone',
                        style: ts(12, weight: FontWeight.w700, height: 1.25),
                      ),
                      TextSpan(
                        text: ' / $ordersNeeded',
                        style: ts(
                          12,
                          height: 1.25,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 7.5),
                Container(
                  width: w * 0.455,
                  height: 4,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: ordersDone / ordersNeeded,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.5),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${ordersNeeded - ordersDone}',
                        style: ts(12, weight: FontWeight.w700, height: 1.25),
                      ),
                      TextSpan(
                        text: ' more orders to reach Lv.2',
                        style: ts(
                          12,
                          height: 1.25,
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                const SizedBox(height: 12.5),
                Text(
                  member.description,
                  style: ts(12, height: 1.35),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// ==========================================
// DEKORASI LATAR
// ==========================================

// Bentuk gelap membulat di belakang maskot (statis).
class BlobPainter extends CustomPainter {
  const BlobPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double r = size.width / 2;
    final Offset c = Offset(r, r);
    const double rotation = -0.35;
    final double tip = r * 0.72;
    final double dip = tip * 0.5;

    Offset polar(double angle, double radius) =>
        c + Offset(math.cos(angle), math.sin(angle)) * radius;

    final Path path = Path()
      ..moveTo(polar(rotation, tip).dx, polar(rotation, tip).dy);
    for (int k = 0; k < 4; k++) {
      final double a = rotation + k * math.pi / 2;
      final Offset ctrl = polar(a + math.pi / 4, dip);
      final Offset end = polar(a + math.pi / 2, tip);
      path.quadraticBezierTo(ctrl.dx, ctrl.dy, end.dx, end.dy);
    }
    path.close();

    canvas.saveLayer(
      null,
      Paint()..color = Colors.black.withValues(alpha: 0.06),
    );
    final Paint solid = Paint()..color = Colors.black;
    canvas.drawPath(path, solid);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = r * 0.4
        ..strokeJoin = StrokeJoin.round,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BlobPainter old) => false;
}

// Huruf V besar & transparan yang muncul lalu menghilang.
class VPainter extends CustomPainter {
  final double intensity;

  const VPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0) return;
    final double w = size.width;
    final double h = size.height;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(w * 0.17, 0)
      ..lineTo(w * 0.5, h * 0.76)
      ..lineTo(w * 0.83, 0)
      ..lineTo(w, 0)
      ..lineTo(w * 0.58, h)
      ..lineTo(w * 0.42, h)
      ..close();

    canvas.drawPath(
      path,
      Paint()..color = Colors.white.withValues(alpha: kVOpacity * intensity),
    );
  }

  @override
  bool shouldRepaint(covariant VPainter old) => old.intensity != intensity;
}

// Percikan bintang kecil di sekitar maskot. Muncul bergantian, berkelip
// pelan, melayang sedikit ke atas, lalu hilang sebelum animasi selesai.
class SparklePainter extends CustomPainter {
  final double progress; // 0..1 dari controller effects
  final double s;

  const SparklePainter({required this.progress, required this.s});

  // dx, dy (pecahan area), ukuran (dp), delay (pecahan durasi)
  static const List<List<double>> spots = [
    [0.05, 0.22, 6.5, 0.00],
    [0.88, 0.10, 5.5, 0.06],
    [0.58, 0.02, 4.5, 0.12],
    [0.97, 0.48, 4.0, 0.18],
    [0.10, 0.62, 4.5, 0.10],
    [0.80, 0.86, 4.0, 0.24],
    [0.32, 0.92, 3.5, 0.30],
    [0.30, 0.10, 3.5, 0.34],
    [0.70, 0.60, 3.0, 0.40],
  ];

  Path star(Offset o, double r) {
    return Path()
      ..moveTo(o.dx, o.dy - r)
      ..quadraticBezierTo(o.dx, o.dy, o.dx + r, o.dy)
      ..quadraticBezierTo(o.dx, o.dy, o.dx, o.dy + r)
      ..quadraticBezierTo(o.dx, o.dy, o.dx - r, o.dy)
      ..quadraticBezierTo(o.dx, o.dy, o.dx, o.dy - r)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0 || progress >= 1) return;
    const double life = 0.55;

    for (int i = 0; i < spots.length; i++) {
      final List<double> p = spots[i];
      final double t = (progress - p[3]) / life;
      if (t <= 0 || t >= 1) continue;

      final double a = t < 0.2
          ? t / 0.2
          : (t < 0.6 ? 1.0 : 1.0 - (t - 0.6) / 0.4);
      final double twinkle = 0.8 + 0.2 * math.sin(progress * 40 + i * 1.7);
      final double radius = p[2] * s * (0.55 + 0.45 * a) * twinkle;
      final Offset o = Offset(
        size.width * p[0],
        size.height * p[1] - t * 8 * s,
      );

      canvas.drawPath(
        star(o, radius),
        Paint()..color = Colors.white.withValues(alpha: 0.85 * a),
      );
    }
  }

  @override
  bool shouldRepaint(covariant SparklePainter old) =>
      old.progress != progress || old.s != s;
}

// Cahaya yang menyala sebentar lalu hilang.
class GlowPainter extends CustomPainter {
  final double intensity;

  const GlowPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    if (intensity <= 0) return;
    final Rect rect = Offset.zero & size;
    canvas.drawCircle(
      rect.center,
      rect.width / 2,
      Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.white.withValues(alpha: 0.34 * intensity),
            Colors.white.withValues(alpha: 0.0),
          ],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant GlowPainter old) => old.intensity != intensity;
}

// ==========================================
// MASKOT (ASSET)
// ==========================================

class CoffeeMascot extends StatelessWidget {
  final int level;

  const CoffeeMascot({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '$kMemberAssetDir/lv$level.png',
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Gagal memuat $kMemberAssetDir/lv$level.png: $error');
        return const SizedBox.shrink();
      },
    );
  }
}

// ==========================================
// BENEFITS
// ==========================================

class BenefitsSection extends StatelessWidget {
  final double s;
  final int level;
  final List<BenefitData> benefits;
  final Color color;

  const BenefitsSection({
    super.key,
    required this.s,
    required this.level,
    required this.benefits,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Semua ukuran dibuat tetap (bukan bergantung tinggi font) supaya
    // posisi judul dan kartu IDENTIK di semua level, sama seperti aplikasi
    // asli: judul tepat 35dp dan kartu pertama 67dp dari atas sheet.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 22 * s),
        SizedBox(
          height: 26 * s,
          child: Padding(
            padding: const EdgeInsets.only(left: 1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Benefits',
                style: ts(19.5, weight: FontWeight.w700, color: darkColor),
              ),
            ),
          ),
        ),
        SizedBox(height: 19 * s),
        ...benefits.map(
          (b) => Padding(
            padding: EdgeInsets.only(bottom: 17 * s),
            child: BenefitCard(s: s, level: level, benefit: b, color: color),
          ),
        ),
      ],
    );
  }
}

class BenefitCard extends StatelessWidget {
  final double s;
  final int level;
  final BenefitData benefit;
  final Color color;

  const BenefitCard({
    super.key,
    required this.s,
    required this.level,
    required this.benefit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 97 * s,
      padding: EdgeInsets.fromLTRB(22.5 * s, 6, 8 * s, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          BenefitIcon(
            size: 58 * s,
            level: level,
            type: benefit.type,
            badge: benefit.badge,
            color: color,
          ),
          SizedBox(width: 22 * s),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  benefit.title,
                  style: ts(
                    15.5,
                    weight: FontWeight.w700,
                    color: darkColor,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  benefit.description,
                  style: ts(
                    12.7,
                    color: const Color(0xFF9A9A9A),
                    height: 1.2,
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
// IKON BENEFITS
//
// Kalau ada file PNG ikon (crop bulatan ikon dari aplikasi asli) di
// assets/images/member/, file itu yang dipakai (hasil paling mirip 100%).
// Kalau tidak ada, dipakai ikon gambar kode di bawah. Nama file:
//   ic_points_lv1.png ... ic_points_lv4.png   (koin / APP 1.xx Points)
//   ic_voucher_lv1.png ... ic_voucher_lv4.png (Membership Voucher)
//   ic_birthday_lv2.png ... ic_birthday_lv4.png
//   ic_gift_lv4.png                           (Exclusive Experience)
// ==========================================

class BenefitIcon extends StatelessWidget {
  final double size;
  final int level;
  final BenefitIconType type;
  final String? badge;
  final Color color;

  const BenefitIcon({
    super.key,
    required this.size,
    required this.level,
    required this.type,
    required this.badge,
    required this.color,
  });

  String get assetName {
    switch (type) {
      case BenefitIconType.points:
      case BenefitIconType.multiplier:
        return 'ic_points_lv$level';
      case BenefitIconType.voucher:
        return 'ic_voucher_lv$level';
      case BenefitIconType.birthday:
        return 'ic_birthday_lv$level';
      case BenefitIconType.gift:
        return 'ic_gift_lv$level';
    }
  }

  Widget painted() {
    final Color tint = color.withValues(alpha: 0.12);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: tint),
      child: CustomPaint(
        painter: BenefitIconPainter(
          type: type,
          badge: badge,
          color: color,
          holeColor: Color.alphaBlend(tint, Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        '$kMemberAssetDir/$assetName.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) => painted(),
      ),
    );
  }
}

class BenefitIconPainter extends CustomPainter {
  final BenefitIconType type;
  final String? badge;
  final Color color;
  final Color holeColor;

  const BenefitIconPainter({
    required this.type,
    required this.badge,
    required this.color,
    required this.holeColor,
  });

  Color get dark => Color.lerp(color, Colors.black, 0.22)!;
  Color get light => Color.lerp(color, Colors.white, 0.5)!;

  void sparkle(Canvas c, Offset o, double r, Paint p) {
    final path = Path()
      ..moveTo(o.dx, o.dy - r)
      ..quadraticBezierTo(o.dx, o.dy, o.dx + r, o.dy)
      ..quadraticBezierTo(o.dx, o.dy, o.dx, o.dy + r)
      ..quadraticBezierTo(o.dx, o.dy, o.dx - r, o.dy)
      ..quadraticBezierTo(o.dx, o.dy, o.dx, o.dy - r)
      ..close();
    c.drawPath(path, p);
  }

  // Logo kepala kucing (dua telinga) untuk koin.
  Path _cat(Offset c, double k) {
    return Path()
      ..moveTo(c.dx - 4.4 * k, c.dy + 5.2 * k)
      ..lineTo(c.dx - 4.4 * k, c.dy - 5.2 * k)
      ..lineTo(c.dx - 1.6 * k, c.dy - 3.0 * k)
      ..lineTo(c.dx + 1.6 * k, c.dy - 3.0 * k)
      ..lineTo(c.dx + 4.4 * k, c.dy - 5.2 * k)
      ..lineTo(c.dx + 4.4 * k, c.dy + 5.2 * k)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Kanvas gambar 56 x 56, diskalakan ke ukuran asli.
    canvas.save();
    canvas.scale(size.width / 56, size.height / 56);

    switch (type) {
      case BenefitIconType.points:
        _coins(canvas, null);
        break;
      case BenefitIconType.multiplier:
        _coins(canvas, badge);
        break;
      case BenefitIconType.voucher:
        _voucher(canvas);
        break;
      case BenefitIconType.birthday:
        _cake(canvas);
        break;
      case BenefitIconType.gift:
        _gift(canvas);
        break;
    }

    canvas.restore();
  }

  // ---------- Koin ----------
  void _coins(Canvas canvas, String? label) {
    // ----- Tumpukan koin (5 koin bersusun) di kiri -----
    const double sx = 20.5;
    const double rx = 7.6;
    const double ry = 2.8;
    const double bottomY = 41.5;
    const double step = 4.6;
    const int n = 5;

    final Paint bodyPaint = Paint()..color = color;
    final Paint edge = Paint()
      ..color = light.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Digambar dari bawah ke atas; koin atas menimpa bagian koin bawah.
    for (int i = 0; i < n; i++) {
      final double y = bottomY - i * step;
      final Rect oval = Rect.fromCenter(
        center: Offset(sx, y),
        width: rx * 2,
        height: ry * 2,
      );
      canvas.drawRect(
        Rect.fromLTRB(sx - rx, y - step, sx + rx, y),
        bodyPaint,
      );
      canvas.drawOval(oval, bodyPaint);
      canvas.drawArc(oval, 0, math.pi, false, edge);
    }

    // permukaan atas koin paling atas
    final double topY = bottomY - (n - 1) * step - step;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(sx, topY),
        width: rx * 2,
        height: ry * 2,
      ),
      Paint()..color = light,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(sx, topY + 0.2),
        width: rx * 1.4,
        height: ry * 1.2,
      ),
      Paint()..color = dark,
    );

    // ----- Koin depan di kanan bawah -----
    const Offset c = Offset(34.0, 34.0);
    const double r = 12.3;
    canvas.drawCircle(c, r, Paint()..color = light);
    canvas.drawCircle(
      c,
      r - 3.0,
      Paint()..color = label == null ? dark : dark,
    );

    if (label == null) {
      final Path cat = _cat(c, 1.0);
      final Paint catPaint =
          Paint()..color = Color.lerp(light, Colors.white, 0.65)!;
      canvas.drawPath(cat, catPaint);
      canvas.drawPath(
        cat,
        Paint()
          ..color = catPaint.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8
          ..strokeJoin = StrokeJoin.round,
      );
    } else {
      final tp = TextPainter(
        text: TextSpan(
          text: label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 8.4,
            fontWeight: FontWeight.w800,
            fontFamily: kFontFamily,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(c.dx - tp.width / 2, c.dy - tp.height / 2));
    }
  }

  // ---------- Voucher ----------
  // Satu tiket: badan persegi panjang dengan dua lekukan setengah lingkaran
  // di sisi kiri-kanan (benar-benar berlubang), garis putus-putus, dan cap
  // putih di bagian bawah.
  void _ticket(
    Canvas canvas,
    Offset c,
    double angle,
    double w,
    double h,
    Color fill,
  ) {
    canvas.save();
    canvas.translate(c.dx, c.dy);
    canvas.rotate(angle);

    final Rect r = Rect.fromCenter(center: Offset.zero, width: w, height: h);
    final double ny = -h * 0.18; // posisi lekukan & garis putus-putus

    Path body = Path()
      ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(1.6)));
    final Path notches = Path()
      ..addOval(Rect.fromCircle(center: Offset(-w / 2, ny), radius: 1.9))
      ..addOval(Rect.fromCircle(center: Offset(w / 2, ny), radius: 1.9));
    body = Path.combine(PathOperation.difference, body, notches);
    canvas.drawPath(body, Paint()..color = fill);

    // garis putus-putus
    final Paint dash = Paint()
      ..color = Colors.white.withValues(alpha: 0.75)
      ..strokeWidth = 0.7
      ..strokeCap = StrokeCap.round;
    for (double x = -w / 2 + 2.8; x < w / 2 - 2.2; x += 2.0) {
      canvas.drawLine(Offset(x, ny), Offset(x + 1.0, ny), dash);
    }

    // cap putih (kotak dengan dua telinga kecil di atas)
    final double sw = w * 0.5;
    final double sh = h * 0.27;
    final double cy = (ny + h / 2) / 2 + h * 0.02;
    final double ear = sh * 0.28;
    final Path stamp = Path()
      ..moveTo(-sw / 2, cy + sh / 2)
      ..lineTo(-sw / 2, cy - sh / 2)
      ..lineTo(-sw / 2 + ear * 1.4, cy - sh / 2 + ear)
      ..lineTo(sw / 2 - ear * 1.4, cy - sh / 2 + ear)
      ..lineTo(sw / 2, cy - sh / 2)
      ..lineTo(sw / 2, cy + sh / 2)
      ..close();
    canvas.drawPath(
      stamp,
      Paint()..color = Colors.white.withValues(alpha: 0.92),
    );

    canvas.restore();
  }

  void _voucher(Canvas canvas) {
    // tiket belakang (lebih gelap) lalu tiket depan (lebih terang)
    _ticket(canvas, const Offset(20.5, 30.8), 0.32, 13, 23, color);
    _ticket(
      canvas,
      const Offset(33.6, 29.2),
      0.38,
      14.5,
      25,
      Color.lerp(color, Colors.white, 0.32)!,
    );

    // dua kilau kecil
    final sp = Paint()..color = light.withValues(alpha: 0.95);
    sparkle(canvas, const Offset(14.0, 15.5), 2.2, sp);
    sparkle(canvas, const Offset(43.5, 41.5), 2.6, sp);
  }

  // ---------- Kue ulang tahun ----------
  void _cake(Canvas canvas) {
    final Paint body = Paint()..color = color;
    final Paint cream = Paint()..color = light.withValues(alpha: 0.95);

    // tingkat bawah
    canvas.drawRRect(
      RRect.fromLTRBR(13, 29, 43, 44, const Radius.circular(3)),
      body,
    );

    // krim bergelombang di tengah
    canvas.drawRect(const Rect.fromLTWH(13, 31, 30, 3.5), cream);
    for (int i = 0; i < 6; i++) {
      canvas.drawCircle(Offset(15.5 + i * 5.0, 34.5), 2.5, cream);
    }

    // tingkat atas
    canvas.drawRRect(
      RRect.fromLTRBR(18, 22, 38, 31, const Radius.circular(2.5)),
      body,
    );
    canvas.drawRect(const Rect.fromLTWH(18, 29, 20, 2), cream);

    // lilin + api
    canvas.drawRRect(
      RRect.fromLTRBR(27.1, 15.5, 28.9, 22, const Radius.circular(0.8)),
      Paint()..color = dark,
    );
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(28, 12.5), width: 4.2, height: 6.2),
      Paint()..color = const Color(0xFFF2A33A),
    );
  }

  // ---------- Hadiah ----------
  void _gift(Canvas canvas) {
    final Paint ribbon = Paint()..color = light.withValues(alpha: 0.95);

    // badan kotak
    canvas.drawRRect(
      RRect.fromLTRBR(15, 30, 41, 45, const Radius.circular(1.8)),
      Paint()..color = color,
    );
    // tutup
    canvas.drawRRect(
      RRect.fromLTRBR(13, 23, 43, 31, const Radius.circular(1.8)),
      Paint()..color = dark,
    );
    // pita tegak
    canvas.drawRect(const Rect.fromLTWH(26, 23, 4, 22), ribbon);

    // simpul (garis tepi)
    final bow = Paint()
      ..color = light
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(24.6, 19.4), width: 6.4, height: 5),
      bow,
    );
    canvas.drawOval(
      Rect.fromCenter(center: const Offset(31.4, 19.4), width: 6.4, height: 5),
      bow,
    );

    final sp = Paint()..color = light.withValues(alpha: 0.95);
    sparkle(canvas, const Offset(9, 18), 3, sp);
    sparkle(canvas, const Offset(46.5, 44), 3, sp);
  }

  @override
  bool shouldRepaint(covariant BenefitIconPainter old) =>
      old.type != type ||
      old.badge != badge ||
      old.color != color ||
      old.holeColor != holeColor;
}