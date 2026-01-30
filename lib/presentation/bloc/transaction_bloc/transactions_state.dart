part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsInitial extends TransactionsState {}

final class TransactionLoading extends TransactionsState {}

final class TransactionHistoryLoaded extends TransactionsState {
  final List<TransactionModel> transactions;

  TransactionHistoryLoaded({required this.transactions});
}

final class MoneyTransfer extends TransactionsState {}

final class GetTransactionHistoryFailed extends TransactionsState {
  final String errorMessage;

  GetTransactionHistoryFailed(this.errorMessage);
}

final class TransactionSuccess extends TransactionsState {
  final String message;

  TransactionSuccess({required this.message});
}

final class TransactionFailed extends TransactionsState {
  final String errorMessage;

  TransactionFailed(this.errorMessage);
}
