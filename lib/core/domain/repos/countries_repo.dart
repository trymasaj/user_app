import 'package:masaj/features/address/entities/country.dart';

abstract class CountriesRepo {
  Future<List<Country>> getAll();
}
