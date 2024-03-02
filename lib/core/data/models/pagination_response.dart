import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaginationResponse<T> extends Equatable {
  static const empty = PaginationResponse(
    data: [],
    page: 0,
    pageSize: 0,
    totalCount: 0,
    totalPages: 0,
  );
  final List<T>? data;
  final int? page;
  final int? pageSize;
  final int? totalCount;
  final int? totalPages;
  const PaginationResponse({
    required this.data,
    required this.page,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  // copy with
  PaginationResponse copyWith({
    List<T>? data,
    int? page,
    int? pageSize,
    int? totalCount,
    int? totalPages,
  }) {
    return PaginationResponse(
      data: data ?? this.data,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
    );
  }

// from map
  factory PaginationResponse.fromMap(Map<String, dynamic> json,
      {required T Function(Map<String, dynamic>) mapperFunc}) {
    return PaginationResponse(
      data: List<T>.from(json['data'].map((x) => mapperFunc(x))),
      page: json['page'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }
  // to map
  Map<String, dynamic> toMap({Map<String, dynamic> Function(T)? mapperFunc}) {
    return {
      if (mapperFunc != null)
        'data': data == null
            ? null
            : List<dynamic>.from(data!.map((x) => mapperFunc(x))),
      'page': page,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
    };
  }

  factory PaginationResponse.fromJson(String source,
          {required T Function(Map<String, dynamic>) mapperFunc}) =>
      PaginationResponse.fromMap(json.decode(source), mapperFunc: mapperFunc);

  String toJson(
          {Map<String, dynamic> Function(T)? mapperFunc,
          bool prettify = false}) =>
      json.encode(toMap(mapperFunc: mapperFunc));

  @override
  List<Object?> get props => [data, page, pageSize, totalCount, totalPages];
}
