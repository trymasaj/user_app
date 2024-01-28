import 'package:equatable/equatable.dart';

class ServiceQueryModel extends Equatable {
  int? categoryId;
  String? searchKeyword;
  double? priceFrom;
  double? priceTo;

  ServiceQueryModel({
    this.categoryId,
    this.searchKeyword,
    this.priceFrom,
    this.priceTo,
  });

  Map<String, dynamic> toMap() {
    return {
      'CategoryId': categoryId,
      'SearchKeyword': searchKeyword,
      'PriceFrom': priceFrom,
      'PriceTo': priceTo,
    }..removeWhere((key, value) => value == null);
  }

  // from map
  factory ServiceQueryModel.fromMap(Map<String, dynamic> json) {
    return ServiceQueryModel(
      categoryId: json['CategoryId'],
      searchKeyword: json['SearchKeyword'],
      priceFrom: json['PriceFrom'],
      priceTo: json['PriceTo'],
    );
  }
  // copy with
  ServiceQueryModel copyWith({
    int? categoryId,
    String? searchKeyword,
    double? priceFrom,
    double? priceTo,
  }) {
    return ServiceQueryModel(
      categoryId: categoryId ?? this.categoryId,
      searchKeyword: searchKeyword ?? this.searchKeyword,
      priceFrom: priceFrom ?? this.priceFrom,
      priceTo: priceTo ?? this.priceTo,
    );
  }
  
  @override
  List<Object?> get props => [
        categoryId,
        searchKeyword,
        priceFrom,
        priceTo,
      ];
}
