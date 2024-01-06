import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:masaj/features/wallet/models/top_up_wallet_model.dart';
import '/core/app_export.dart';
import '../../models/userprofile8_item_model.dart';
part 'top_up_wallet_event.dart';
part 'top_up_wallet_state.dart';

/// A bloc that manages the state of a TopUpWallet according to the event that is dispatched to it.
class TopUpWalletBloc extends Bloc<TopUpWalletEvent, TopUpWalletState> {
  TopUpWalletBloc(TopUpWalletState initialState) : super(initialState) {
    on<TopUpWalletInitialEvent>(_onInitialize);
  }

  _onInitialize(
    TopUpWalletInitialEvent event,
    Emitter<TopUpWalletState> emit,
  ) async {
    emit(state.copyWith(
        topUpWalletModelObj: state.topUpWalletModelObj
            ?.copyWith(userprofile8ItemList: fillUserprofile8ItemList())));
  }

  List<Userprofile8ItemModel> fillUserprofile8ItemList() {
    return [
      Userprofile8ItemModel(
          clockImage: ImageConstant.imgClock,
          fiveText: "5",
          kwdText: "KWD",
          freeKwdText: "+ Free 1 KWD")
    ];
  }
}
