import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/transaction_repo.dart';

class WalletBalanceCubit extends Cubit<double> {
  final TransactionRepository repository;
  StreamSubscription<double>? _sub;

  WalletBalanceCubit({required this.repository}) : super(0.0);

  void start(String uid) {
    _sub?.cancel();
    _sub = repository.watchWalletBalance(uid).listen(emit);
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
