// ignore_for_file: void_checks
import 'dart:developer';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/constants/api_end_point.dart';
import 'package:masaj/core/domain/exceptions/request_exception.dart';
import 'package:masaj/features/gifts/data/model/gift_model.dart';

abstract class GiftsDataSource {
  Future<List<GiftModel>> getGitsCards();
}

class GiftsDataSourceImpl extends GiftsDataSource {
  final NetworkService _networkService;

  GiftsDataSourceImpl({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<List<GiftModel>> getGitsCards() {
    const url = ApiEndPoint.GET_GIFT_CARDS;
    return _networkService.get(url).then((response) {
      if (response.statusCode != 200) {
        throw RequestException(message: response.data);
      }
      final result = response.data;
      log(response.data.toString());
      return result != null
          ? (result as List).map((e) => GiftModel.fromMap(e)).toList()
          : [];
    });
  }
}
