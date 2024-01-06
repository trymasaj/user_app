
/// This class is used in the [transactionhistory_item_widget] screen.
class TransactionhistoryItemModel {
  TransactionhistoryItemModel({
    this.transactionTitle,
    this.transactionDate,
    this.transactionAmount,
    this.id,
  }) {
    transactionTitle = transactionTitle ?? "Wallet top up";
    transactionDate = transactionDate ?? "12 march 2023 - 2:00 pm";
    transactionAmount = transactionAmount ?? "+ 5.00 KD";
    id = id ?? "";
  }

  String? transactionTitle;

  String? transactionDate;

  String? transactionAmount;

  String? id;
}
