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
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
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
                padding: const EdgeInsets.fromLTRB(32, 55, 32, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 145,
                            height: 145,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFF9DCCF),
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 100,
                              color: Color(0xFFFFF0E7),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: const BoxDecoration(
                                color: Colors.grey,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 65),

                    _label('Nick Name *'),
                    _textField(nicknameController),

                    const SizedBox(height: 60),

                    _label('Email'),
                    _textField(emailController),

                    const SizedBox(height: 60),

                    _label('PIN'),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            '••••••',
                            style: TextStyle(
                              fontSize: 25,
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
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(color: Color(0xFFD6D6D6)),

                    const SizedBox(height: 60),

                    _label('Gender'),
                    InkWell(
                      onTap: _chooseGender,
                      child: _selectionField(
                        gender.isEmpty ? 'Select gender' : gender,
                      ),
                    ),

                    const SizedBox(height: 60),

                    _selectionField(birthday, color: Colors.grey),

                   
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 20),
              child: SizedBox(
                width: double.infinity,
                height: 65,
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile berhasil diperbarui!'),
      ),
    );
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email sudah digunakan oleh akun lain.'),
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
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller, {
    bool readOnly = false,
    Color textColor = Colors.black,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      style: TextStyle(fontSize: 20, color: textColor),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.only(bottom: 12),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6D6D6)),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFEF653B)),
        ),
      ),
    );
  }

  Widget _selectionField(String value, {Color color = Colors.black}) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFD6D6D6))),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(value, style: TextStyle(fontSize: 20, color: color)),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 28),
        ],
      ),
    );
  }
}
