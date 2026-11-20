import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../database/database_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static const Color orange = Color(0xFFFF582E);
  static const Color textColor = Color(0xFF222222);
  static const Color greyColor = Color(0xFF999999);

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  String? selectedGender;
  DateTime? selectedBirthday;

  bool get isFormValid {
    final nickname = nicknameController.text.trim();
    final email = emailController.text.trim();

    final nicknameValid = RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(nickname);
    final emailValid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);

    return nickname.isNotEmpty && nicknameValid && emailValid;
  }

  @override
  void initState() {
    super.initState();
    nicknameController.addListener(updateForm);
    emailController.addListener(updateForm);
  }

  void updateForm() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    nicknameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String get birthdayText {
    if (selectedBirthday == null) {
      return 'Select your birthday';
    }

    final date = selectedBirthday!;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // GENDER PICKER
  void showGenderPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 1),

              _genderOption('Male', sheetContext),
              const Divider(height: 1),

              _genderOption('Female', sheetContext),
              const Divider(height: 1),

              _genderOption('Keep secret', sheetContext),
              const SizedBox(height: 1),

              const Divider(height: 1, thickness: 4),

              SizedBox(
                height: 55,
                child: Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _genderOption(String gender, BuildContext sheetContext) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedGender = gender;
          });
          Navigator.pop(sheetContext);
        },
        child: Text(
          gender,
          style: const TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // BIRTHDAY PICKER
  void showBirthdayPicker() {
    DateTime tempDate = selectedBirthday ?? DateTime(2006, 11, 17);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              // Header Cancel dan Done
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedBirthday = tempDate;
                        });
                        Navigator.pop(sheetContext);
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Color(0xFFFF7545),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Wheel Date Picker
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  dateOrder: DatePickerDateOrder.dmy,
                  initialDateTime: tempDate,
                  maximumDate: DateTime.now(),
                  use24hFormat: true,
                  onDateTimeChanged: (date) {
                    tempDate = date;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // TEXT INPUT FIELD
  Widget buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: const TextStyle(
            fontSize: 13,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: greyColor,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),

            // Atur jarak tulisan ke garis
            isDense: true,
            contentPadding: const EdgeInsets.only(top: 0, bottom: 5),

            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFDADADA)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 191, 184, 182),
                width: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // GENDER AND BIRTHDAY FIELD
  Widget buildSelectionField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final isPlaceholder = value.startsWith('Select');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFDADADA))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      color: isPlaceholder ? greyColor : textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFBDBDBD),
                  size: 27,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // MOVE TO STEP 2
  Future<void> continueRegister() async {
    if (!isFormValid) return;

    final user = await Navigator.push<UserModel>(
      context,
      MaterialPageRoute(
        builder: (context) => CreatePinPage(
          nickname: nicknameController.text.trim(),
          email: emailController.text.trim(),
          gender: selectedGender,
          birthday: selectedBirthday,
        ),
      ),
    );

    // Jika pembuatan akun berhasil, kirim data user kembali ke Me Page.
    if (user != null && mounted) {
      Navigator.pop(context, user);
    }
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER: ilustrasi tidak terkena padding form.
                    SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            right: -20,
                            top: -50,
                            child: Image.asset(
                              'assets/images/backgrounds/iconcreate.png',
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                            ),
                          ),
                          Positioned(
                            left: 12,
                            top: 12,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                color: textColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // FORM: padding hanya berlaku untuk bagian ini.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 25),

                          // STEP PROGRESS
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Container(
                                width: 50,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDADADA),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          buildInputField(
                            label: 'Nick Name*',
                            hint: 'Latin alphabet, number, no emoji/symbol',
                            controller: nicknameController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[a-zA-Z0-9 ]'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          buildInputField(
                            label: 'Email*',
                            hint: 'e.g. name@email.com',
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          buildSelectionField(
                            label: 'Gender',
                            value: selectedGender ?? 'Select your gender',
                            onTap: showGenderPicker,
                          ),
                          const SizedBox(height: 20),

                          buildSelectionField(
                            label: 'Birthday',
                            value: birthdayText,
                            onTap: showBirthdayPicker,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // CONTINUE BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isFormValid ? continueRegister : null,
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
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// STEP 2 - CREATE PIN
// ============================================================

class CreatePinPage extends StatefulWidget {
  final String nickname;
  final String email;
  final String? gender;
  final DateTime? birthday;

  const CreatePinPage({
    super.key,
    required this.nickname,
    required this.email,
    this.gender,
    this.birthday,
  });

  @override
  State<CreatePinPage> createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  static const Color orange = Color(0xFFFF582E);

  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();

  bool isVisible = false;

  bool get isPinValid => pinController.text.length == 6;

  @override
  void dispose() {
    pinController.dispose();
    pinFocusNode.dispose();
    super.dispose();
  }

  Future<void> registerAccount() async {
    if (!isPinValid) return;

    // Simpan tanggal lahir dalam format YYYY-MM-DD.
    final birthdayText = widget.birthday == null
        ? null
        : '${widget.birthday!.year.toString().padLeft(4, '0')}-'
          '${widget.birthday!.month.toString().padLeft(2, '0')}-'
          '${widget.birthday!.day.toString().padLeft(2, '0')}';

    try {
      // Cek apakah email sudah terdaftar.
      final existingUser = await DatabaseHelper.instance
          .getUserByEmail(widget.email.trim());

      if (existingUser != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email sudah terdaftar. Gunakan email lain.'),
          ),
        );
        return;
      }

     final user = UserModel(
  nickname: widget.nickname.trim(),
  email: widget.email.trim(),
  gender: widget.gender,
  birthday: birthdayText,
  pin: pinController.text,
);

// Simpan akun dan ambil ID dari SQLite
final insertedId =
    await DatabaseHelper.instance.insertUser(user);

// Buat UserModel baru yang sudah memiliki ID
final registeredUser = UserModel(
  id: insertedId,
  nickname: user.nickname,
  email: user.email,
  gender: user.gender,
  birthday: user.birthday,
  pin: user.pin,
);

if (!mounted) return;

// Kirim UserModel yang sudah memiliki ID
Navigator.pop(context, registeredUser);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registrasi gagal: $e'),
        ),
      );
    }
  }

  Widget _buildPinSlots() {
    return GestureDetector(
      onTap: () => pinFocusNode.requestFocus(),
      child: SizedBox(
        height: 58,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: List.generate(6, (index) {
                final pin = pinController.text;
                final hasValue = index < pin.length;

                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index == 5 ? 0 : 10),
                    height: 55,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFDADADA), width: 2),
                      ),
                    ),
                    child: Text(
                      hasValue ? (isVisible ? pin[index] : '●') : '',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                );
              }),
            ),

            // TextField transparan untuk menerima input dan keyboard.
            Positioned.fill(
              child: Opacity(
                opacity: 0,
                child: TextField(
                  controller: pinController,
                  focusNode: pinFocusNode,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ),
          ],
        ),
      ),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER: ilustrasi full width.
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Image.asset(
                              'assets/images/backgrounds/iconpin.png',
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              fit: BoxFit.contain,
                              alignment: Alignment.topRight,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            left: 12,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // CONTENT STEP 2.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create Your PIN',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF222222),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // PROGRESS STEP 2
                          Row(
                            children: [
                              Container(
                                width: 50,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Container(
                                width: 50,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: orange,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // LABEL DAN TOMBOL LIHAT PIN
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Create a 6-digit login PIN',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF999999),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(
                                  isVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey,
                                  size: 27,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          _buildPinSlots(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // REGISTER BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 12, 32, 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isPinValid ? registerAccount : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    disabledBackgroundColor: const Color(0xFFC8C8C8),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _progressBar() {
    return Container(
      width: 85,
      height: 8,
      decoration: BoxDecoration(
        color: orange,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
