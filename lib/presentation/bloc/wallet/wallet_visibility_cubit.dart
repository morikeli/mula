import 'package:flutter_bloc/flutter_bloc.dart';

class WalletVisibilityCubit extends Cubit<bool> {
  WalletVisibilityCubit() : super(true);

  void toggle() => emit(!state);
}
