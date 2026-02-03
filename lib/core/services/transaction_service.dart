import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TransactionService {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  TransactionService(this._firestore, this._auth);

  User get currentUser {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }
    return user;
  }

  Future<String> getRecipientUid(String emailOrPhone) async {
    final emailQuery = await _firestore
        .collection('users')
        .where('email', isEqualTo: emailOrPhone)
        .limit(1)
        .get();

    if (emailQuery.docs.isNotEmpty) {
      return emailQuery.docs.first.id;
    }

    final phoneQuery = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: emailOrPhone)
        .limit(1)
        .get();

    if (phoneQuery.docs.isEmpty) {
      throw Exception("Recipient account not found");
    }

    return phoneQuery.docs.first.id;
  }

  Future<double> getWalletBalance(
    String uid, {
    Transaction? transaction,
  }) async {
    final ref = _firestore
        .collection('users')
        .doc(uid)
        .collection('wallet')
        .doc('balance');

    final snap = transaction != null
        ? await transaction.get(ref)
        : await ref.get();

    return (snap.data()?['amount'] ?? 0.0) as double;
  }

  Future<void> runMoneyTransfer({
    required String senderUid,
    required String receiverUid,
    required double amount,
    required Map<String, dynamic> transactionData,
  }) async {
    final senderWalletRef = _firestore
        .collection('users')
        .doc(senderUid)
        .collection('wallet')
        .doc('balance');

    final receiverWalletRef = _firestore
        .collection('users')
        .doc(receiverUid)
        .collection('wallet')
        .doc('balance');

    final transactionRef = _firestore.collection('transactions').doc();

    await _firestore.runTransaction((tx) async {
      final senderBalance = await getWalletBalance(senderUid, transaction: tx);

      if (senderBalance < amount) {
        throw Exception("Insufficient balance");
      }

      final receiverBalance = await getWalletBalance(
        receiverUid,
        transaction: tx,
      );

      tx.update(senderWalletRef, {'amount': senderBalance - amount});

      tx.update(receiverWalletRef, {'amount': receiverBalance + amount});

      tx.set(transactionRef, transactionData);
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> sentTransactionsStream(
    String uid,
  ) {
    return _firestore
        .collection('transactions')
        .where('senderID', isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> receivedTransactionsStream(
    String receiverIdentifier,
  ) {
    return _firestore
        .collection('transactions')
        .where('receiverID', isEqualTo: receiverIdentifier)
        .snapshots();
  }

  Stream<double> walletBalanceStream(String uid) {
    return _firestore
        .collection("users")
        .doc(uid)
        .collection("wallet")
        .doc("balance")
        .snapshots()
        .map((doc) {
          if (!doc.exists) return 0.0;
          return (doc.data()?['amount'] ?? 0.0).toDouble();
        });
  }

  /// Fetches a user's document data for the given [uid]. Returns `null` if
  /// the user document does not exist. This is used by higher-level
  /// repositories to enrich transaction payloads with user display names.
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return doc.data();
  }
}
