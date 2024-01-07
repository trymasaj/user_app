import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';
import '/core/app_export.dart';
import '../../models/transactionhistory_item_model.dart';
part 'wallet_state.dart';

/// A bloc that manages the state of a Wallet according to the event that is dispatched to it.
class WalletBloc extends BaseCubit<WalletState> {
  WalletBloc(WalletState initialState) : super(initialState) {}

  _onInitialize() async {
    emit(state.copyWith(
        wallet: state.wallet?.copyWith(
            transactions: fillTransactionhistoryItemList())));
  }

  List<Transaction> fillTransactionhistoryItemList() {
    return [
      Transaction(
          transactionTitle: "Wallet top up",
          transactionDate: "12 march 2023 - 2:00 pm",
          transactionAmount: "+ 5.00 KD"),
      Transaction(
          transactionTitle: "Booking massage",
          transactionDate: "12 march 2023 - 2:00 pm",
          transactionAmount: "- 28.00 KD"),
      Transaction(
          transactionTitle: "Wallet top up",
          transactionDate: "12 march 2023 - 2:00 pm",
          transactionAmount: "+ 12.00 KD")
    ];
  }
}
