import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/database_helper.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const Color orange = Color(0xFFFF582E);
  static const Color textColor = Color(0xFF222222);
  static const Color greyColor = Color(0xFF999999);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  bool isPinVisible = false;
  bool isLoading = false;

  bool get isFormValid =>
      emailController.text.trim().isNotEmpty &&
      emailController.text.trim().contains('@') &&
      pinController.text.length == 6;

  @override
  void dispose() {
    emailController.dispose();
    pinController.dispose();
    super.dispose();
  }

  Future<void> loginAccount() async {
    if (!isFormValid || isLoading) return;

    setState(() => isLoading = true);

    try {
      final user = await DatabaseHelper.instance
          .getUserByEmail(emailController.text.trim());

      if (!mounted) return;

      if (user == null || user.pin != pinController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email atau PIN tidak sesuai.'),
          ),
        );
        return;
      }

      // Kirim data pengguna kembali ke Me Page.
      Navigator.pop(context, user);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> openRegister() async {
    final user = await Navigator.push<UserModel>(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );

    // Jika user selesai register dari halaman ini, teruskan ke Me Page.
    if (user != null && mounted) {
      Navigator.pop(context, user);
    }
  }

  Widget buildInput({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    Widget? suffixIcon,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          onChanged: (_) => setState(() {}),
          style: const TextStyle(
            fontSize: 15,
            color: textColor,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 14,
            ),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFDADADA)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: orange, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new),
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                    ),
                    const SizedBox(height: 38),
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Login to your TOMORO account',
                      style: TextStyle(
                        fontSize: 14,
                        color: greyColor,
                      ),
                    ),
                    const SizedBox(height: 42),
                    buildInput(
                      label: 'Email',
                      hint: 'Enter your email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),
                    buildInput(
                      label: 'PIN',
                      hint: 'Enter your 6-digit PIN',
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      obscureText: !isPinVisible,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() => isPinVisible = !isPinVisible);
                        },
                        icon: Icon(
                          isPinVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: greyColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed:
                            isFormValid && !isLoading ? loginAccount : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          disabledBackgroundColor: const Color(0xFFC8C8C8),
                          foregroundColor: Colors.white,
                          disabledForegroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: greyColor,
                            fontSize: 13,
                          ),
                        ),
                        GestureDetector(
                          onTap: openRegister,
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              color: orange,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
