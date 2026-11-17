
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// MODEL USER
class UserModel {
  final int? id;
  final String nickname;
  final String email;
  final String? gender;
  final String? birthday;
  final String pin;

  UserModel({
    this.id,
    required this.nickname,
    required this.email,
    this.gender,
    this.birthday,
    required this.pin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'email': email,
      'gender': gender,
      'birthday': birthday,
      'pin': pin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nickname: map['nickname'],
      email: map['email'],
      gender: map['gender'],
      birthday: map['birthday'],
      pin: map['pin'],
    );
  }
}

// DATABASE HELPER
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('tomoro.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nickname TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            gender TEXT,
            birthday TEXT,
            pin TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // INSERT USER
  Future<int> insertUser(UserModel user) async {
    final db = await database;

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

// UPDATE USER
Future<int> updateUser(UserModel user) async {
  final db = await database;

  return await db.update(
    'users',
    {
      'nickname': user.nickname,
      'email': user.email,
      'gender': user.gender,
    },
    where: 'id = ?',
    whereArgs: [user.id],
    conflictAlgorithm: ConflictAlgorithm.abort,
  );
}
  // GET USER BY EMAIL
  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }

    return null;
  }

  // GET ALL USERS
  Future<List<UserModel>> getAllUsers() async {
    final db = await database;

    final result = await db.query('users');

    return result.map((map) => UserModel.fromMap(map)).toList();
  }

  // DELETE USER
  Future<int> deleteUser(int id) async {
    final db = await database;

    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
