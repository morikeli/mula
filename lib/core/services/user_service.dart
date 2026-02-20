import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../data/models/user_model.dart';

import 'db_service.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<UserModel?> getUser() async {
    final db = await DBService.database;
    final res = await db.query('user', where: 'uid = ?', whereArgs: [1]);

    if (res.isNotEmpty) return UserModel.fromMap(res.first);
    return null;
  }

  // search users by username or email
  Future<List<UserModel>> searchUsers(String query) async {
    if (query.isEmpty) return [];

    final snapshot = await _db
        .collection('users')
        .where('searchIndex', arrayContains: query.toLowerCase())
        .limit(15)
        .get();

    return snapshot.docs
        .map((e) => UserModel.fromMap(e.data()))
        .toList();
  }

  Future<String?> uploadProfilePic(File file) async {
    final uid = _auth.currentUser!.uid;

    final ref = _storage.ref().child('profile_pics/$uid.jpg');
    await ref.putFile(file);

    return await ref.getDownloadURL();
  }

  Future<void> updateProfile({
    required String? username,
    required String? firstName,
    required String? lastName,
    String? photoUrl,
  }) async {
    final uid = _auth.currentUser!.uid;

    await _db.collection('users').doc(uid).update({
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      if (photoUrl != null) 'photoUrl': photoUrl,
    });
  }
}
