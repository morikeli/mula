import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/services/transaction_service.dart';
import '../models/transaction_model.dart';

class TransactionRepository {
  // Underlying service that performs remote operations (Firebase, etc.).
  final TransactionService transactionService;
  TransactionRepository(this.transactionService);

  // Send money according to [txn].
  //
  // Steps performed:
  // - Determine the current user's uid (sender) from the remote service.
  // - Resolve the recipient's uid from the provided `counterparty` identifier.
  // - Validate the sender is not the same as the receiver.
  // - Ask the remote service to run the transfer with a transaction payload.
  // - Generate and persist a local PDF receipt for the transaction.
  //
  // Throws an [Exception] when the transfer is invalid (for example sending
  // to yourself) or when the underlying service throws.
  Future<void> sendMoney(TransactionModel txn) async {
    // Current authenticated user obtained from the service.
    final user = transactionService.currentUser;
    final senderUid = user.uid;

    // Resolve the recipient uid from the counterparty identifier (email,
    // phone or username depending on your app's conventions).
    final receiverUid = await transactionService.getRecipientUid(txn.counterparty);

    // Prevent accidental self-transfer.
    if (receiverUid == senderUid) {
      throw Exception("You cannot send money to yourself");
    }

    // Execute the money transfer on the remote service. The repository maps
    // the domain `TransactionModel` into a simple `Map` payload expected by
    // the service (e.g. Firestore document fields).
    await transactionService.runMoneyTransfer(
      senderUid: senderUid,
      receiverUid: receiverUid,
      amount: txn.amount,
      transactionData: {
        'id': txn.id,
        'senderID': senderUid,
        'receiverID': receiverUid,
        'type': txn.type,
        'amount': txn.amount,
        'currency': txn.currency,
        'counterparty': txn.counterparty,
        // Use server timestamp so times are consistent across devices.
        'date': FieldValue.serverTimestamp(),
      },
    );

    // Generate a local PDF receipt for the transaction for user download or
    // local archival.
    await _generateReceipt(txn);
  }

  // Streams a combined list of recent transactions involving the current
  // user.
  //
  // The method listens to two streams from the service:
  // - transactions sent by the user
  // - transactions received by the user
  //
  // It merges the snapshots, sorts documents by date (newest first) and maps
  // each document into a `TransactionModel` using `TransactionModel.fromFirestore`.
  Stream<List<TransactionModel>> recentTransactions() {
    final user = transactionService.currentUser;

    // Streams of Firestore query snapshots for sent and received txns.
    final sent$ = transactionService.sentTransactionsStream(user.uid);
    final received$ = transactionService.receivedTransactionsStream(user.email ?? '');

    // Combine the two query snapshot streams and produce a single list of
    // `TransactionModel` sorted by date (descending).
    return Rx.combineLatest2<
      QuerySnapshot<Map<String, dynamic>>,
      QuerySnapshot<Map<String, dynamic>>,
      List<TransactionModel>
    >(sent$, received$, (sentSnap, receivedSnap) {
      // Merge documents from both snapshots.
      final docs = [...sentSnap.docs, ...receivedSnap.docs];

      // Sort by `date` field descending. If a document lacks a date, we
      // fall back to epoch so it appears last.
      docs.sort((a, b) {
        final aDate =
            (a.data()['date'] as Timestamp?)?.toDate() ?? DateTime(1970);
        final bDate =
            (b.data()['date'] as Timestamp?)?.toDate() ?? DateTime(1970);
        return bDate.compareTo(aDate);
      });

      // Map Firestore documents into domain models for use by presentation
      // layers.
      return docs.map((doc) => TransactionModel.fromFirestore(doc)).toList();
    });
  }

  // Generates a simple PDF receipt for [txn] and writes it to the
  // application's documents directory.
  //
  // The implementation uses the `pdf` package to build a single-page PDF
  // containing the primary transaction fields and then writes the bytes to
  // a file named `receipt_<txn.id>.pdf` in the app documents directory.
  Future<void> _generateReceipt(TransactionModel txn) async {
    final pdf = pw.Document();

    // Build a basic receipt layout. Keep this simple — if you need richer
    // receipts (logos, tables, localization), extract this into a separate
    // renderer utility.
    pdf.addPage(
      pw.Page(
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Transaction Receipt", style: pw.TextStyle(fontSize: 22)),
            pw.SizedBox(height: 12),
            pw.Text("ID: ${txn.id}"),
            pw.Text("Type: ${txn.type}"),
            pw.Text("Amount: ${txn.currency} ${txn.amount}"),
            pw.Text("Counterparty: ${txn.counterparty}"),
            pw.Text("Date: ${txn.date}"),
          ],
        ),
      ),
    );

    // Resolve a writable directory for the current platform and write the
    // PDF file there so it survives app restarts and can be shared.
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/receipt_${txn.id}.pdf');

    await file.writeAsBytes(await pdf.save());
  }
}
