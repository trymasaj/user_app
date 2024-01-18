import 'package:masaj/core/domain/entities/country.dart';

abstract class CountriesRepo {
  Future<List<Country>> getAll();
}
