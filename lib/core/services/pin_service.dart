import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';


import '../../data/models/pin_model.dart';
import 'db_service.dart';

class PinService {
  static const _table = 'pin';

  // Generate secure random salt
  String _generateSalt() {
    final random = Random.secure();
    final bytes = List<int>.generate(16, (_) => random.nextInt(256));
    return base64Encode(bytes);
  }

  // Hash PIN using SHA-256
  String _hashPin(String pin, String salt) {
    final bytes = utf8.encode('$pin$salt');
    return sha256.convert(bytes).toString();
  }

  Future<PinModel> savePin(String pin, String uid) async {
    final db = await DBService.database;

    final salt = _generateSalt();
    final hash = _hashPin(pin, salt);

    // ensure single PIN only
    await db.delete(_table);

    await db.insert(_table, {'uid': uid, 'hash': hash, 'salt': salt});
    return PinModel(pin: pin, userId: uid);
  }

  Future<bool> verifyPin(String pin, String uid) async {
    final db = await DBService.database;

    final result = await db.query(_table, limit: 1);
    if (result.isEmpty) return false;

    final storedHash = result.first['hash'] as String;
    final salt = result.first['salt'] as String;

    final inputHash = _hashPin(pin, salt);
    return inputHash == storedHash;
  }

  Future<bool> isPinSet(String uid) async {
    final db = await DBService.database;
    final result = await db.query(_table, limit: 1);
    return result.isNotEmpty;
  }

  Future<void> clearPin() async {
    final db = await DBService.database;
    await db.delete(_table);
  }
}
