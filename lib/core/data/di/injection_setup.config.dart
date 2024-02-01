// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../features/address/application/blocs/add_new_address_bloc/update_address_bloc.dart'
    as _i16;
import '../../../features/address/application/blocs/map_location_picker_cubit/map_location_picker_cubit.dart'
    as _i19;
import '../../../features/address/application/blocs/my_addresses_bloc/my_addresses_cubit.dart'
    as _i21;
import '../../../features/address/application/blocs/select_location_bloc/select_location_bloc.dart'
    as _i18;
import '../../../features/address/domain/entities/address.dart' as _i17;
import '../../../features/address/infrastructure/repos/address_repo.dart'
    as _i13;
import '../../../features/address/presentation/pages/map_location_picker.dart'
    as _i20;
import '../../../features/auth/data/datasources/auth_local_datasource.dart'
    as _i8;
import '../../../features/quiz/application/quiz_page_cubit.dart' as _i22;
import '../../../features/quiz/data/repositories/quiz_repo_impl.dart' as _i10;
import '../../../features/quiz/domain/repositories/quiz_repo.dart' as _i9;
import '../../../features/wallet/data/repos/wallet_repo_impl.dart' as _i12;
import '../../../features/wallet/domain/repos/wallet_repo.dart' as _i11;
import '../../domain/repos/countries_repo.dart' as _i14;
import '../clients/cache_service.dart' as _i3;
import '../clients/network_service.dart' as _i6;
import '../datasources/device_type_data_source.dart' as _i5;
import '../device/location_helper.dart' as _i4;
import '../device/notification_service.dart' as _i7;
import '../repositories/countries_repo_impl.dart' as _i15;

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
    gh.lazySingleton<_i4.DeviceLocation>(() => _i4.DeviceLocationImpl());
    gh.lazySingleton<_i5.DeviceTypeDataSource>(
        () => _i5.DeviceTypeDataSourceImpl());
    gh.lazySingleton<_i6.NetworkServiceUtil>(
        () => _i6.NetworkServiceUtilImpl(gh<_i3.CacheService>()));
    gh.singleton<_i7.NotificationService>(_i7.NotificationService());
    gh.lazySingleton<_i8.AuthLocalDataSource>(
        () => _i8.AuthLocalDataSourceImpl(gh<_i3.CacheService>()));
    gh.lazySingleton<_i6.NetworkService>(() => _i6.NetworkServiceImpl(
          gh<_i6.NetworkServiceUtil>(),
          gh<_i5.DeviceTypeDataSource>(),
        ));
    gh.lazySingleton<_i9.QuizRepo>(() => _i10.QuizRepoImpl(
          gh<_i6.NetworkService>(),
          gh<_i3.CacheService>(),
        ));
    gh.lazySingleton<_i11.WalletRepository>(
        () => _i12.WalletRepositoryImpl(gh<_i6.NetworkService>()));
    gh.lazySingleton<_i13.AddressRepo>(() => _i13.AddressRepo(
          gh<_i6.NetworkService>(),
          gh<_i3.CacheService>(),
          gh<_i4.DeviceLocation>(),
          gh<_i8.AuthLocalDataSource>(),
        ));
    gh.lazySingleton<_i14.CountriesRepo>(
        () => _i15.CountriesRepoImpl(gh<_i6.NetworkService>()));
    gh.factoryParam<_i16.EditAddressCubit, _i17.Address, dynamic>((
      oldAddress,
      _,
    ) =>
        _i16.EditAddressCubit(
          gh<_i13.AddressRepo>(),
          oldAddress,
        ));
    gh.factoryParam<_i18.InitiallySelectAreaCubit, _i18.SelectAreaArguments,
        dynamic>((
      arguments,
      _,
    ) =>
        _i18.InitiallySelectAreaCubit(
          gh<_i13.AddressRepo>(),
          arguments,
        ));
    gh.factoryParam<_i19.MapLocationPickerCubit,
        _i20.MapLocationPickerArguments, dynamic>((
      arguments,
      _,
    ) =>
        _i19.MapLocationPickerCubit(
          gh<_i13.AddressRepo>(),
          arguments,
        ));
    gh.lazySingleton<_i21.MyAddressesCubit>(
        () => _i21.MyAddressesCubit(gh<_i13.AddressRepo>()));
    gh.factory<_i18.NotInitiallySelectAreaCubit>(
        () => _i18.NotInitiallySelectAreaCubit(gh<_i13.AddressRepo>()));
    gh.factory<_i22.QuizPageCubit>(
        () => _i22.QuizPageCubit(gh<_i9.QuizRepo>()));
    gh.factory<_i16.AddAddressCubit>(
        () => _i16.AddAddressCubit(gh<_i13.AddressRepo>()));
    return this;
  }
}
