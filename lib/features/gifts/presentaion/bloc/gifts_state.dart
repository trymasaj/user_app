part of 'gifts_cubit.dart';

enum GiftsStateStatus { initial, loading, loaded, error, deleted, added }

extension GiftsStateX on GiftsState {
  bool get isInitial => status == GiftsStateStatus.initial;
  bool get isLoading => status == GiftsStateStatus.loading;
  bool get isLoaded => status == GiftsStateStatus.loaded;
  bool get isError => status == GiftsStateStatus.error;
  bool get isDeleted => status == GiftsStateStatus.deleted;
  bool get isAdded => status == GiftsStateStatus.added;
}

class GiftsState {
  final GiftsStateStatus status;
  final List<GiftModel>? giftCards;

  final List<PurchasedGiftCard>? purchasedGiftCards;
  final String? errorMessage;

  const GiftsState({
    this.giftCards,
    this.status = GiftsStateStatus.initial,
    this.errorMessage,
    this.purchasedGiftCards,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other.runtimeType == runtimeType &&
        (other as GiftsState).status == status &&
        listEquals(other.giftCards, giftCards) &&
        listEquals(other.purchasedGiftCards, purchasedGiftCards) &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode =>
      status.hashCode ^ errorMessage.hashCode ^ Object.hashAll(giftCards ?? []);

  GiftsState copyWith({
    GiftsStateStatus? status,
    String? errorMessage,
    List<GiftModel>? giftCards,
    List<PurchasedGiftCard>? purchasedGiftCards,
  }) {
    return GiftsState(
      status: status ?? this.status,
      giftCards: giftCards ?? this.giftCards,
      errorMessage: errorMessage ?? this.errorMessage,
      purchasedGiftCards: purchasedGiftCards ?? this.purchasedGiftCards,
    );
  }
}
