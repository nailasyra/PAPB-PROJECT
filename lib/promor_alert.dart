import 'dart:async';

import 'package:flutter/material.dart';

/// Tampilkan promo fullscreen saat app dibuka.
/// Otomatis tertutup setelah [seconds] detik, atau saat tombol Skip ditekan.
Future<void> showPromoAlert(
  BuildContext context, {
  String imagePath = 'assets/images/backgrounds/image.png',
  int seconds = 3,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: 'Promo',
    barrierColor: Colors.black,
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, __, ___) => PromoAlert(
      imagePath: imagePath,
      seconds: seconds,
    ),
    transitionBuilder: (_, animation, __, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}

class PromoAlert extends StatefulWidget {
  final String imagePath;
  final int seconds;

  const PromoAlert({
    super.key,
    required this.imagePath,
    this.seconds = 3,
  });

  @override
  State<PromoAlert> createState() => _PromoAlertState();
}

class _PromoAlertState extends State<PromoAlert> {
  late int remaining;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    remaining = widget.seconds;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining <= 1) {
        close();
      } else {
        setState(() => remaining--);
      }
    });
  }

  void close() {
    timer?.cancel();
    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Gambar promo full layar
          Positioned.fill(
            child: Image.asset(
              widget.imagePath,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          // Tombol Skip
          Positioned(
            right: 20,
            bottom: 40,
            child: SafeArea(
              child: GestureDetector(
                onTap: close,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Skip ${remaining}s',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}