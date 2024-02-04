import 'package:equatable/equatable.dart';

class ServiceQueryModel extends Equatable {
  int? categoryId;
  String? searchKeyword;
  double? priceFrom;
  double? priceTo;
  int? page;
  int? pageSize;

  ServiceQueryModel({
    this.categoryId,
    this.searchKeyword,
    this.priceFrom,
    this.priceTo,
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toMap() {
    return {
      'CategoryId': categoryId,
      'SearchKeyword': searchKeyword,
      'PriceFrom': priceFrom,
      'PriceTo': priceTo,
      'Page': page,
      'PageSize': pageSize,
    }..removeWhere((key, value) => value == null);
  }

  // from map
  factory ServiceQueryModel.fromMap(Map<String, dynamic> json) {
    return ServiceQueryModel(
      categoryId: json['CategoryId'],
      searchKeyword: json['SearchKeyword'],
      priceFrom: json['PriceFrom'],
      priceTo: json['PriceTo'],
      page: json['Page'],
      pageSize: json['PageSize'],
    );
  }
  // copy with
  ServiceQueryModel copyWith({
    int? categoryId,
    String? searchKeyword,
    double? priceFrom,
    double? priceTo,
    int? page,
    int? pageSize,
  }) {
    return ServiceQueryModel(
      categoryId: categoryId ?? this.categoryId,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object?> get props => [
        categoryId,
        searchKeyword,
        priceFrom,
        priceTo,
        page,
        pageSize,
      ];
}
