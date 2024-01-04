import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/settings_tab/presentation/pages/wallet_screen/models/wallet_model.dart';
import '/core/app_export.dart';
import '../models/transactionhistory_item_model.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

/// A bloc that manages the state of a Wallet according to the event that is dispatched to it.
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc(WalletState initialState) : super(initialState) {
    on<WalletInitialEvent>(_onInitialize);
  }

  _onInitialize(
    WalletInitialEvent event,
    Emitter<WalletState> emit,
  ) async {
    emit(state.copyWith(
        walletModelObj: state.walletModelObj?.copyWith(
            transactionhistoryItemList: fillTransactionhistoryItemList())));
  }

  List<TransactionhistoryItemModel> fillTransactionhistoryItemList() {
    return [
      TransactionhistoryItemModel(
          transactionTitle: "Wallet top up",
          transactionDate: "12 march 2023 - 2:00 pm",
          transactionAmount: "+ 5.00 KD"),
      TransactionhistoryItemModel(
          transactionTitle: "Booking massage",
          transactionDate: "12 march 2023 - 2:00 pm",
          transactionAmount: "- 28.00 KD"),
      TransactionhistoryItemModel(
          transactionTitle: "Wallet top up",
          transactionDate: "12 march 2023 - 2:00 pm",
          transactionAmount: "+ 12.00 KD")
    ];
  }
}
