import 'package:equatable/equatable.dart';
import 'package:masaj/core/application/controllers/base_cubit.dart';
import 'package:masaj/features/account/models/account_model.dart';

part 'account_state.dart';

/// A bloc that manages the state of a Account according to the event that is dispatched to it.
class AccountBloc extends BaseCubit<AccountState> {
  AccountBloc(super.initialState);

  Future<void> _onInitialize() async {}
}
