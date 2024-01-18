import 'package:masaj/core/data/clients/cache_service.dart';
import 'package:masaj/core/data/clients/local/shared_preference_local_client.dart';
import 'package:masaj/core/data/clients/network_service.dart';
import 'package:masaj/core/data/datasources/device_type_data_source.dart';
import 'package:masaj/core/data/datasources/external_login_data_source.dart';
import 'package:masaj/core/data/datasources/favorites_remote_data_source.dart';
import 'package:masaj/core/data/device/app_info_service.dart';
import 'package:masaj/core/data/device/device_security_service.dart';
import 'package:masaj/core/data/device/launcher_service.dart';
import 'package:masaj/core/data/device/location_helper.dart';
import 'package:masaj/core/data/device/notification_service.dart';
import 'package:masaj/core/data/device/share_service.dart';
import 'package:masaj/core/data/repositories/favorites_repository.dart';
import 'package:masaj/core/data/services/add_to_apple_wallet_service.dart';
import 'package:masaj/core/data/show_case_helper.dart';
import 'package:masaj/features/account/data/datasources/account_remote_data_source.dart';
import 'package:masaj/features/account/data/repositories/account_repository.dart';
import 'package:masaj/features/account/presentation/blocs/about_us_cubit/about_us_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/contact_us_cubit/contact_us_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/coupon_cubit/coupon_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/coupon_details_cubit/coupon_details_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/favorites_cubit/favorites_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/more_tab_cubit/more_tab_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/points_cubit/points_cubit.dart';
import 'package:masaj/features/account/presentation/blocs/topics_cubit/topics_cubit.dart';
import 'package:masaj/features/address/bloc/map_location_picker_cubit/map_location_picker_cubit.dart';
import 'package:masaj/features/address/repos/address_repo.dart';
import 'package:masaj/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:masaj/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:masaj/features/auth/data/repositories/auth_repository.dart';
import 'package:masaj/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:masaj/features/home/data/datasources/home_remote_data_source.dart';
import 'package:masaj/features/home/data/repositories/home_repository.dart';
import 'package:masaj/features/home/presentation/bloc/home_cubit/home_cubit.dart';
import 'package:masaj/features/home/presentation/bloc/notificaions_cubit/notifications_cubit.dart';
import 'package:masaj/features/intro/data/datasources/intro_local_data_source.dart';
import 'package:masaj/features/intro/data/repositories/intro_repository.dart';
import 'package:masaj/features/intro/presentation/blocs/choose_language_cubit/choose_language_cubit.dart';
import 'package:masaj/features/intro/presentation/blocs/guide_page_cubit/guide_page_cubit.dart';
import 'package:masaj/features/splash/data/datasources/splash_local_data_source.dart';
import 'package:masaj/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:masaj/features/splash/presentation/splash_cubit/splash_cubit.dart';

///Implementing
///
///`Singleton` design pattern
///
///`Flyweight` design pattern
///
///to save specific objects from recreation
class Injector {
  final _flyweightMap = <String, dynamic>{};
  static final _singleton = Injector._internal();

  Injector._internal();

  factory Injector() => _singleton;

  Future<void> init() {
    return Future.wait([sharedPreferenceLocalClient.init()]);
  }

  //===================[WALLLET_CUBIT]===================
  MapLocationPickerCubit get mapLocationBloc =>
      MapLocationPickerCubit(addressRepo);

  AddressRepo get addressRepo =>
      _flyweightMap['addressRepo'] ?? AddressRepo(networkService);

  //===================[SPLASH_CUBIT]===================
  SplashCubit get splashCubit => SplashCubit(
      splashRepository: splashRepository,
      notificationService: notificationService,
      deviceSecurityService: deviceSecurityService);

  SplashRepository get splashRepository =>
      _flyweightMap['splashRepository'] ??
      SplashRepositoryImpl(splashLocalDataSource);

  SharedPreferenceLocalClient get sharedPreferenceLocalClient =>
      _flyweightMap['sharedPreferenceLocalClient'] ??
      SharedPreferenceLocalClient();

  SplashLocalDataSource get splashLocalDataSource =>
      _flyweightMap['splashLocalDataSource'] ??
      SplashLocalDataSourceImpl(cacheService);

  //===================[AUTH_CUBIT]===================
  AuthCubit get authCubit => AuthCubit(
        authRepository: authRepository,
        showCaseHelper: showCaseHelper,
      );

  AuthRepository get authRepository =>
      _flyweightMap['authRepository'] ??= AuthRepositoryImpl(
        authRemoteDataSource,
        authLocalDataSource,
        deviceTypeDataSource,
        notificationService,
        appleExternalDataSource,
        googleExternalDataSource,
      );

  AuthRemoteDataSource get authRemoteDataSource =>
      _flyweightMap['authRemoteDataSource'] ??=
          AuthRemoteDataSourceImpl(networkService);

  AuthLocalDataSource get authLocalDataSource =>
      _flyweightMap['authLocalDataSource'] ??=
          AuthLocalDataSourceImpl(cacheService);

  //===================[GUIDE_PAGE_CUBIT]===================
  GuidePageCubit get guidePageCubit => GuidePageCubit(introRepository);

  IntroRepository get introRepository =>
      _flyweightMap['introRepository'] ??
      IntroRepositoryImpl(introLocalDataSource);

  IntroLocalDataSource get introLocalDataSource =>
      _flyweightMap['introLocalDataSource'] ??
      IntroLocalDataSourceImpl(cacheService);

  //===================[CHOOSE_LANGUAGE_CUBIT]===================
  ChooseLanguageCubit get chooseLanguageCubit =>
      ChooseLanguageCubit(introRepository);

  //===================[HOME_CUBIT]===================
  HomeCubit get homeCubit => HomeCubit(
        homeRepository,
        launcherService,
      );

  HomeRepository get homeRepository =>
      _flyweightMap['homeRepository'] ??= HomeRepositoryImpl(
        homeRemoteDataSource: homeRemoteDataSource,
      );

  HomeRemoteDataSource get homeRemoteDataSource =>
      _flyweightMap['homeRemoteDataSource'] ??=
          HomeRemoteDataSourceImpl(networkService);

  //===================[ABOUT_US_CUBIT]===================
  AboutUsCubit get aboutUsCubit => AboutUsCubit(accountRepository);

  AccountRepository get accountRepository =>
      _flyweightMap['accountRepository'] ??= AccountRepositoryImpl(
          accountRemoteDataSource: accountRemoteDataSource);

  AccountRemoteDataSource get accountRemoteDataSource =>
      _flyweightMap['accountRemoteDataSource'] ??=
          AccountRemoteDataSourceImpl(networkService);

  //===================[TOPICS_CUBIT]===================
  TopicsCubit get topicsCubit => TopicsCubit(accountRepository);

  //===================[CONTACT_US_CUBIT]===================
  ContactUsCubit get contactUsCubit => ContactUsCubit(accountRepository);

  //===================[MORE_TAB_CUBIT]===================
  MoreTabCubit get moreTabCubit => MoreTabCubit(
        accountRepository: accountRepository,
        launcherService: launcherService,
        appInfoService: appInfoService,
        showCaseHelper: showCaseHelper,
      );

  //===================[FAVORITES_CUBIT]===================

  FavoritesCubit get favoritesCubit => FavoritesCubit(favoritesRepository);

  FavoritesRepository get favoritesRepository =>
      _flyweightMap['favoritesRepository'] ??= FavoritesRepositoryImpl(
          favoritesRemoteDataSource: favoritesRemoteDataSource);

  FavoritesRemoteDataSource get favoritesRemoteDataSource =>
      _flyweightMap['favoritesRemoteDataSource'] ??=
          FavoritesRemoteDataSourceImpl(networkService);

  //===================[COUPONS_CUBIT]===================

  CouponCubit get couponCubit => CouponCubit(accountRepository);

  //===================[COUPON_DETAILS_CUBIT]===================

  CouponDetailsCubit get couponDetailsCubit =>
      CouponDetailsCubit(accountRepository);

  //===================[POINTS_CUBIT]===================

  PointsCubit get pointsCubit => PointsCubit(accountRepository);

  //===================[NOTIFICATIONS_CUBIT]===================
  NotificationsCubit get notificationsCubit =>
      NotificationsCubit(homeRepository);

  //===================[SEARCH_BLOC]===================

  //===================[CORE_DATA]===================

  DeviceTypeDataSource get deviceTypeDataSource =>
      _flyweightMap['deviceTypeDataSource'] ??= DeviceTypeDataSourceImpl();

  NetworkService get networkService => _flyweightMap['networkService'] ??=
      NetworkServiceImpl(networkServiceUtil, deviceTypeDataSource);

  NetworkServiceUtil get networkServiceUtil =>
      _flyweightMap['networkServiceUtil'] ??=
          NetworkServiceUtilImpl(cacheService);

  CacheService get cacheService =>
      _flyweightMap['cacheService'] ??= CacheServiceImplV2();

  DeviceSecurityService get deviceSecurityService =>
      _flyweightMap['deviceSecurityService'] ??= DeviceSecurityServiceImpl();

  AppInfoService get appInfoService =>
      _flyweightMap['appInfoService'] ??= AppInfoServiceImpl();

  NotificationService get notificationService =>
      _flyweightMap['notificationService'] ??= NotificationService();

  ExternalLoginDataSource get appleExternalDataSource =>
      _flyweightMap['appleExternalDataSource'] ??=
          AppleExternalLoginDataSourceImpl();

  ExternalLoginDataSource get googleExternalDataSource =>
      _flyweightMap['googleExternalDataSource'] ??=
          GoogleExternalLoginDataSourceImpl();

  LauncherService get launcherService =>
      _flyweightMap['launcherService'] ??= LauncherServiceImpl();

  ShareService get shareService =>
      _flyweightMap['shareService'] ??= ShareServiceImpl();

  LocationHelper get locationHelper =>
      _flyweightMap['locationHelper'] ??= LocationHelperImpl();

  ShowCaseHelper get showCaseHelper =>
      _flyweightMap['showCaseHelper'] ??= ShowCaseHelper(cacheService);

  AddToAppleWalletService get addToAppleWalletService =>
      _flyweightMap['addToAppleWalletService'] ??=
          AddToAppleWalletServiceImpl();
}
