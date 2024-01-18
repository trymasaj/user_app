// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../features/quiz/application/quiz_page_cubit.dart' as _i10;
import '../../../features/quiz/data/repositories/quiz_repo_impl.dart' as _i7;
import '../../../features/quiz/domain/repositories/quiz_repo.dart' as _i6;
import '../../domain/repos/countries_repo.dart' as _i8;
import '../clients/cache_service.dart' as _i3;
import '../clients/network_service.dart' as _i5;
import '../datasources/device_type_data_source.dart' as _i4;
import '../repositories/countries_repo_impl.dart' as _i9;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.CacheService>(() => _i3.CacheServiceImplV2());
    gh.lazySingleton<_i4.DeviceTypeDataSource>(
        () => _i4.DeviceTypeDataSourceImpl());
    gh.lazySingleton<_i5.NetworkServiceUtil>(
        () => _i5.NetworkServiceUtilImpl(gh<_i3.CacheService>()));
    gh.lazySingleton<_i5.NetworkService>(() => _i5.NetworkServiceImpl(
          gh<_i5.NetworkServiceUtil>(),
          gh<_i4.DeviceTypeDataSource>(),
        ));
    gh.lazySingleton<_i6.QuizRepo>(() => _i7.QuizRepoImpl(
          gh<_i5.NetworkService>(),
          gh<_i3.CacheService>(),
        ));
    gh.lazySingleton<_i8.CountriesRepo>(
        () => _i9.CountriesRepoImpl(gh<_i5.NetworkService>()));
    gh.factory<_i10.QuizPageCubit>(
        () => _i10.QuizPageCubit(gh<_i6.QuizRepo>()));
    return this;
  }
}
