// ignore_for_file: must_be_immutable

part of 'gift_cards1_bloc.dart';

/// Represents the state of GiftCards1 in the application.
class GiftCards1State extends Equatable {
  GiftCards1State({this.giftCards1ModelObj});

  GiftCards1Model? giftCards1ModelObj;

  @override
  List<Object?> get props => [
        giftCards1ModelObj,
      ];
  GiftCards1State copyWith({GiftCards1Model? giftCards1ModelObj}) {
    return GiftCards1State(
      giftCards1ModelObj: giftCards1ModelObj ?? this.giftCards1ModelObj,
    );
  }
}
