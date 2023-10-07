part of 'home_search_bloc.dart';

enum HomeSearchEventStatus { initial, search, loadMore }

extension on HomeSearchEvent {
  bool get isInitial => status == HomeSearchEventStatus.initial;
  bool get isSearch => status == HomeSearchEventStatus.search;
  bool get isLoadMore => status == HomeSearchEventStatus.loadMore;
}

@immutable
class HomeSearchEvent {
  final HomeSearchEventStatus status;
  final String? searchText;

  const HomeSearchEvent({
    required this.status,
    this.searchText,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other.runtimeType == runtimeType &&
        (other as HomeSearchEvent).status == status &&
        other.searchText == searchText;
  }

  @override
  int get hashCode => status.hashCode ^ searchText.hashCode;

  HomeSearchEvent copyWith({
    HomeSearchEventStatus? status,
    String? searchText,
  }) {
    return HomeSearchEvent(
      status: status ?? this.status,
      searchText: searchText ?? this.searchText,
    );
  }
}
