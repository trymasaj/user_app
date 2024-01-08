import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/wallet/models/top_up_wallet_payment_method_model.dart';
import '/core/app_export.dart';
part 'top_up_wallet_payment_method_state.dart';

/// A bloc that manages the state of a TopUpWalletPaymentMethod according to the event that is dispatched to it.
class TopUpWalletPaymentMethodBloc
    extends BaseCubit<TopUpWalletPaymentMethodState> {
  TopUpWalletPaymentMethodBloc(TopUpWalletPaymentMethodState initialState)
      : super(initialState) {}

  _onInitialize() async {}
}
