import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyQrCodePage extends StatefulWidget {
  final bool isActive;
  final VoidCallback onBack;

  const MyQrCodePage({
    super.key,
    required this.isActive,
    required this.onBack,
  });

  static const Color tomoroOrange = Color(0xFFFF582E);
  static const Color badgeTaupe = Color.fromARGB(255, 126, 106, 86);
  static const Color badgeFoldShadow = Color(0xFF7A6D60);

  @override
  State<MyQrCodePage> createState() => _MyQrCodePageState();
}

class _MyQrCodePageState extends State<MyQrCodePage> {

  @override
  void initState() {
    super.initState();
    _updateFullscreen();
  }

  @override
  void didUpdateWidget(covariant MyQrCodePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isActive != widget.isActive) {
      _updateFullscreen();
    }
  }

  void _updateFullscreen() {
    if (widget.isActive) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.immersiveSticky,
      );
    } else {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
      );
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.edgeToEdge,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyQrCodePage.tomoroOrange,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final topPadding = MediaQuery.of(context).padding.top;

          final cardWidth = screenWidth * 0.775;
          final cardHeight = cardWidth * 1.155;
          final cardTop = topPadding + (screenHeight - topPadding) * 0.185;

          final ribbonWidth = cardWidth * 0.375;
          const ribbonHeight = 42.0;
          const ribbonOverhang = 8.0;

          return Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              // 1. BACKGROUND PATTERN LINGKARAN
              const Positioned.fill(
                child: BackgroundDecoration(),
              ),

              // 2. HEADER
              Positioned(
                top: topPadding + 6,
                left: 16,
                right: 16,
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: widget.onBack,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 21,
                      ),
                    ),
                    const Text(
                      'My QR Code',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.5,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const CustomScannerIcon(size: 22),
                    ),
                  ],
                ),
              ),

              // 3. LIPATAN PITA BELAKANG (EFEK 3D)
              Positioned(
                top: cardTop - ribbonOverhang,
                left: (screenWidth - ribbonWidth) / 2 - 6,
                width: ribbonWidth + 12,
                height: ribbonOverhang + 2,
                child: CustomPaint(
                  painter: RibbonFoldPainter(color: const Color.fromARGB(255, 97, 80, 64)),
                ),
              ),

              // 4. KARTU PUTIH UTAMA
              Positioned(
                top: cardTop,
                left: (screenWidth - cardWidth) / 2,
                width: cardWidth,
                height: cardHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFD13812).withOpacity(0.28),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // QR CODE
                      Positioned(
                        top: cardHeight * 0.215,
                        child: SizedBox(
                          width: cardWidth * 0.56,
                          height: cardWidth * 0.56,
                          child: CustomPaint(
                            painter: TomoroQRCodePainter(),
                          ),
                        ),
                      ),

                      // TOMBOL PILL "MY POINTS"
                      Positioned(
                        bottom: cardHeight * 0.088,
                        left: cardWidth * 0.072,
                        right: cardWidth * 0.072,
                        height: 48,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFFE5E5E5),
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'My Points',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF222222),
                                ),
                              ),
                              const Spacer(),
                              
                              // MENGGUNAKAN KOIN DARI ASSET: assets/images/icon/koin.png
                              SizedBox(
                                width: 22,
                                height: 22,
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/icon/koin.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 7),
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '0 ',
                                      style: TextStyle(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1A1A1A),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'pts',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF333333),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Color(0xFFCCCCCC),
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 5. PITA BADGE "Lv. 1"
              Positioned(
                top: cardTop - ribbonOverhang,
                left: (screenWidth - ribbonWidth) / 2,
                width: ribbonWidth,
                height: ribbonHeight,
                child: ClipPath(
                  clipper: LevelRibbonClipper(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: MyQrCodePage.badgeTaupe,
                    ),
                    alignment: const Alignment(0, -0.05),
                    child: const Text(
                      'Lv. 1',
                      style: TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),

              // 6. TEKS KETERANGAN DI BAWAH KARTU
              Positioned(
                top: cardTop + cardHeight + 34,
                left: 32,
                right: 32,
                child: const Text(
                  'Show your QR Code in store to get\nTOMORO Points',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                    height: 1.38,
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LevelRibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    const radius = 15.0;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(
      0,
      size.height,
      0,
      size.height - radius,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RibbonFoldPainter extends CustomPainter {
  final Color color;
  RibbonFoldPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final leftTriangle = Path()
      ..moveTo(6, 0)
      ..lineTo(0, size.height)
      ..lineTo(6, size.height)
      ..close();

    final rightTriangle = Path()
      ..moveTo(size.width - 6, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - 6, size.height)
      ..close();

    canvas.drawPath(leftTriangle, paint);
    canvas.drawPath(rightTriangle, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CustomScannerIcon extends StatelessWidget {
  final double size;
  const CustomScannerIcon({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ScannerIconPainter(),
    );
  }
}

class _ScannerIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final w = size.width;
    final h = size.height;
    final corner = w * 0.26;

    canvas.drawPath(
      Path()
        ..moveTo(0, corner)
        ..lineTo(0, 2)
        ..quadraticBezierTo(0, 0, 2, 0)
        ..lineTo(corner, 0),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w - corner, 0)
        ..lineTo(w - 2, 0)
        ..quadraticBezierTo(w, 0, w, 2)
        ..lineTo(w, corner),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(0, h - corner)
        ..lineTo(0, h - 2)
        ..quadraticBezierTo(0, h, 2, h)
        ..lineTo(corner, h),
      paint,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w - corner, h)
        ..lineTo(w - 2, h)
        ..quadraticBezierTo(w, h, w, h - 2)
        ..lineTo(w, h - corner),
      paint,
    );

    canvas.drawLine(
      Offset(2, h / 2),
      Offset(w - 2, h / 2),
      paint..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackgroundCirclesPainter(),
    );
  }
}

class _BackgroundCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF7652).withOpacity(0.32)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final radius = w * 0.118;
    final diameter = radius * 2;

    final row1Y = h * 0.755;
    final row1CentersX = [
      w * 0.08,
      w * 0.36,
      w * 0.64,
      w * 0.92,
    ];
    for (final cx in row1CentersX) {
      canvas.drawCircle(Offset(cx, row1Y), radius, paint);
    }

    final row2Y = row1Y + diameter * 0.92;
    for (int i = 0; i < 5; i++) {
      final cx = (w * 0.06) + (i * diameter * 0.94);
      canvas.drawCircle(Offset(cx, row2Y), radius, paint);
    }

    final row3Y = row2Y + diameter * 0.94;
    for (int i = 0; i < 5; i++) {
      final cx = (w * 0.06) + (i * diameter * 0.94);
      canvas.drawCircle(Offset(cx, row3Y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TomoroQRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final black = Paint()
      ..color = const Color(0xFF111111)
      ..style = PaintingStyle.fill;

    final white = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    const int modules = 33;
    final double cell = size.width / modules;

    canvas.drawRect(Offset.zero & size, white);

    for (int y = 0; y < modules; y++) {
      for (int x = 0; x < modules; x++) {
        if (_isReservedArea(x, y, modules)) continue;

        final hash = ((x * 29 + y * 43 + x * y * 11) ^ (x * 17 + y * 23)) % 7;
        if (hash < 3) {
          canvas.drawRect(
            Rect.fromLTWH(x * cell, y * cell, cell + 0.2, cell + 0.2),
            black,
          );
        }
      }
    }

    for (int i = 8; i < modules - 8; i++) {
      if (i % 2 == 0) {
        canvas.drawRect(Rect.fromLTWH(i * cell, 6 * cell, cell, cell), black);
        canvas.drawRect(Rect.fromLTWH(6 * cell, i * cell, cell, cell), black);
      }
    }

    _drawFinder(canvas, 0, 0, cell, black, white);
    _drawFinder(canvas, modules - 7, 0, cell, black, white);
    _drawFinder(canvas, 0, modules - 7, cell, black, white);

    _drawAlignment(canvas, 24, 24, cell, black, white);
    _drawAlignment(canvas, 14, 14, cell, black, white);
    _drawAlignment(canvas, 4, 14, cell, black, white);
    _drawAlignment(canvas, 24, 14, cell, black, white);
    _drawAlignment(canvas, 14, 24, cell, black, white);
  }

  bool _isReservedArea(int x, int y, int modules) {
    if ((x < 8 && y < 8) ||
        (x >= modules - 8 && y < 8) ||
        (x < 8 && y >= modules - 8)) {
      return true;
    }
    if (x == 6 || y == 6) return true;

    final alignments = [
      const Offset(24, 24),
      const Offset(14, 14),
      const Offset(4, 14),
      const Offset(24, 14),
      const Offset(14, 24),
    ];
    for (final center in alignments) {
      if ((x - center.dx).abs() <= 2 && (y - center.dy).abs() <= 2) {
        return true;
      }
    }
    return false;
  }

  void _drawFinder(
    Canvas canvas,
    int startX,
    int startY,
    double cell,
    Paint black,
    Paint white,
  ) {
    final x = startX * cell;
    final y = startY * cell;

    canvas.drawRect(Rect.fromLTWH(x, y, cell * 7, cell * 7), black);
    canvas.drawRect(Rect.fromLTWH(x + cell, y + cell, cell * 5, cell * 5), white);
    canvas.drawRect(
        Rect.fromLTWH(x + cell * 2, y + cell * 2, cell * 3, cell * 3), black);
  }

  void _drawAlignment(
    Canvas canvas,
    int centerX,
    int centerY,
    double cell,
    Paint black,
    Paint white,
  ) {
    final x = (centerX - 2) * cell;
    final y = (centerY - 2) * cell;

    canvas.drawRect(Rect.fromLTWH(x, y, cell * 5, cell * 5), black);
    canvas.drawRect(Rect.fromLTWH(x + cell, y + cell, cell * 3, cell * 3), white);
    canvas.drawRect(
        Rect.fromLTWH(x + cell * 2, y + cell * 2, cell, cell), black);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}