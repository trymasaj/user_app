import 'package:equatable/equatable.dart';

class QueryModel extends Equatable {
  final String? searchKeyword;

  final int? page;
  final int? pageSize;

  const QueryModel({
    this.searchKeyword,
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'SearchKeyword': searchKeyword,
      'Page': page,
      'PageSize': pageSize,
    }..removeWhere((key, value) => value == null);
  }

  // from map
  factory QueryModel.fromMap(Map<String, dynamic> json) {
    return QueryModel(
      searchKeyword: json['SearchKeyword'],
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
      searchKeyword: searchKeyword ?? this.searchKeyword,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
        searchKeyword,
        page,
        pageSize,
      ];
}
