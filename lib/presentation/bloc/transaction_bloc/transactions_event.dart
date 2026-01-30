part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

final class SendMoneyRequested extends TransactionsEvent {
  final TransactionModel txn;

  SendMoneyRequested(this.txn);
}

final class TransactionHistoryRequested extends TransactionsEvent {}
