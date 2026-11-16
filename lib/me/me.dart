import 'package:flutter/material.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  // Warna (lokal di file ini)
  static const Color _orange = Color(0xFFFF5A1F);
  static const Color _peach = Color(0xFFFFE3DA);
  static const Color _bg = Color(0xFFF8F8F8);
  static const Color _text = Color(0xFF222222);
  static const Color _grey = Color(0xFF9A9A9A);

  // Daftar menu
  static const List<_MenuData> _menus = [
    _MenuData(Icons.receipt_long_outlined, 'Order History'),
    _MenuData(Icons.location_on_outlined, 'My Addresses'),
    _MenuData(Icons.swap_horizontal_circle_outlined, 'Redeem Center'),
    _MenuData(Icons.help_outline_rounded, 'Help Center'),
    _MenuData(Icons.language_rounded, 'Language'),
    _MenuData(Icons.menu_book_outlined, 'Terms of Services'),
    _MenuData(Icons.lock_outline_rounded, 'Privacy Policy'),
    _MenuData(Icons.chat_outlined, 'Customer Care'),
    _MenuData(Icons.settings_outlined, 'Settings'),
  ];

  void _open(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => _SimplePage(title: title)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: Stack(
        children: [
          // Latar peach
          Container(
            height: 300,
            decoration: const BoxDecoration(
              color: _peach,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
          ),
          Positioned(
            right: -30,
            top: -20,
            child: _circle(130, Colors.white.withOpacity(0.35)),
          ),
          Positioned(
            right: 40,
            top: 70,
            child: _circle(90, Colors.white.withOpacity(0.25)),
          ),
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(),
                  const SizedBox(height: 18),
                  _statsCard(),
                  const SizedBox(height: 14),
                  _promoBanner(),
                  const SizedBox(height: 14),
                  _menuCard(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ------------------------------ HEADER ------------------------------ */

  Widget _header() {
    return SizedBox(
      width: double.infinity,
      height: 120,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi! Friends',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: _text,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          // Placeholder gelas (ganti dengan Image.asset kalau ada)
          Positioned(
            right: 24,
            top: 0,
            child: Container(
              width: 80,
              height: 95,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                border: Border.all(color: _orange.withOpacity(0.6), width: 2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
              ),
              child: const Icon(Icons.coffee_rounded, color: _orange, size: 38),
            ),
          ),
        ],
      ),
    );
  }

  /* ---------------------------- STATS CARD ---------------------------- */

  Widget _statsCard() {
    return _whiteCard(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _stat('Vouchers', Icons.confirmation_number_outlined, value: '-'),
              _stat('Points', Icons.stars_outlined, value: '-', suffix: ' pts'),
              _stat('QR Code', Icons.qr_code_2_rounded),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFEFEFEF)),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Text('Achievement',
                      style: TextStyle(fontSize: 15, color: _text)),
                  Spacer(),
                  Text('Collect your medals!',
                      style: TextStyle(fontSize: 14, color: _grey)),
                  SizedBox(width: 6),
                  Icon(Icons.chevron_right_rounded, color: _grey, size: 22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(String title, IconData icon, {String? value, String? suffix}) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _text,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: _orange, size: 28),
              if (value != null) ...[
                const SizedBox(width: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: _text,
                  ),
                ),
              ],
              if (suffix != null)
                Text(suffix,
                    style: const TextStyle(fontSize: 13, color: _grey)),
            ],
          ),
        ],
      ),
    );
  }

  /* --------------------------- PROMO BANNER --------------------------- */

  Widget _promoBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Image.asset(
        'assets/images/backgrounds/mebanner.jpeg',
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  /* ---------------------------- MENU LIST ----------------------------- */

  Widget _menuCard(BuildContext context) {
    return _whiteCard(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        children: [
          for (final m in _menus)
            InkWell(
              onTap: () => _open(context, m.title),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Icon(m.icon, color: _text, size: 26),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        m.title,
                        style: const TextStyle(fontSize: 17, color: _text),
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded,
                        color: _grey, size: 22),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  /* ----------------------------- HELPERS ------------------------------ */

  Widget _whiteCard({required Widget child, required EdgeInsetsGeometry padding}) {
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

  static Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}

class _MenuData {
  final IconData icon;
  final String title;
  const _MenuData(this.icon, this.title);
}

/// Halaman putih sederhana: "ini order history", "ini my addresses", dst.
class _SimplePage extends StatelessWidget {
  final String title;
  const _SimplePage({required this.title});

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