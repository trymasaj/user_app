import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/wallet/models/top_up_wallet_payment_method_model.dart';
import '/core/app_export.dart';
part 'top_up_wallet_payment_method_event.dart';
part 'top_up_wallet_payment_method_state.dart';

/// A bloc that manages the state of a TopUpWalletPaymentMethod according to the event that is dispatched to it.
class TopUpWalletPaymentMethodBloc
    extends Bloc<TopUpWalletPaymentMethodEvent, TopUpWalletPaymentMethodState> {
  TopUpWalletPaymentMethodBloc(TopUpWalletPaymentMethodState initialState)
      : super(initialState) {
    on<TopUpWalletPaymentMethodInitialEvent>(_onInitialize);
  }

  _onInitialize(
    TopUpWalletPaymentMethodInitialEvent event,
    Emitter<TopUpWalletPaymentMethodState> emit,
  ) async {}
}
