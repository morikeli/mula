import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/repositories/transaction_repo.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionRepository repository;

  StreamSubscription<List<TransactionModel>>? _recentTxnSub;

  TransactionsBloc({required this.repository}) : super(TransactionsInitial()) {
    on<SendMoneyRequested>(_onSendMoney);
    on<TransactionHistoryRequested>(_onLoadRecentTransactions);
  }

  Future<void> _onSendMoney(
    SendMoneyRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    emit(TransactionLoading());

    try {
      await repository.sendMoney(event.txn);

      emit(TransactionSuccess(message: "Money sent successfully!"));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  Future<void> _onLoadRecentTransactions(
    TransactionHistoryRequested event,
    Emitter<TransactionsState> emit,
  ) async {
    await _recentTxnSub?.cancel(); // cancel previous stream subscription
    emit(TransactionLoading());

    await emit.forEach<List<TransactionModel>>(
      repository.recentTransactions(),
      onData: (transactions) {
        return TransactionHistoryLoaded(transactions: transactions);
      },
      onError: (error, stackTrace) {
        return TransactionFailed(error.toString());
      },
    );
  }
}
