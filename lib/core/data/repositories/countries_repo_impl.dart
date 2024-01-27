import 'package:injectable/injectable.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/features/address/domain/entities/country.dart';
import 'package:masaj/core/domain/repos/countries_repo.dart';

@LazySingleton(as: CountriesRepo)
class CountriesRepoImpl extends CountriesRepo {
  final NetworkService _networkService;

  CountriesRepoImpl(this._networkService);

  @override
  Future<List<Country>> getAll() async {
    final response = await _networkService.get('/Countries/countries');
    return response.data.map((e) => Country.fromMap(e)).toList();
  }
}
