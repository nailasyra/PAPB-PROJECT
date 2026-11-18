
import 'package:flutter/material.dart';
import 'database_helper.dart';

class DatabaseViewerPage extends StatefulWidget {
  const DatabaseViewerPage({super.key});

  @override
  State<DatabaseViewerPage> createState() =>
      _DatabaseViewerPageState();
}

class _DatabaseViewerPageState
    extends State<DatabaseViewerPage> {
  late Future<List<UserModel>> usersFuture;

  @override
  void initState() {
    super.initState();
    usersFuture = DatabaseHelper.instance.getAllUsers();
  }

  void refreshData() {
    setState(() {
      usersFuture = DatabaseHelper.instance.getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text('Database Viewer'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: refreshData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final users = snapshot.data ?? [];

          if (users.isEmpty) {
            return const Center(
              child: Text('Belum ada akun tersimpan'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Akun ${index + 1}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text('ID: ${user.id}'),
                      Text('Email: ${user.email}'),
                      const Text('PIN: ••••'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
