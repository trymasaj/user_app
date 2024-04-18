import 'package:masaj/features/gifts/data/datasource/gifts_datasource.dart';
import 'package:masaj/features/gifts/data/model/gift_model.dart';

abstract class GiftsRepository {
  Future<List<GiftModel>> getGitsCards();
}

class GiftsRepositoryImp extends GiftsRepository {
  final GiftsDataSource _giftsDataSource;

  GiftsRepositoryImp({required GiftsDataSource giftsDataSource})
      : _giftsDataSource = giftsDataSource;
  @override
  Future<List<GiftModel>> getGitsCards() => _giftsDataSource.getGitsCards();
}
