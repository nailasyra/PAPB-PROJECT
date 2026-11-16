import 'dart:math' as math;

import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  const MePage({
    super.key,
    this.name = 'caca',
    this.level = 1,
    this.vouchers = 2,
    this.points = 0,
    this.mascotAsset = 'assets/images/icon/me icon 1.png',
  });

  final String name;
  final int level;
  final int vouchers;
  final int points;
  final String mascotAsset;

  // Warna Lokal
  static const Color _orange = Color(0xFFFF5A1F);
  static const Color _peach = Color(0xFFFFE3DA);
  static const Color _bg = Color(0xFFF8F8F8);
  static const Color _text = Color(0xFF222222);
  static const Color _grey = Color(0xFF9A9A9A);

  // Skala Tampilan
  static const double _k = 0.90;

  // Daftar Menu
  static final List<MenuData> _menus = [
    MenuData(_ic(Icons.article_outlined), 'Order History'),
    MenuData(_ic(Icons.location_on_outlined), 'My Addresses'),
    MenuData(_ic(Icons.swap_horizontal_circle_outlined), 'Redeem Center'),
    MenuData(_ic(Icons.help_outline_rounded), 'Help Center'),
    MenuData(_ic(Icons.language_rounded), 'Language'),
    MenuData(_ic(Icons.book_outlined), 'Terms of Services'),
    MenuData(_privacyIcon(), 'Privacy Policy'),
    MenuData(_whatsIcon(), 'Customer Care'),
    MenuData(_ic(Icons.settings_outlined), 'Settings'),
  ];

  static Widget _ic(IconData d) => Icon(d, color: _text, size: 24);

  // Ikon "Privacy Policy"
  static Widget _privacyIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        children: [
          Container(
            width: 20,
            height: 22,
            decoration: BoxDecoration(
              border: Border.all(color: _text, width: 2),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 1, top: 1),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: _text,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Ikon "Customer Care" (gelembung WhatsApp, ujung lancip di kiri bawah)
  static Widget _whatsIcon() {
    return SizedBox(
      width: 24,
      height: 24,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(24, 24),
            painter: _WaBubblePainter(_text),
          ),
          const Icon(Icons.phone_rounded, color: _text, size: 12),
        ],
      ),
    );
  }

  // Ikon QR (4 kotak)
  static Widget _qrIcon({double size = 26}) {
    final c = size * 0.42;
    Widget box() => Container(
          width: c,
          height: c,
          decoration: BoxDecoration(
            border: Border.all(color: _orange, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        );
    Widget bar() => Container(
          width: 2.5,
          height: c,
          decoration: BoxDecoration(
            color: _orange,
            borderRadius: BorderRadius.circular(2),
          ),
        );
    return SizedBox(
      width: size,
      height: size,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [box(), box()],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              box(),
              SizedBox(
                width: c,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [bar(), bar()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Ikon Poin
  static Widget _coinIcon({double size = 26}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: _orange, width: 2),
      ),
      child: Center(
        child: Container(
          width: size * 0.42,
          height: size * 0.42,
          decoration: BoxDecoration(
            border: Border.all(color: _orange, width: 2),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
      ),
    );
  }

  void _open(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SimplePage(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          // Latar Peach
          Container(
            height: 470 * _k,
            decoration: const BoxDecoration(
              color: _peach,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(60)),
            ),
          ),
          Positioned(
            right: -25,
            top: 40,
            child: _circle(100, const Color.fromARGB(255, 250, 202, 187).withOpacity(0.35)),
          ),
          Positioned(
            right: -25,
            top: 125,
            child: _circle(100, const Color.fromARGB(255, 250, 202, 187).withOpacity(0.35)),
          ),
          Positioned(
            right: 55,
            top: 110,
            child: _circle(90, const Color.fromARGB(255, 250, 202, 187).withOpacity(0.35)),
          ),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              child: LayoutBuilder(
                builder: (context, c) {
                  final vw = c.maxWidth / _k;
                  return FittedBox(
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: vw,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(vw),
                          _buildStatsCard(),
                          const SizedBox(height: 12),
                          _buildPromoBanner(),
                          const SizedBox(height: 12),
                          _buildMenuCard(context),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------ HEADER ------------------------------ //

  Widget _buildHeader(double width) {
    return SizedBox(
      width: double.infinity,
      height: 266,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Avatar
          Positioned(
            left: 20,
            top: 130,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/icon/me icon 2.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Nama
          Positioned(
            left: 101,
            top: 138,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: _text,
              ),
            ),
          ),
          // Badge Level
          Positioned(
            left: 101,
            top: 174,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF9C8C7C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Lv.$level',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Maskot
          Positioned(
            right: 6,
            bottom: -4,
            child: Image.asset(
              mascotAsset,
              width: width * 0.32,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------- STATS CARD ---------------------------- //

  Widget _buildStatsCard() {
    return _whiteCard(
      padding: const EdgeInsets.fromLTRB(18, 16, 14, 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem(
                'Vouchers',
                const Icon(Icons.confirmation_number_outlined,
                    color: _orange, size: 26),
                value: '$vouchers',
              ),
              _buildStatItem(
                'TOMORO Points',
                _coinIcon(),
                value: '$points',
                suffix: ' pts',
              ),
              _buildStatItem('QR Code', _qrIcon()),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEFEFEF)),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Text('Achievement',
                      style: TextStyle(fontSize: 14, color: _text)),
                  Spacer(),
                  Text('Collect your medals!',
                      style: TextStyle(fontSize: 13, color: _grey)),
                  SizedBox(width: 6),
                  Icon(Icons.chevron_right_rounded, color: _grey, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    String title,
    Widget icon, {
    String? value,
    String? suffix,
  }) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _text,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              if (value != null) ...[
                const SizedBox(width: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: _text,
                  ),
                ),
              ],
              if (suffix != null)
                Text(
                  suffix,
                  style: const TextStyle(fontSize: 13, color: _grey),
                ),
            ],
          ),
        ],
      ),
    );
  }

  // --------------------------- PROMO BANNER --------------------------- //

  Widget _buildPromoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        'assets/images/backgrounds/mebanner.jpeg',
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  // ---------------------------- MENU LIST ----------------------------- //

  Widget _buildMenuCard(BuildContext context) {
    return _whiteCard(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          for (final m in _menus)
            InkWell(
              onTap: () => _open(context, m.title),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
                child: Row(
                  children: [
                    m.icon,
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        m.title,
                        style: const TextStyle(fontSize: 16, color: _text),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: _grey,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ----------------------------- HELPERS ------------------------------ //

  Widget _whiteCard({
    required Widget child,
    required EdgeInsetsGeometry padding,
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: child,
    );
  }

  static Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// Model Pendukung Menu
class MenuData {
  final Widget icon;
  final String title;
  const MenuData(this.icon, this.title);
}

// Halaman Navigasi Sederhana
class SimplePage extends StatelessWidget {
  final String title;
  const SimplePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          'ini ${title.toLowerCase()}',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// Gambar outline gelembung WhatsApp: lingkaran dengan ekor lancip di kiri bawah
class _WaBubblePainter extends CustomPainter {
  final Color color;
  const _WaBubblePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 2.0;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2 - stroke / 2 - 0.5;
    final rect = Rect.fromCircle(center: c, radius: r);

    const deg = math.pi / 180;
    const start = 160 * deg; // awal busur (kiri bawah)
    const sweep = 305 * deg; // putar searah jarum jam sampai dekat dasar

    final path = Path()..addArc(rect, start, sweep);

    // Ekor lancip di pojok kiri bawah
    final tip = Offset(stroke * 0.9, size.height - stroke * 0.9);
    final startPt = Offset(
      c.dx + r * math.cos(start),
      c.dy + r * math.sin(start),
    );
    path
      ..lineTo(tip.dx, tip.dy)
      ..lineTo(startPt.dx, startPt.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WaBubblePainter old) => old.color != color;
}