// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:masaj/features/wallet/models/transactionhistory_item_model.dart';

/// This class defines the variables used in the [wallet_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class Wallet extends Equatable {
  Wallet({required this.transactions});

  List<Transaction> transactions;

  Wallet copyWith({List<Transaction>? transactions}) {
    return Wallet(
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [transactions];
  factory Wallet.initial() => Wallet(transactions: const []);
}
