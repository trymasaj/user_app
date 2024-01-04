import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/account/presentation/pages/account_screen/models/account_model.dart';
import '/core/app_export.dart';
part 'account_event.dart';
part 'account_state.dart';

/// A bloc that manages the state of a Account according to the event that is dispatched to it.
class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc(AccountState initialState) : super(initialState) {
    on<AccountInitialEvent>(_onInitialize);
  }

  Future<void>_onInitialize(
    AccountInitialEvent event,
    Emitter<AccountState> emit,
  ) async {}
}
