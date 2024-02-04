import 'package:masaj/features/address/domain/entities/country.dart';

abstract class CountriesRepo {
  Future<List<Country>> getAll();
}
