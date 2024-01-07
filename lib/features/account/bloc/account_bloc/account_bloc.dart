import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/account/models/account_model.dart';
import '/core/app_export.dart';
part 'account_state.dart';

/// A bloc that manages the state of a Account according to the event that is dispatched to it.
class AccountBloc extends BaseCubit<AccountState> {
  AccountBloc(AccountState initialState) : super(initialState) {}

  Future<void> _onInitialize() async {}
}
