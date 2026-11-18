import 'package:flutter/material.dart';

import '../database/database_helper.dart';

class DeleteAccountPage extends StatelessWidget {
  final UserModel user;
  final VoidCallback onAccountDeleted;

  const DeleteAccountPage({
    super.key,
    required this.user,
    required this.onAccountDeleted,
  });

  static const Color orange = Color(0xFFFF5428);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
            size: 22,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Delete Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notice',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Deleting an account cannot be recovered, please make sure you accept all of the following:\n'
              '1. After the account is deleted, the account and all associated data will be completely deleted and cannot be recovered.\n'
              '2. The deleted data includes but is not limited to the following: order records, personal profile, vouchers, points, etc.\n'
              '3. After the account is deleted, you can register again, but it will no longer enjoy all the rights of the new user.',
              style: TextStyle(fontSize: 15, height: 1.85, color: Colors.black),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 53,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      'Deleting Your Account',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pop(dialogContext),
                                    child: const Icon(Icons.close, size: 23),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              const Text(
                                'Continue deleting your account? This operation is not reversible',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.3,
                                ),
                              ),

                              const SizedBox(height: 22),

                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pop(dialogContext);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: orange,
                                        side: const BorderSide(
                                          color: orange,
                                          width: 2,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 15),

                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        debugPrint('User ID: ${user.id}');
                                        debugPrint('User Email: ${user.email}');

                                        if (user.id == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'User ID tidak ditemukan!',
                                                  ),
                                                ),
                                              );
                                          return;
                                        }

                                        try {
                                          final deletedRows =
                                              await DatabaseHelper.instance
                                                  .deleteUser(user.id!);

                                          if (!context.mounted) return;

                                          if (deletedRows == 0) {
                                            Navigator.pop(dialogContext);

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      'Account not found in database.',
                                                    ),
                                                  ),
                                                );
                                            return;
                                          }

                                          // Tutup dialog konfirmasi
                                          Navigator.pop(dialogContext);

                                          // Update status login menjadi Guest
                                          onAccountDeleted();

                                          // Tampilkan halaman sukses
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) =>
                                                  const AccountDeletedPage(),
                                            ),
                                          );
                                        } catch (e) {
                                          debugPrint('Delete error: $e');

                                          if (!context.mounted) return;

                                          Navigator.pop(dialogContext);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Failed to delete account.',
                                                  ),
                                                ),
                                              );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: orange,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Agree & Continue',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountDeletedPage extends StatelessWidget {
  const AccountDeletedPage({super.key});

  static const Color orange = Color(0xFFFF5428);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Container(
                width: 110,
                height: 110,
                decoration: const BoxDecoration(
                  color: Color(0xFFE6F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Color(0xFF39B65A),
                  size: 65,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                'Account deleted successfully',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 53,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup halaman sukses
                    Navigator.pop(context); // Tutup Settings
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Return Home',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
