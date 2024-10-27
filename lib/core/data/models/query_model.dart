import 'package:equatable/equatable.dart';

class QueryModel extends Equatable {
  final String? searchKey;

  final int? page;
  final int? pageSize;

  const QueryModel({
    this.searchKey,
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'SearchKey': searchKey,
      'Page': page,
      'PageSize': pageSize,
    }..removeWhere((key, value) => value == null);
  }

  // from map
  factory QueryModel.fromMap(Map<String, dynamic> json) {
    return QueryModel(
      searchKey: json['SearchKey'],
      page: json['Page'],
      pageSize: json['PageSize'],
    );
  }
  // copy with
  QueryModel copyWith({
    int? categoryId,
    String? searchKeyword,
    double? priceFrom,
    double? priceTo,
    int? page,
    int? pageSize,
  }) {
    return QueryModel(
      searchKey: searchKeyword ?? this.searchKey,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
        searchKey,
        page,
        pageSize,
      ];
}
