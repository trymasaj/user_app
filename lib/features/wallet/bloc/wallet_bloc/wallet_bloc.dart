import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/core/abstract/base_cubit.dart';
import 'package:masaj/features/wallet/models/wallet_model.dart';
import 'package:masaj/features/wallet/repos/wallet_repo.dart';
import '/core/app_export.dart';
import '../../models/transactionhistory_item_model.dart';
part 'wallet_state.dart';

/// A bloc that manages the state of a Wallet according to the event that is dispatched to it.
class WalletBloc extends BaseCubit<WalletState> {
  WalletBloc(WalletState initialState, this.repo) : super(initialState);

  final WalletRepository repo;

  Future<void> getTransactionHistory() async {
    emit(state.copyWith(status: WalletStateStatus.loading));
    await Future.delayed(Duration(seconds: 2));
    emit(state.copyWith(
        status: WalletStateStatus.loaded,
        wallet: some(Wallet(transactions: fillTransactions()))));
  }

  List<Transaction> fillTransactions() {
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
