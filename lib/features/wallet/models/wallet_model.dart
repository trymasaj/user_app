// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'transactionhistory_item_model.dart';

/// This class defines the variables used in the [wallet_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class WalletModel extends Equatable {
  WalletModel({this.transactionhistoryItemList = const []}) {}

  List<TransactionhistoryItemModel> transactionhistoryItemList;

  WalletModel copyWith(
      {List<TransactionhistoryItemModel>? transactionhistoryItemList}) {
    return WalletModel(
      transactionhistoryItemList:
          transactionhistoryItemList ?? this.transactionhistoryItemList,
    );
  }

  @override
  List<Object?> get props => [transactionhistoryItemList];
}
