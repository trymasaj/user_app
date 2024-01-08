// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'userprofile8_item_model.dart';

/// This class defines the variables used in the [top_up_wallet_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class TopUpWalletModel extends Equatable {
  TopUpWalletModel({this.userprofile8ItemList = const []}) {}

  List<Userprofile8ItemModel> userprofile8ItemList;

  TopUpWalletModel copyWith(
      {List<Userprofile8ItemModel>? userprofile8ItemList}) {
    return TopUpWalletModel(
      userprofile8ItemList: userprofile8ItemList ?? this.userprofile8ItemList,
    );
  }

  @override
  List<Object?> get props => [userprofile8ItemList];
}
