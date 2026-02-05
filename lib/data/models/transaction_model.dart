import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String type; // "send" or "receive"
  final double amount;
  final String currency;
  final String counterparty;
  final String? senderName;
  final DateTime date;
  final String? senderID;
  final String? receiverID;

  TransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.currency,
    required this.counterparty,
    required this.date,
    this.senderID,
    this.receiverID,
    this.senderName,
  });

  // Firestore -> Model
  factory TransactionModel.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();

    return TransactionModel(
      id: data['id'] ?? doc.id,
      senderID: data['senderID'],
      receiverID: data['receiverID'],
      type: data['type'],
      amount: (data['amount'] as num).toDouble(),
      currency: data['currency'],
      counterparty: data['counterparty'],
      date: (data['date'] as Timestamp).toDate(),
      senderName: data['senderName'],
    );
  }

  // Local Map / SQLite / API -> Model
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      senderID: map['senderID'],
      receiverID: map['receiverID'],
      type: map['type'],
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'],
      counterparty: map['counterparty'],
      date: DateTime.parse(map['date']),
      senderName: map['senderName'],
    );
  }

  // Model -> Firestore
  Map<String, dynamic> toFirestore() => {
    'id': id,
    'senderID': senderID,
    'receiverID': receiverID,
    'type': type,
    'amount': amount,
    'currency': currency,
    'counterparty': counterparty,
    'date': Timestamp.fromDate(date),
  };

  // Model -> Local Map
  Map<String, dynamic> toMap() => {
    'id': id,
    'senderID': senderID,
    'receiverID': receiverID,
    'type': type,
    'amount': amount,
    'currency': currency,
    'counterparty': counterparty,
    'date': date.toIso8601String(),
  };
}
