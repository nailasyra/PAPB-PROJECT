import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class MyProfilePage extends StatefulWidget {
  final UserModel user;

  const MyProfilePage({super.key, required this.user});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late TextEditingController nicknameController;
  late TextEditingController emailController;

  String gender = '';
  String birthday = '';

  @override
  void initState() {
    super.initState();

    nicknameController = TextEditingController(text: widget.user.nickname);
    emailController = TextEditingController(text: widget.user.email);

    gender = widget.user.gender ?? '';
    birthday = _formatBirthday(widget.user.birthday ?? '');
  }

  String _formatBirthday(String value) {
    if (value.isEmpty) return '';

    try {
      final date = DateTime.parse(value);

      return '${date.day.toString().padLeft(2, '0')}/'
          '${date.month.toString().padLeft(2, '0')}/'
          '${date.year}';
    } catch (_) {
      return value;
    }
  }

  void showCenterToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 45, 44, 44),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(color: Color.fromARGB(221, 244, 242, 242)),
            ),
          ),
        ),
      ),
    );

    overlay.insert(entry);

    Future.delayed(const Duration(seconds: 2), () {
      entry.remove();
    });
  }

  @override
  void dispose() {
    nicknameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _chooseGender() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Male', 'Female', 'Keep secret'].map((value) {
            return ListTile(
              title: Text(value),
              onTap: () {
                setState(() => gender = value);
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _chooseBirthday() async {
    final initialDate =
        DateTime.tryParse(widget.user.birthday ?? '') ?? DateTime(2006, 1, 1);

    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      setState(() {
        birthday =
            '${selected.day.toString().padLeft(2, '0')}/'
            '${selected.month.toString().padLeft(2, '0')}/'
            '${selected.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,

        elevation: 6,
        scrolledUnderElevation: 10,
        shadowColor: const Color(0x26000000),

        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(32, 20, 32, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // PROFILE IMAGE
                    Center(
                      child: Image.asset(
                        'assets/images/icon/profil.png',
                        width: 130,
                        height: 130,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // NICKNAME
                    _label('Nick Name *'),
                    _textField(nicknameController),

                    const SizedBox(height: 15),

                    // EMAIL
                    _label('Email'),
                    _textField(emailController),

                    const SizedBox(height: 15),

                    // PIN
                    _label('PIN'),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            '••••••',
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Fitur Reset PIN akan dibuat berikutnya.',
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Reset',
                            style: TextStyle(
                              color: Color(0xFF6798CF),
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Divider(color: Color(0xFFD6D6D6)),

                    const SizedBox(height: 15),

                    // GENDER
                    _label('Gender'),

                    InkWell(
                      onTap: _chooseGender,
                      child: _selectionField(
                        gender.isEmpty ? 'Select gender' : gender,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // BIRTHDAY
                    _label('Birthday'),

                    InkWell(
                      onTap: _chooseBirthday,
                      child: _selectionField(
                        birthday.isEmpty ? 'Select birthday' : birthday,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SAVE BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 5, 32, 15),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () async {
                    final updatedUser = UserModel(
                      id: widget.user.id,
                      nickname: nicknameController.text.trim(),
                      email: emailController.text.trim(),
                      gender: gender.isEmpty ? null : gender,
                      birthday: widget.user.birthday,
                      pin: widget.user.pin,
                    );

                    if (updatedUser.nickname.isEmpty ||
                        updatedUser.email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nick Name dan Email wajib diisi.'),
                        ),
                      );
                      return;
                    }

                    try {
                      await DatabaseHelper.instance.updateUser(updatedUser);

                      if (!mounted) return;

                      Navigator.pop(context, updatedUser);

                      showCenterToast(context, 'Successfully saved');
                    } catch (e) {
                      if (!mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Email sudah digunakan oleh akun lain.',
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF653B),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // LABEL
  Widget _label(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Text(
        title,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }

  // TEXT FIELD
  Widget _textField(
    TextEditingController controller, {
    bool readOnly = false,
    Color textColor = Colors.black,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      style: TextStyle(fontSize: 13, color: textColor),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 8),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6D6D6)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEF653B)),
        ),
      ),
    );
  }

  // SELECTION FIELD
  Widget _selectionField(String value, {Color color = Colors.black}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFD6D6D6))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 13, color: color)),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
